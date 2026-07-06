package com.rutong.business.assessment.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * 题目注释（支持多条回复）
 */
@Getter
@Setter
@TableName("as_comment")
public class AsComment extends BaseEntity {

    /** 评估实例 ID */
    private Long surveyId;

    /** 题目 ID */
    private Long questionId;

    /** 注释内容 */
    private String content;
}
