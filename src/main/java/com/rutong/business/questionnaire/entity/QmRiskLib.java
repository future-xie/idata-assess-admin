package com.rutong.business.questionnaire.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险库（风险管理模块维护；风险规则引用）。
 * 仅保留：风险名称 / 等级 / 描述 / 处理计划。
 */
@Getter
@Setter
@TableName("qm_risk_lib")
public class QmRiskLib extends BaseEntity {

    /** 风险名称 */
    private String riskName;

    /** 风险等级：HIGH/MID/LOW（前端直接选择） */
    private String level;

    /** 描述 */
    private String riskDesc;

    /** 处理计划 */
    private String treatmentPlan;
}
