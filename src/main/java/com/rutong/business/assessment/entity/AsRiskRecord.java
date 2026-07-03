package com.rutong.business.assessment.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险记录
 */
@Getter
@Setter
@Entity
@Table(name = "as_risk_record")
public class AsRiskRecord extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 风险描述 */
    @Column(length = 1024)
    private String riskDesc;

    /** 风险等级：HIGH/MID/LOW */
    private String level;

    /** 处理状态：PENDING/PROCESSING/CLOSED */
    private String handleStatus;

    /** 整改状态：UNPROCESSED 未处理 / PROCESSING 处理中 / RECTIFIED 已完成整改 / UNRECTIFIED 未完成整改 */
    @Column(length = 16)
    private String processStatus;
}
