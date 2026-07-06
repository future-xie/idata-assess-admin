package com.rutong.business.assessment.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * 风险处理记录（一行 = 一轮：处理人提交 + 审核人反馈）。
 */
@Getter
@Setter
@TableName("as_risk_process")
public class AsRiskProcess extends BaseEntity {

    /** 关联的风险记录 ID */
    private Long riskRecordId;

    /** 处理说明（处理人填写） */
    private String content;

    /** 附件 JSON 串：[{fileName,path,id},...] */
    private String attachments;

    /** 审核人反馈意见（审核人填写，初始空） */
    private String reviewContent;

    /** 审核人 */
    private String reviewBy;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date reviewTime;
}
