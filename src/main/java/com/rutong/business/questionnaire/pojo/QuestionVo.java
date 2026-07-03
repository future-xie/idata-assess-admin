package com.rutong.business.questionnaire.pojo;

import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 题目视图对象：题目字段 + 选项列表 + 逻辑规则（供前端配置/回显）。
 * 继承 QmQuestion 获得全部题目字段，附加 options 与 logic。
 */
@Getter
@Setter
public class QuestionVo extends QmQuestion {

    /** 选项 */
    private List<QmQuestionOption> options = new ArrayList<>();

    /** 显示逻辑规则 */
    private List<QmQuestionLogic> logic = new ArrayList<>();
}

