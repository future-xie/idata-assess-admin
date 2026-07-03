package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 题目选项 / 矩阵行列（题型配置子表，替代 JSON）。
 * optType：
 *   OPTION  —— 单选/多选/下拉的选项
 *   ROW     —— 矩阵题的行
 *   COL     —— 矩阵题的列
 */
@Getter
@Setter
@Entity
@Table(name = "qm_question_option")
public class QmQuestionOption extends BaseEntity {

    /** 所属题目 ID */
    private Long questionId;

    /** 选项类型：OPTION / ROW / COL */
    @Column(length = 16)
    private String optType;

    /** 显示文本 */
    @Column(length = 255)
    private String optLabel;

    /** 选项值 */
    @Column(length = 255)
    private String optValue;

    /** 排序 */
    private Integer orderNum;
}
