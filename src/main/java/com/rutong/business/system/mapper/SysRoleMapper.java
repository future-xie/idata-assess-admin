package com.rutong.business.system.mapper;

import com.rutong.business.system.entity.SysRole;
import com.rutong.framework.mybatis.MpBaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

/**
 * 角色 Mapper：通用 CRUD + 中间表（sys_role_menu/sys_role_dept）维护。
 * 原 JPA 通过 role.menus/role.depts 关联维护中间表，MP 改为直接操作中间表。
 */
public interface SysRoleMapper extends MpBaseMapper<SysRole> {

    @Delete("DELETE FROM sys_role_menu WHERE role_id = #{roleId}")
    int deleteRoleMenu(@Param("roleId") Long roleId);

    @Insert("INSERT INTO sys_role_menu(role_id, menu_id) VALUES(#{roleId}, #{menuId})")
    int insertRoleMenu(@Param("roleId") Long roleId, @Param("menuId") Long menuId);

    @Delete("DELETE FROM sys_role_dept WHERE role_id = #{roleId}")
    int deleteRoleDept(@Param("roleId") Long roleId);

    @Insert("INSERT INTO sys_role_dept(role_id, dept_id) VALUES(#{roleId}, #{deptId})")
    int insertRoleDept(@Param("roleId") Long roleId, @Param("deptId") Long deptId);
}
