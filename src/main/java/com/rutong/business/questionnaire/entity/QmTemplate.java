package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 问卷模板
 */
@Getter
@Setter
@Entity
@Table(name = "qm_template")
public class QmTemplate extends BaseEntity {

    /** 模板名称 */
    private String templateName;

    /** 分类 / 行业 */
    private String category;

    /** 来源类型：BLANK 空白 / TEMPLATE 模板 / COPY 复制 / IMPORT 导入 */
    private String sourceType;

    /** 状态：DRAFT 草稿 / PUBLISHED 已发布 / ARCHIVED 归档 */
    private String status;

    /** 外观样式配置（字体/颜色/Logo/CSS，JSON） */
    @Column(columnDefinition = "text")
    private String styleConfig;

    /** 说明 */
    @Column(length = 1024)
    private String description;
}
