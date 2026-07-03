package com.rutong.framework.security.service;

import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.service.SysMenuService;
import com.rutong.business.system.service.SysRoleService;
import com.rutong.business.system.service.SysUserService;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.security.SecurityUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service("ss")
public class PermissionService {
    @Autowired
    private SysRoleService roleService;
    @Autowired
    private SysMenuService menuService;
    @Autowired
    private SysUserService userService;
    /**
     * 获取角色数据权限
     *
     * @param user 用户信息
     * @return 角色权限信息
     */
    public Set<String> getRolePermission(LoginUser user) {
        Set<String> roles = new HashSet<String>();
        // 管理员拥有所有权限
        if (user.getUserId().equals(1L)) {
            roles.add("admin");
        } else {
            roles.addAll(roleService.selectRolePermissionByUserId(user.getUserId()));
        }
        return roles;
    }

    /**
     * 获取菜单数据权限
     *
     * @param user 用户信息
     * @return 菜单权限信息
     */
    public Set<String> getMenuPermission(LoginUser user) {
        Set<String> perms = new HashSet<String>();
        // 管理员拥有所有权限
        if (user.getUserId().equals(1L)) {
            perms.add("*:*:*");
        } else {
            SysUser sysUser = userService.findById(user.getUserId());
            Set<SysRole> roles = sysUser.getRoles();
            if (!CollectionUtils.isEmpty(roles)) {
                // 多角色设置permissions属性，以便数据权限匹配权限
                for (SysRole role : roles) {
                    Set<String> rolePerms = menuService.selectMenuPermsByRoleId(role.getId());
                    perms.addAll(rolePerms);
                }
            } else {
                perms.addAll(menuService.selectMenuPermsByUserId(user.getUserId()));
            }
        }
        return perms;
    }

    /**
     * 验证用户是否具备某权限
     *
     * @param permission 权限字符串
     * @return true=有权限 false=无权限
     */
    public boolean hasPermi(String permission) {
        return SecurityUtils.hasPermi(permission);
    }
}
