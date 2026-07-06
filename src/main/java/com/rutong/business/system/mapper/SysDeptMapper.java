package com.rutong.business.system.mapper;

import com.rutong.business.system.entity.SysDept;
import com.rutong.framework.mybatis.MpBaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.Collection;
import java.util.List;

public interface SysDeptMapper extends MpBaseMapper<SysDept> {

    /** 角色勾选的部门 ID 列表（join sys_role_dept） */
    @Select("SELECT d.id FROM sys_dept d "
            + " LEFT JOIN sys_role_dept rd ON d.id = rd.dept_id "
            + " WHERE rd.role_id = #{roleId} ORDER BY d.parent_id, d.order_num")
    List<Long> selectDeptIdsByRoleId(@Param("roleId") Long roleId);

    /** 部门及其所有子部门 ID（find_in_set 递归树，替代原原生 SQL） */
    @Select("SELECT id FROM sys_dept WHERE id = #{deptId} OR find_in_set(#{deptId}, ancestors)")
    List<Long> selectDeptIdsByAncestors(@Param("deptId") Long deptId);

    // ===== 以下复杂 SQL（含 foreach）放在 resources/mapper/system/SysDeptMapper.xml =====

    /** 多个角色勾选的部门 ID（一次性 IN 查询，避免按角色逐个 N+1） */
    List<Long> selectDeptIdsByRoleIds(@Param("roleIds") Collection<Long> roleIds);

    /**
     * 级联更新子孙部门 ancestors：精确前缀替换（旧前缀 → 新前缀），
     * 用 CONCAT+SUBSTRING 而非 REPLACE，避免数字前缀误伤（如 100 / 1000）。
     */
    @Update("UPDATE sys_dept SET ancestors = CONCAT(#{newAncestors}, "
            + "SUBSTRING(ancestors, CHAR_LENGTH(#{oldAncestors}) + 1)) "
            + "WHERE find_in_set(#{deptId}, ancestors)")
    int updateDeptChildrenAncestors(@Param("deptId") Long deptId,
                                    @Param("oldAncestors") String oldAncestors,
                                    @Param("newAncestors") String newAncestors);
}
