package com.rutong.business.assessment.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 答案变更历史（活动流）。每次答案实际变化时记录一条。
 * createBy / createTime 继承自 BaseEntity（操作人 / 时间）。
 */
@Getter
@Setter
@Entity
@Table(name = "as_answer_history")
public class AsAnswerHistory extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 旧答案 */
    @Column(columnDefinition = "text")
    private String oldValue;

    /** 新答案 */
    @Column(columnDefinition = "text")
    private String newValue;
}
