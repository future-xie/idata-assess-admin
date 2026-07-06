package com.rutong.business.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_dept")
public class SysDept extends BaseEntity {

    /** 部门名称 */
    private String deptName;
    /** 显示顺序 */
    private Integer orderNum;

    /** 父部门 ID（可读写，对应 parent_id 列；原 JPA @ManyToOne parent 已移除） */
    @TableField(value = "parent_id")
    private Long parentId;

    /** 祖级列表（如 "0,100,101"，用于 find_in_set 树形查询；由 SysDeptService.insert/update 维护） */
    @TableField(value = "ancestors")
    private String ancestors;
}
