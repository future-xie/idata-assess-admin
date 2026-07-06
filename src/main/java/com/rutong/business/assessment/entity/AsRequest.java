package com.rutong.business.assessment.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 题目修改请求。审核人/评估人针对某一道题提出的修改请求。
 * 每题可有多条记录,前端用抽屉列表展示。
 * 注：复合索引 idx_as_request_survey_question(survey_id,question_id) 由 SQL/Flyway 维护，非实体注解。
 */
@Getter
@Setter
@TableName("as_request")
public class AsRequest extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 请求内容 */
    private String content;

    /** 发起方：RESPONDENT 受访人 / REVIEWER 审核人（后端按归属自动判定） */
    private String senderType;

    /** 发起人用户 ID */
    private Long senderUserId;
}
