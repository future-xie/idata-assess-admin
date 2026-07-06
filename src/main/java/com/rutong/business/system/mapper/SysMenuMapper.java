package com.rutong.business.system.mapper;

import com.rutong.business.system.entity.SysMenu;
import com.rutong.framework.mybatis.MpBaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SysMenuMapper extends MpBaseMapper<SysMenu> {

    /** 用户拥有的权限字符串（join sys_role_menu/sys_user_role） */
    @Select("SELECT DISTINCT m.perms FROM sys_menu m "
            + " LEFT JOIN sys_role_menu rm ON m.id = rm.menu_id "
            + " LEFT JOIN sys_user_role ur ON rm.role_id = ur.role_id "
            + " WHERE ur.user_id = #{userId}")
    List<String> selectMenuPermsByUserId(@Param("userId") Long userId);

    /** 角色拥有的权限字符串 */
    @Select("SELECT DISTINCT m.perms FROM sys_menu m "
            + " LEFT JOIN sys_role_menu rm ON m.id = rm.menu_id "
            + " WHERE rm.role_id = #{roleId}")
    List<String> selectMenuPermsByRoleId(@Param("roleId") Long roleId);

    /** 角色勾选的菜单 ID 列表 */
    @Select("SELECT m.id FROM sys_menu m "
            + " LEFT JOIN sys_role_menu rm ON m.id = rm.menu_id "
            + " WHERE rm.role_id = #{roleId} ORDER BY m.parent_id, m.order_num")
    List<Long> selectMenuIdsByRoleId(@Param("roleId") Long roleId);

    /** 用户的菜单树扁平列表（非按钮，按 parent_id/order_num 排序） */
    @Select("SELECT DISTINCT m.* FROM sys_menu m "
            + " LEFT JOIN sys_role_menu rm ON m.id = rm.menu_id "
            + " LEFT JOIN sys_user_role ur ON rm.role_id = ur.role_id "
            + " WHERE ur.user_id = #{userId} AND m.menu_type <> 'F' "
            + " ORDER BY m.parent_id, m.order_num")
    List<SysMenu> selectMenusByUserId(@Param("userId") Long userId);

    /** 管理员：全部非按钮菜单（构建菜单树） */
    @Select("SELECT * FROM sys_menu WHERE menu_type <> 'F' ORDER BY parent_id, order_num")
    List<SysMenu> selectAllMenusNotButton();

    /** 全部菜单（含按钮 F），用于角色菜单授权树 */
    @Select("SELECT * FROM sys_menu ORDER BY parent_id, order_num")
    List<SysMenu> selectAllMenus();
}
