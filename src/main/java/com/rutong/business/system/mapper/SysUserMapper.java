package com.rutong.business.system.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.query.SysUserQuery;
import com.rutong.framework.mybatis.MpBaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Collection;
import java.util.List;

public interface SysUserMapper extends MpBaseMapper<SysUser> {

    /** 查询用户关联的角色（join sys_user_role/sys_role） */
    @Select("SELECT r.* FROM sys_role r "
            + " LEFT JOIN sys_user_role ur ON r.id = ur.role_id "
            + " WHERE ur.user_id = #{userId}")
    List<SysRole> selectRolesByUserId(@Param("userId") Long userId);

    /** 清空用户的全部角色关联 */
    @Delete("DELETE FROM sys_user_role WHERE user_id = #{userId}")
    int deleteUserRolesByUserId(@Param("userId") Long userId);

    // ===== 以下复杂 SQL（含动态条件 / foreach）放在 resources/mapper/system/SysUserMapper.xml =====

    /** 删除用户-角色关联（批量） */
    int deleteUserRoleByUserIds(@Param("userIds") Collection<Long> userIds);

    /** 用户分页（关联 sys_dept 取部门名，支持 deptId/deptIds/userName/phonenumber/status 过滤） */
    Page<SysUser> selectUserPage(Page<SysUser> page, @Param("query") SysUserQuery query);

    /** 批量插入用户-角色关联 */
    int insertUserRoles(@Param("userId") Long userId, @Param("roleIds") Collection<Long> roleIds);
}
