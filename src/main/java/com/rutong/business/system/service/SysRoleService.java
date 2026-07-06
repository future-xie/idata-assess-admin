package com.rutong.business.system.service;

import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.mapper.SysRoleMapper;
import com.rutong.business.system.mapper.SysUserMapper;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 角色 业务层处理
 */
@Service
public class SysRoleService extends MpBaseService<SysRole> {

    @Autowired
    private SysUserMapper userMapper;
    @Autowired
    private SysRoleMapper roleMapper;

    /**
     * 根据用户ID查询角色权限（替代原 dao.findById(SysUser).getRoles()）
     */
    public Set<String> selectRolePermissionByUserId(Long userId) {
        List<SysRole> roles = userMapper.selectRolesByUserId(userId);
        Set<String> permsSet = new HashSet<>();
        for (SysRole perm : roles) {
            if (StringUtils.isNotNull(perm)) {
                permsSet.addAll(Arrays.asList(perm.getRoleKey().trim().split(",")));
            }
        }
        return permsSet;
    }

    public List<SysRole> selectRoleAll() {
        return list();
    }

    public boolean checkRoleNameUnique(SysRole role) {
        Long roleId = StringUtils.isNull(role.getId()) ? -1L : role.getId();
        SysRole info = lambdaQuery().eq(SysRole::getRoleName, role.getRoleName()).one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != roleId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    public boolean checkRoleKeyUnique(SysRole role) {
        Long roleId = StringUtils.isNull(role.getId()) ? -1L : role.getId();
        SysRole info = lambdaQuery().eq(SysRole::getRoleKey, role.getRoleKey()).one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != roleId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 新增角色 + 维护角色-部门中间表（前端传入 role.depts 含 id）
     */
    @Transactional(rollbackFor = Exception.class)
    public int insertRole(SysRole role) {
        int row = super.insert(role);
        replaceRoleDept(role);
        return row;
    }

    /**
     * 修改角色 + 重建角色-部门中间表（菜单关联由 authMenu 单独维护，此处不动）
     */
    @Transactional(rollbackFor = Exception.class)
    public int updateRole(SysRole role) {
        int row = super.update(role);
        replaceRoleDept(role);
        return row;
    }

    private void replaceRoleDept(SysRole role) {
        if (role.getId() == null) {
            return;
        }
        roleMapper.deleteRoleDept(role.getId());
        Set<SysDept> depts = role.getDepts();
        if (depts != null) {
            for (SysDept d : depts) {
                if (d != null && d.getId() != null) {
                    roleMapper.insertRoleDept(role.getId(), d.getId());
                }
            }
        }
    }

    /**
     * 授权角色菜单（先清空 sys_role_menu，再批量插入）
     */
    @Transactional(rollbackFor = Exception.class)
    public void authMenu(Long roleId, List<Long> menuIds) {
        SysRole role = findById(roleId);
        if (role == null) {
            throw new ServiceException("角色不存在");
        }
        roleMapper.deleteRoleMenu(roleId);
        if (menuIds != null) {
            for (Long menuId : menuIds) {
                if (menuId != null) {
                    roleMapper.insertRoleMenu(roleId, menuId);
                }
            }
        }
    }
}
