package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 题目间逻辑关系（显示逻辑，结构化存储，不使用 JSON）。
 * <p>
 * 含义：当 {@code condQuestionId} 的答案满足 {@code op condValue} 时，
 * 对目标题目 {@code questionId} 执行 {@code action}（SHOW 显示 / HIDE 隐藏）。
 */
@Getter
@Setter
@Entity
@Table(name = "qm_question_logic")
public class QmQuestionLogic extends BaseEntity {

    /** 目标题目 ID（受本规则控制的题目） */
    private Long questionId;

    /** 条件题目 ID（取其答案参与判断） */
    private Long condQuestionId;

    /** 操作符：EQ 等于 / NE 不等于 / IN 包含于(逗号分隔) */
    @Column(length = 16)
    private String op;

    /** 条件值（IN 时为逗号分隔的多个值） */
    @Column(length = 512)
    private String condValue;

    /** 动作：SHOW 显示 / HIDE 隐藏 */
    @Column(length = 8)
    private String action;
}
