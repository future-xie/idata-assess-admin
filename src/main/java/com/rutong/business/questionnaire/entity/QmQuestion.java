package com.rutong.business.questionnaire.entity;

import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * 问卷题目。
 * 各题型的配置以结构化字段存储：选项见 qm_question_option 子表；
 * 文本/量表/上传等参数以具体列存储（不再使用 JSON）。
 */
@Getter
@Setter
@Entity
@Table(name = "qm_question")
public class QmQuestion extends BaseEntity {

    /** 所属模板 ID */
    private Long templateId;

    /** 所属章节 ID */
    private Long chapterId;

    /** 题型*/
    private String questionType;

    /** 题干（支持管道占位 ${Qxxx}） */
    @Column(length = 1024)
    private String title;

    /** 是否必填（Y/N） */
    private String required;

    /** 排序 */
    private Integer orderNum;

    // ===== 文本类（TEXT/TEXTAREA）校验参数 =====
    /** 最小字数 */
    private Integer minLen;
    /** 最大字数 */
    private Integer maxLen;
    /** 正则校验表达式 */
    @Column(length = 512)
    private String regex;
    /** 输入提示 */
    @Column(length = 255)
    private String placeholder;

    // ===== 上传题（UPLOAD）参数 =====
    /** 最大文件数 */
    private Integer maxCount;
    /** 单文件最大字节数 */
    private Long maxSize;
    /** 允许的文件类型，如 .jpg,.png */
    @Column(length = 255)
    private String accept;
}
