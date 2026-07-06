package com.rutong.business.questionnaire.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 行业模板库（预设模板，模板创建时拷贝来源）
 */
@Getter
@Setter
@TableName("qm_template_library")
public class QmTemplateLibrary extends BaseEntity {

    /** 分类 / 行业 */
    private String category;

    /** 模板名称 */
    private String templateName;

    /** 模板快照（含章节/题目，JSON） */
    private String snapshot;
}
