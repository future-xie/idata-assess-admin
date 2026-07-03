package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 问卷章节
 */
@Getter
@Setter
@Entity
@Table(name = "qm_chapter")
public class QmChapter extends BaseEntity {

    /** 所属模板 ID */
    private Long templateId;

    /** 章节名称 */
    private String chapterName;

    /** 排序 */
    private Integer orderNum;

    /** 是否显示（Y/N） */
    private String visible;
}
