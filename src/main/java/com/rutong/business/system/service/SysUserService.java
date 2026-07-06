package com.rutong.business.system.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.mapper.SysUserMapper;
import com.rutong.business.system.query.SysUserQuery;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户 业务层处理
 */
@Service
public class SysUserService extends MpBaseService<SysUser> {

    @Autowired
    private SysUserMapper userMapper;

    public SysUser findByUserName(String userName) {
        return lambdaQuery().eq(SysUser::getUserName, userName).one();
    }

    /**
     * 用户分页（关联 sys_dept，含部门名称 deptName）。
     * 用自定义 SQL 替代通用 Wrapper，以便 join 部门表。
     */
    public TableDataInfo listUserPage(PageBean page, SysUserQuery query) {
        Page<SysUser> result = userMapper.selectUserPage(page.toPage(), query);
        TableDataInfo rsp = new TableDataInfo();
        rsp.setTotal(result.getTotal());
        rsp.setRows(result.getRecords());
        rsp.setCode(200);
        rsp.setMsg("查询成功");
        return rsp;
    }

    /** 覆盖父类：新增用户后维护 sys_user_role */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insert(SysUser user) {
        int rows = super.insert(user);
        replaceUserRoles(user.getId(), user.getRoleIds());
        return rows;
    }

    /** 覆盖父类：编辑用户后替换角色关联（仅当传了 roleIds） */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(SysUser user) {
        int rows = super.update(user);
        if (user.getRoleIds() != null) {
            replaceUserRoles(user.getId(), user.getRoleIds());
        }
        return rows;
    }

    /** 替换用户角色关联：先清空再批量插入 */
    private void replaceUserRoles(Long userId, List<Long> roleIds) {
        if (userId == null) {
            return;
        }
        userMapper.deleteUserRolesByUserId(userId);
        if (roleIds != null && !roleIds.isEmpty()) {
            userMapper.insertUserRoles(userId, roleIds);
        }
    }

    public List<SysUser> findByDeptId(Long deptId) {
        return lambdaQuery().eq(SysUser::getDeptId, deptId).list();
    }

    /**
     * 查询用户所属角色组（名称），替代原 user.getRoles()
     */
    public String selectUserRoleGroup(SysUser user) {
        List<SysRole> roles = userMapper.selectRolesByUserId(user.getId());
        if (CollectionUtils.isEmpty(roles)) {
            return StringUtils.EMPTY;
        }
        return roles.stream().map(SysRole::getRoleName).collect(Collectors.joining(","));
    }

    /** 查询用户关联的角色列表（替代原 JPA user.getRoles()） */
    public List<SysRole> selectRolesByUserId(Long userId) {
        return userMapper.selectRolesByUserId(userId);
    }

    public boolean checkUserNameUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = findByUserName(user.getUserName());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    public boolean checkPhoneUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = lambdaQuery().eq(SysUser::getPhonenumber, user.getPhonenumber()).one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    public boolean checkEmailUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = lambdaQuery().eq(SysUser::getEmail, user.getEmail()).one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    public void checkUserAllowed(Long userId) {
        if (SysUser.isAdmin(userId)) {
            throw new ServiceException("不允许操作超级管理员用户");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public int updateUserStatus(SysUser user) {
        return lambdaUpdate().set(SysUser::getStatus, user.getStatus())
                .eq(SysUser::getId, user.getId()).update() ? 1 : 0;
    }

    @Transactional(rollbackFor = Exception.class)
    public int updateUserProfile(SysUser user) {
        return super.update(user);
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean updateUserAvatar(String userName, String avatar) {
        return lambdaUpdate().set(SysUser::getAvatar, avatar)
                .eq(SysUser::getUserName, userName).update();
    }

    @Transactional(rollbackFor = Exception.class)
    public int resetUserPwd(Long userId, String password) {
        return lambdaUpdate().set(SysUser::getPassword, password)
                .eq(SysUser::getId, userId).update() ? 1 : 0;
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteUserByIds(Long[] userIds) {
        for (Long userId : userIds) {
            checkUserAllowed(userId);
        }
        // 先清理用户-角色关联，再删用户主表，避免中间表残留
        userMapper.deleteUserRoleByUserIds(java.util.Arrays.asList(userIds));
        return deleteByIds(userIds);
    }
}
