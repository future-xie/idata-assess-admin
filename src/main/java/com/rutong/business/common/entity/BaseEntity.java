package com.rutong.business.common.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * 实体基类（MyBatis-Plus）。
 * 审计字段由 AutoMetaObjectHandler 按 @TableField(fill) 自动填充：INSERT 填四字段，UPDATE 填 updateBy/updateTime。
 */
@Getter
@Setter
public abstract class BaseEntity implements Serializable {

    @TableId(type = IdType.AUTO)
    protected Long id;

    /** 创建者 */
    @TableField(value = "create_by", fill = FieldFill.INSERT)
    protected String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    protected Date createTime;

    /** 更新者 */
    @TableField(value = "update_by", fill = FieldFill.INSERT_UPDATE)
    protected String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "update_time", fill = FieldFill.INSERT_UPDATE)
    protected Date updateTime;

    /** 备注 */
    @TableField(value = "remark")
    protected String remark;

}
