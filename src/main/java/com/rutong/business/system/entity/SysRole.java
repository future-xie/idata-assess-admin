package com.rutong.business.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@TableName("sys_role")
public class SysRole extends BaseEntity {

    /** 角色名称 */
    private String roleName;
    /** 角色权限 */
    private String roleKey;
    /** 角色排序 */
    private Integer roleSort;
    /** 数据范围（1全部 2自定义 3本部门 4本部门及以下 5仅本人） */
    private String dataScope;

    /** 关联的部门（仅接收前端传入的 {id}，不持久化；中间表 sys_role_dept 由 Service/Mapper 维护） */
    @TableField(exist = false)
    private Set<SysDept> depts = new HashSet<>();
}
