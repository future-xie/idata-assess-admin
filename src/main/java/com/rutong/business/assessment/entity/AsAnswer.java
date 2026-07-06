package com.rutong.business.assessment.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 答卷答案（每题一行，原地更新；变更历史见 AsAnswerHistory）
 */
@Getter
@Setter
@TableName("as_answer")
public class AsAnswer extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 答案值（JSON） */
    private String answerValue;

    /** 单题备注（给受访人） */
    private String remark;

    /** 单题风险标记（Y/N） */
    private String riskFlag;
}
