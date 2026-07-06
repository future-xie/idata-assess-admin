package com.rutong.business.assessment.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 风险记录
 */
@Getter
@Setter
@TableName("as_risk_record")
public class AsRiskRecord extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 风险名称 */
    private String riskName;

    /** 风险描述 */
    private String riskDesc;

    /** 风险等级：HIGH/MID/LOW */
    private String level;

    /** 处理计划 */
    private String treatmentPlan;

    /** 处理状态：PENDING/PROCESSING/CLOSED */
    private String handleStatus;

    /** 整改状态：UNPROCESSED 未处理 / PROCESSING 处理中 / RECTIFIED 已完成整改 / UNRECTIFIED 未完成整改 */
    private String processStatus;
}
