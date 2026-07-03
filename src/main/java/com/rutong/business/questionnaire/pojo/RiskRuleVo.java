package com.rutong.business.questionnaire.pojo;

import com.rutong.business.questionnaire.entity.QmRiskRule;
import com.rutong.business.questionnaire.entity.QmRiskRuleCond;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 风险规则视图：规则字段 + 条件列表 + 风险库回显信息。
 */
@Getter
@Setter
public class RiskRuleVo extends QmRiskRule {

    /** 条件列表 */
    private List<QmRiskRuleCond> conditions = new ArrayList<>();

    /** 风险库名称（回显/生成风险用） */
    private String riskName;

    /** 风险描述（生成风险用） */
    private String riskDesc;
}
