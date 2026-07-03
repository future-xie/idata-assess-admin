package com.rutong.business.system.service;

import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 用户 业务层处理
 */
@Service
public class SysUserService extends BaseService<SysUser> {

    /**
     * 通过用户名查询用户
     *
     * @param userName 用户名
     * @return 用户对象信息
     */
    public SysUser findByUserName(String userName) {
        return dao.findByPropertyFirst(SysUser.class, "userName", userName);
    }

    /**
     * 根据部门ID查询该部门下的所有用户
     *
     * @param deptId 部门ID
     * @return 用户列表
     */
    public List<SysUser> findByDeptId(Long deptId) {
        return dao.findByProperty(SysUser.class, "dept.id", deptId);
    }

    /**
     * 查询用户所属角色组
     *
     * @param user 用户
     * @return 结果
     */
    public String selectUserRoleGroup(SysUser user) {
        Set<SysRole> list = user.getRoles();
        if (CollectionUtils.isEmpty(list)) {
            return StringUtils.EMPTY;
        }
        return list.stream().map(SysRole::getRoleName).collect(Collectors.joining(","));
    }

    /**
     * 校验用户名称是否唯一
     *
     * @param user 用户信息
     * @return 结果
     */
    public boolean checkUserNameUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = findByUserName(user.getUserName());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验手机号码是否唯一
     *
     * @param user 用户信息
     * @return 结果
     */
    public boolean checkPhoneUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = dao.findByPropertyFirst(SysUser.class, "phonenumber", user.getPhonenumber());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验email是否唯一
     *
     * @param user 用户信息
     * @return 结果
     */
    public boolean checkEmailUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getId()) ? -1L : user.getId();
        SysUser info = dao.findByPropertyFirst(SysUser.class, "email", user.getEmail());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != userId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验用户是否允许操作
     *
     * @param userId 用户ID
     */
    public void checkUserAllowed(Long userId) {
        if (SysUser.isAdmin(userId)) {
            throw new ServiceException("不允许操作超级管理员用户");
        }
    }

    /**
     * 修改用户状态
     */
    @Transactional
    public int updateUserStatus(SysUser user) {
        return dao.executeUpdate("update SysUser u set u.status = ?1 where u.id = ?2", user.getStatus(), user.getId());
    }

    /**
     * 修改用户基本信息
     */
    @Transactional
    public int updateUserProfile(SysUser user) {
        return super.update(user);
    }

    /**
     * 修改用户头像
     */
    @Transactional
    public boolean updateUserAvatar(String userName, String avatar) {
        return dao.executeUpdate("update SysUser u set u.avatar = ?1 where u.userName = ?2", avatar, userName) > 0;
    }

    /**
     * 重置用户密码
     */
    @Transactional
    public int resetUserPwd(Long userId, String password) {
        return dao.executeUpdate("update SysUser u set u.password = ?1 where u.id = ?2", password, userId);
    }

    /**
     * 批量删除用户信息
     */
    @Transactional
    public int deleteUserByIds(Long[] userIds) {
        for (Long userId : userIds) {
            checkUserAllowed(userId);
        }
        return super.deleteByIds(userIds);
    }
}
