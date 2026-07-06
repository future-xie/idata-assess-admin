package com.rutong.business.questionnaire.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * 个人题库（收藏的题目快照，跨模板复用）
 */
@Getter
@Setter
@TableName("qm_personal_question")
public class QmPersonalQuestion extends BaseEntity {

    /** 收藏人用户 ID */
    private Long userId;

    /** 题目快照（JSON） */
    private String questionSnapshot;
}
