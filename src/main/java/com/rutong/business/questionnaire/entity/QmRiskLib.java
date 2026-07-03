package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险库（风险管理模块维护；风险规则引用）。
 */
@Getter
@Setter
@Entity
@Table(name = "qm_risk_lib")
public class QmRiskLib extends BaseEntity {

    /** 风险名称 */
    @Column(length = 300)
    private String riskName;

    /** 风险等级：HIGH/MID/LOW（按固有评分自动推导） */
    @Column(length = 16)
    private String level;

    /** 描述 */
    @Column(length = 4000)
    private String riskDesc;

    /** 类别 */
    @Column(length = 255)
    private String category;

    /** 威胁 */
    @Column(length = 255)
    private String threat;

    /** 漏洞 */
    @Column(length = 255)
    private String vulnerability;

    /** 处理计划 */
    @Column(length = 1024)
    private String treatmentPlan;

    // ===== 固有风险 =====
    private Integer inherentImpact;
    private Integer inherentProbability;
    private Integer inherentScore;

    // ===== 目标风险 =====
    private Integer targetImpact;
    private Integer targetProbability;
    private Integer targetScore;

    // ===== 剩余风险 =====
    private Integer residualImpact;
    private Integer residualProbability;
    private Integer residualScore;
}
