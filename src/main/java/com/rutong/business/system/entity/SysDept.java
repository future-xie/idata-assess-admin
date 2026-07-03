package com.rutong.business.system.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "sys_dept")
public class SysDept extends BaseEntity {

    /** 部门名称 */
    private String deptName;

    /** 显示顺序 */
    private Integer orderNum;

    @Column(name = "parent_id", insertable = false, updatable = false)
    private Long parentId;

    /** 上级部门（仅写入，不序列化到前端） */
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private SysDept parent;

    @JsonIgnore
    @OrderBy(value = "id")
    @OneToMany(mappedBy = "parent")
    private Set<SysDept> children  = new HashSet<>();

    @JsonIgnore
    @OneToMany(mappedBy = "dept")
    private Set<SysUser> users  = new HashSet<>();

    @JsonIgnore
    @ManyToMany(mappedBy = "depts")
    private Set<SysRole> roles = new HashSet<>();
}
