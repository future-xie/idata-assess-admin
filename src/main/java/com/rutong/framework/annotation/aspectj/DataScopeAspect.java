package com.rutong.framework.annotation.aspectj;

import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.service.SysDeptService;
import com.rutong.business.system.service.SysUserService;
import com.rutong.framework.annotation.DataScope;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.security.context.DataScopeContext;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 数据权限过滤切面
 * 在标注了 @DataScope 的 Service 方法执行前：
 * 1. 解析当前用户角色的 dataScope，计算允许的部门 ID
 * 2. 根据部门 ID 反查出对应的用户名集合
 * 3. 存入 DataScopeContext，DaoImpl 按 createBy IN (用户名) 过滤
 */
@Aspect
@Component
public class DataScopeAspect {

    private static final Logger log = LoggerFactory.getLogger(DataScopeAspect.class);

    private static final String DATA_SCOPE_ALL = "1";
    private static final String DATA_SCOPE_CUSTOM = "2";
    private static final String DATA_SCOPE_DEPT = "3";
    private static final String DATA_SCOPE_DEPT_AND_CHILD = "4";
    private static final String DATA_SCOPE_SELF = "5";

    @Autowired
    private SysUserService userService;

    @Autowired
    private SysDeptService deptService;

    @Before("@annotation(dataScope)")
    public void doBefore(JoinPoint point, DataScope dataScope) {
        try {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null) {
                return;
            }

            DataScopeContext context = new DataScopeContext();
            context.setUserAlias(dataScope.userAlias());

            // 管理员拥有全部数据权限
            if (SecurityUtils.isAdmin(loginUser.getUserId())) {
                context.setAll(true);
                DataScopeContext.set(context);
                return;
            }

            // 查询用户所有角色
            SysUser user = userService.findById(loginUser.getUserId());
            if (user == null || user.getRoles() == null || user.getRoles().isEmpty()) {
                // 无角色则仅本人
                context.setCreateBy(loginUser.getUsername());
                DataScopeContext.set(context);
                return;
            }

            // 解析最宽松的 dataScope，计算允许的部门 ID
            String bestScope = resolveBestScope(user.getRoles());
            Set<Long> allowedDeptIds = resolveAllowedDeptIds(bestScope, user.getRoles(), loginUser.getDeptId());

            if (allowedDeptIds == null) {
                // scope=1 全部数据
                context.setAll(true);
            } else if (allowedDeptIds.isEmpty()) {
                // 无匹配部门，回退到仅本人
                context.setCreateBy(loginUser.getUsername());
            } else {
                // 根据部门反查用户名集合
                Set<String> usernames = findUsernamesByDeptIds(allowedDeptIds);
                if (usernames.isEmpty()) {
                    context.setCreateBy(loginUser.getUsername());
                } else {
                    context.setCreateByList(usernames);
                }
            }

            DataScopeContext.set(context);
        } catch (Exception e) {
            log.error("数据权限过滤异常", e);
            // 异常时不加过滤，避免阻断正常查询
        }
    }

    @After("@annotation(dataScope)")
    public void doAfter(JoinPoint point, DataScope dataScope) {
        DataScopeContext.clear();
    }

    /**
     * 解析多个角色中最宽松的 dataScope
     * 优先级：1(全部) > 2(自定义) > 4(本部门及以下) > 3(本部门) > 5(仅本人)
     */
    private String resolveBestScope(Set<SysRole> roles) {
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

    /**
     * 根据 dataScope 计算允许的部门 ID 集合
     * 返回 null 表示全部数据，返回空集合表示无权限
     */
    private Set<Long> resolveAllowedDeptIds(String scope, Set<SysRole> roles, Long userDeptId) {
        switch (scope) {
            case DATA_SCOPE_ALL:
                return null;
            case DATA_SCOPE_CUSTOM:
                return getCustomDeptIds(roles);
            case DATA_SCOPE_DEPT:
                return Collections.singleton(userDeptId);
            case DATA_SCOPE_DEPT_AND_CHILD:
                return deptService.getChildrenByDeptId(userDeptId);
            case DATA_SCOPE_SELF:
                return Collections.emptySet();
            default:
                return Collections.emptySet();
        }
    }

    /**
     * 获取自定义数据权限的部门 ID 集合（从 sys_role_dept / 角色关联的部门）
     */
    private Set<Long> getCustomDeptIds(Set<SysRole> roles) {
        Set<Long> deptIds = new HashSet<>();
        for (SysRole role : roles) {
            if (DATA_SCOPE_CUSTOM.equals(role.getDataScope()) && role.getDepts() != null) {
                deptIds.addAll(role.getDepts().stream()
                        .map(SysDept::getId)
                        .collect(Collectors.toSet()));
            }
        }
        return deptIds;
    }

    /**
     * 根据部门 ID 集合，查询这些部门下所有用户的用户名
     */
    private Set<String> findUsernamesByDeptIds(Set<Long> deptIds) {
        Set<String> usernames = new HashSet<>();
        for (Long deptId : deptIds) {
            List<SysUser> users = userService.findByDeptId(deptId);
            for (SysUser u : users) {
                if (u.getUserName() != null) {
                    usernames.add(u.getUserName());
                }
            }
        }
        return usernames;
    }
}
