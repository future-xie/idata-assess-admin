package com.rutong.business.assessment.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * 评估/分发实例
 */
@Getter
@Setter
@TableName("as_survey")
public class AsSurvey extends BaseEntity {

    /** 模板 ID */
    private Long templateId;

    /** 标题 */
    private String title;

    /** 受访者姓名 */
    private String respondentName;

    /** 受访者邮箱 */
    private String respondentEmail;

    /** 状态：DISTRIBUTED/FILLING/SUBMITTED/RETURNED */
    private String status;

    /** 评估人（用户 ID，逗号分隔） */
    private String assessorIds;

    /** 截止日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dueDate;

    /** 章节范围（章节 ID，逗号分隔；空表示全部章节） */
    private String chapterScope;

    /** 分发时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date distributeTime;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /** 分发人用户 ID */
    private Long operUserId;

    /** 受访人用户 ID（登录填写身份判定） */
    private Long respondentUserId;

    /** 审核人姓名（逗号分隔；仅列表展示用，不持久化） */
    @TableField(exist = false)
    private String assessorNames;
}
