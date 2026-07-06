package com.rutong.framework.mybatis;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.handler.DataPermissionHandler;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.mapper.SysDeptMapper;
import com.rutong.business.system.mapper.SysUserMapper;
import com.rutong.business.system.service.SysDeptService;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.utils.SpringUtils;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.Parenthesis;
import net.sf.jsqlparser.expression.StringValue;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.schema.Column;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 数据权限处理器（配合 MyBatis-Plus {@link com.baomidou.mybatisplus.extension.plugins.inner.DataPermissionInterceptor}）。
 * <p>
 * 替代旧的 @DataScope 注解 + DataScopeAspect + DataScopeContext（ThreadLocal）方案：
 * 仅对 {@link #SCOPED_MAPPERS} 中的 Mapper 生成的查询追加 create_by 条件，
 * 条件值由当前用户角色的 dataScope（全部/自定义/本部门/本部门及以下/仅本人）解析得到。
 * <p>
 * 管理员、无登录上下文、非配置表 → 不追加条件（原样返回 where）。
 * 评估模块 as_* 不在此列（受访人/评估人自定义可见性），系统表 sys_menu/role/dept 等也不在此列（影响登录）。
 */
@Component
public class DataPermissionHandlerImpl implements DataPermissionHandler {

    private static final Logger log = LoggerFactory.getLogger(DataPermissionHandlerImpl.class);

    /** 受数据权限拦截的 Mapper 限定名（这些 Mapper 的 selectList/selectPage/selectCount 会被追加 create_by 条件） */
    private static final Set<String> SCOPED_MAPPERS = Set.of(
            "com.rutong.business.questionnaire.mapper.QmTemplateMapper",
            "com.rutong.business.questionnaire.mapper.QmRiskLibMapper"
    );

    private static final String DATA_SCOPE_ALL = "1";
    private static final String DATA_SCOPE_CUSTOM = "2";
    private static final String DATA_SCOPE_DEPT = "3";
    private static final String DATA_SCOPE_DEPT_AND_CHILD = "4";
    private static final String DATA_SCOPE_SELF = "5";

    // 通过 SpringUtils 取 bean（而非 @Autowired）：handler 在 sqlSessionFactory 创建期被拦截器引用，
    // 直接注入 service/mapper 会与之形成循环依赖（→ BeanCurrentlyInCreationException）；
    // 改为查询时按需获取（此时 Spring 容器已建完），并缓存到实例字段避免重复 getBean。
    private SysDeptService deptService;
    private SysUserMapper userMapper;
    private SysDeptMapper deptMapper;

    private SysDeptService deptService() {
        if (deptService == null) deptService = SpringUtils.getBean(SysDeptService.class);
        return deptService;
    }
    private SysUserMapper userMapper() {
        if (userMapper == null) userMapper = SpringUtils.getBean(SysUserMapper.class);
        return userMapper;
    }
    private SysDeptMapper deptMapper() {
        if (deptMapper == null) deptMapper = SpringUtils.getBean(SysDeptMapper.class);
        return deptMapper;
    }

    @Override
    public Expression getSqlSegment(Expression where, String mappedStatementId) {
        try {
            if (!isScoped(mappedStatementId)) {
                return where;
            }
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null || SecurityUtils.isAdmin(loginUser.getUserId())) {
                return where;
            }
            Set<String> usernames = resolveAllowedUsernames(loginUser);
            if (usernames == null) {
                return where; // ALL 权限，不限制
            }
            Expression filter = buildCreateByExpression(usernames);
            return where == null ? filter : new AndExpression(where, filter);
        } catch (Exception e) {
            log.error("数据权限拦截异常: {}", mappedStatementId, e);
            return where;
        }
    }

    private boolean isScoped(String mappedStatementId) {
        if (mappedStatementId == null) {
            return false;
        }
        for (String mapper : SCOPED_MAPPERS) {
            if (mappedStatementId.startsWith(mapper + ".")) {
                return true;
            }
        }
        return false;
    }

    /**
     * 解析当前用户允许的 createBy 用户名集合。
     * @return null 表示全部数据（ALL）；非空集合（含仅本人时落入自己的用户名）为可见创建人。
     */
    private Set<String> resolveAllowedUsernames(LoginUser loginUser) {
        List<SysRole> roles = userMapper().selectRolesByUserId(loginUser.getUserId());
        if (roles == null || roles.isEmpty()) {
            return Collections.singleton(loginUser.getUsername());
        }
        String bestScope = resolveBestScope(roles);
        Set<Long> allowedDeptIds = resolveAllowedDeptIds(bestScope, roles, loginUser.getDeptId());
        if (allowedDeptIds == null) {
            return null; // ALL
        }
        if (allowedDeptIds.isEmpty()) {
            return Collections.singleton(loginUser.getUsername()); // SELF
        }
        Set<String> usernames = findUsernamesByDeptIds(allowedDeptIds);
        return usernames.isEmpty() ? Collections.singleton(loginUser.getUsername()) : usernames;
    }

    private String resolveBestScope(List<SysRole> roles) {
        String bestScope = DATA_SCOPE_SELF;
        for (SysRole role : roles) {
            String scope = role.getDataScope();
            if (scope == null) {
                continue;
            }
            if (DATA_SCOPE_ALL.equals(scope)) {
                return DATA_SCOPE_ALL;
            }
            if (scopeRank(scope) < scopeRank(bestScope)) {
                bestScope = scope;
            }
        }
        return bestScope;
    }

    private int scopeRank(String scope) {
        switch (scope) {
            case DATA_SCOPE_ALL: return 0;
            case DATA_SCOPE_CUSTOM: return 1;
            case DATA_SCOPE_DEPT_AND_CHILD: return 2;
            case DATA_SCOPE_DEPT: return 3;
            case DATA_SCOPE_SELF: return 4;
            default: return 5;
        }
    }

    private Set<Long> resolveAllowedDeptIds(String scope, List<SysRole> roles, Long userDeptId) {
        switch (scope) {
            case DATA_SCOPE_ALL:
                return null;
            case DATA_SCOPE_CUSTOM:
                return getCustomDeptIds(roles);
            case DATA_SCOPE_DEPT:
                return Collections.singleton(userDeptId);
            case DATA_SCOPE_DEPT_AND_CHILD:
                return deptService().getChildrenByDeptId(userDeptId);
            case DATA_SCOPE_SELF:
                return Collections.emptySet();
            default:
                return Collections.emptySet();
        }
    }

    /** 自定义数据权限：一次性查所有自定义角色的 sys_role_dept 关联部门（避免按角色逐个查询） */
    private Set<Long> getCustomDeptIds(List<SysRole> roles) {
        List<Long> customRoleIds = roles.stream()
                .filter(r -> DATA_SCOPE_CUSTOM.equals(r.getDataScope()))
                .map(SysRole::getId)
                .collect(Collectors.toList());
        if (customRoleIds.isEmpty()) {
            return Collections.emptySet();
        }
        return new HashSet<>(deptMapper().selectDeptIdsByRoleIds(customRoleIds));
    }

    /** 一次性按部门集合查用户名（避免按部门逐个查询的 N+1） */
    private Set<String> findUsernamesByDeptIds(Set<Long> deptIds) {
        if (deptIds == null || deptIds.isEmpty()) {
            return Collections.emptySet();
        }
        List<SysUser> users = userMapper().selectList(
                new LambdaQueryWrapper<SysUser>()
                        .select(SysUser::getUserName)
                        .in(SysUser::getDeptId, deptIds));
        Set<String> usernames = new HashSet<>();
        for (SysUser u : users) {
            if (u.getUserName() != null) {
                usernames.add(u.getUserName());
            }
        }
        return usernames;
    }

    /**
     * 构建 create_by 过滤表达式。用 OR 链（create_by = 'u1' OR create_by = 'u2' ...）而非 IN(...)，
     * 仅依赖 EqualsTo/OrExpression/Parenthesis —— 跨 JSqlParser 4.6/4.9 均稳定（4.9 移除了 ItemsList/InExpression 的列表 API）。
     * 用 Parenthesis 包裹，确保与原 where 做 AND 时结合正确。
     */
    private Expression buildCreateByExpression(Set<String> usernames) {
        Expression result = null;
        for (String u : usernames) {
            EqualsTo eq = new EqualsTo(new Column("create_by"), new StringValue(u));
            result = (result == null) ? eq : new OrExpression(result, eq);
        }
        return new Parenthesis(result);
    }
}
