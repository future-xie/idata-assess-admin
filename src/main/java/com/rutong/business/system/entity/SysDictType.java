package com.rutong.business.system.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "sys_dict_type")
public class SysDictType extends BaseEntity {

    /** 字典名称 */
    private String dictName;

    /** 字典类型 */
    private String dictType;

    @JsonIgnore
    @OneToMany(mappedBy = "dictType")
    private Set<SysDictData> dictDatas;
}
