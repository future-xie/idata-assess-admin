package com.rutong.business.system.service;

import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 角色 业务层处理
 */
@Service
public class SysRoleService extends BaseService<SysRole> {

    /**
     * 根据用户ID查询权限
     *
     * @param userId 用户ID
     * @return 权限列表
     */
    public Set<String> selectRolePermissionByUserId(Long userId) {
        SysUser sysUser = dao.findById(SysUser.class,userId);
        Set<SysRole> perms = sysUser.getRoles();
        Set<String> permsSet = new HashSet<>();
        for (SysRole perm : perms) {
            if (StringUtils.isNotNull(perm)) {
                permsSet.addAll(Arrays.asList(perm.getRoleKey().trim().split(",")));
            }
        }
        return permsSet;
    }

    /**
     * 查询所有角色
     *
     * @return 角色列表
     */
    public List<SysRole> selectRoleAll() {
        return dao.findAll(SysRole.class);
    }

    /**
     * 校验角色名称是否唯一
     *
     * @param role 角色信息
     * @return 结果
     */
    public boolean checkRoleNameUnique(SysRole role) {
        Long roleId = StringUtils.isNull(role.getId()) ? -1L : role.getId();
        SysRole info = dao.findByPropertyFirst(SysRole.class, "roleName", role.getRoleName());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != roleId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验角色权限是否唯一
     *
     * @param role 角色信息
     * @return 结果
     */
    public boolean checkRoleKeyUnique(SysRole role) {
        Long roleId = StringUtils.isNull(role.getId()) ? -1L : role.getId();
        SysRole info = dao.findByPropertyFirst(SysRole.class, "roleKey", role.getRoleKey());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != roleId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 新增保存角色信息
     *
     * @param role 角色信息（含 depts 关联）
     * @return 结果
     */
    @Transactional
    public int insertRole(SysRole role) {
        // 处理部门关联：将前端传入的 { id } 对象替换为托管的实体
        Set<SysDept> depts = role.getDepts();
        if (depts != null && !depts.isEmpty()) {
            Set<SysDept> managedDepts = new HashSet<>();
            for (SysDept dept : depts) {
                SysDept managed = dao.findById(SysDept.class, dept.getId());
                if (managed != null) {
                    managedDepts.add(managed);
                }
            }
            role.setDepts(managedDepts);
        }
        return super.insert(role);
    }

    /**
     * 修改保存角色信息
     *
     * @param role 角色信息（含 depts 关联）
     * @return 结果
     */
    @Transactional
    public int updateRole(SysRole role) {
        // 从数据库加载已有角色，保留 menus 关联（前端不会传 menus）
        SysRole existing = findById(role.getId());
        if (existing != null) {
            role.setMenus(existing.getMenus());
        }
        // 处理部门关联：将前端传入的 { id } 对象替换为托管的实体
        Set<SysDept> depts = role.getDepts();
        if (depts != null) {
            Set<SysDept> managedDepts = new HashSet<>();
            for (SysDept dept : depts) {
                SysDept managed = dao.findById(SysDept.class, dept.getId());
                if (managed != null) {
                    managedDepts.add(managed);
                }
            }
            role.setDepts(managedDepts);
        }
        return super.update(role);
    }

    /**
     * 授权角色菜单
     *
     * @param roleId  角色ID
     * @param menuIds 菜单ID数组
     */
    @Transactional
    public void authMenu(Long roleId, List<Long> menuIds) {
        SysRole role = findById(roleId);
        if (role == null) {
            throw new ServiceException("角色不存在");
        }
        // 清空原有菜单关联
        role.setMenus(new HashSet<>());
        // 设置新的菜单关联
        if (menuIds != null && !menuIds.isEmpty()) {
            Set<SysMenu> menus = new HashSet<>();
            for (Long menuId : menuIds) {
                SysMenu menu = dao.findById(SysMenu.class, menuId);
                if (menu != null) {
                    menus.add(menu);
                }
            }
            role.setMenus(menus);
        }
        dao.update(role);
    }

}
