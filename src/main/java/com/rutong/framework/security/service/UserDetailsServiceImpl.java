package com.rutong.framework.security.service;

import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.service.SysDeptService;
import com.rutong.business.system.service.SysUserService;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 用户验证处理
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private SysUserService userService;

    @Autowired
    private PasswordService passwordService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private SysDeptService deptService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        SysUser user = userService.findByUserName(username);
        if (StringUtils.isNull(user)) {
            log.info("登录用户：{} 不存在.", username);
            throw new ServiceException("用户不存在");
        } else if (("0").equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", username);
            throw new ServiceException("账号已被停用");
        }
        passwordService.validate(user);
        return createLoginUser(user);
    }

    public UserDetails createLoginUser(SysUser user) {
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(user.getId());
        loginUser.setNickName(user.getNickName());
        loginUser.setUsername(user.getUserName());
        loginUser.setPassword(user.getPassword());

        loginUser.setDeptId(user.getDeptId());
        if (user.getDeptId() != null) {
            SysDept dept = deptService.findById(user.getDeptId());
            if (dept != null) {
                loginUser.setDeptName(dept.getDeptName());
            }
        }
        loginUser.setPermissions(permissionService.getMenuPermission(loginUser));
        return loginUser;
    }
}
