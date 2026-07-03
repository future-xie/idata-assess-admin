package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险规则（属某模板）：满足全部条件时触发指定风险库项。
 */
@Getter
@Setter
@Entity
@Table(name = "qm_risk_rule")
public class QmRiskRule extends BaseEntity {

    /** 所属模板 ID */
    private Long templateId;

    /** 规则名称（可选） */
    private String ruleName;

    /** 触发的风险库项 ID */
    private Long riskLibId;

    /** 风险等级：HIGH/MID/LOW（缺省取风险库等级） */
    @Column(length = 16)
    private String level;
}
