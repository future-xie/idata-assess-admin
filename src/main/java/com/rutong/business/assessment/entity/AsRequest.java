package com.rutong.business.assessment.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 题目修改请求。审核人/评估人针对某一道题提出的修改请求。
 * 每题可有多条记录,前端用抽屉列表展示。
 */
@Getter
@Setter
@Entity
@Table(name = "as_request", indexes = {
        @Index(name = "idx_as_request_survey_question", columnList = "survey_id,question_id")
})
public class AsRequest extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 请求内容 */
    @Column(length = 2000)
    private String content;

    /** 发起方：RESPONDENT 受访人 / REVIEWER 审核人（后端按归属自动判定） */
    @Column(length = 16)
    private String senderType;

    /** 发起人用户 ID */
    private Long senderUserId;
}
