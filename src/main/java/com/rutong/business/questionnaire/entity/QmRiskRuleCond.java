package com.rutong.business.questionnaire.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险规则条件（多条 AND 组合）：依据某题答案判断。
 */
@Getter
@Setter
@TableName("qm_risk_rule_cond")
public class QmRiskRuleCond extends BaseEntity {

    /** 所属规则 ID */
    private Long ruleId;

    /** 条件题目 ID */
    private Long condQuestionId;

    /** 操作符：EQ/NE/IN */
    private String op;

    /** 条件值（IN 时逗号分隔） */
    private String condValue;
}
