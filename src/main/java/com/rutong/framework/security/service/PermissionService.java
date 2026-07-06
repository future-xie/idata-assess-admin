package com.rutong.framework.security.service;

import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.mapper.SysUserMapper;
import com.rutong.business.system.service.SysMenuService;
import com.rutong.business.system.service.SysRoleService;
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
    private SysUserMapper userMapper;

    public Set<String> getRolePermission(LoginUser user) {
        Set<String> roles = new HashSet<>();
        if (user.getUserId().equals(1L)) {
            roles.add("admin");
        } else {
            roles.addAll(roleService.selectRolePermissionByUserId(user.getUserId()));
        }
        return roles;
    }

    public Set<String> getMenuPermission(LoginUser user) {
        Set<String> perms = new HashSet<>();
        if (user.getUserId().equals(1L)) {
            perms.add("*:*:*");
        } else {
            List<SysRole> roles = userMapper.selectRolesByUserId(user.getUserId());
            if (!CollectionUtils.isEmpty(roles)) {
                for (SysRole role : roles) {
                    perms.addAll(menuService.selectMenuPermsByRoleId(role.getId()));
                }
            } else {
                perms.addAll(menuService.selectMenuPermsByUserId(user.getUserId()));
            }
        }
        return perms;
    }

    public boolean hasPermi(String permission) {
        return SecurityUtils.hasPermi(permission);
    }
}
