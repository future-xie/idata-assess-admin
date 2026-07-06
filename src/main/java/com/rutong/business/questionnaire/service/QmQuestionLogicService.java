package com.rutong.business.questionnaire.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rutong.business.questionnaire.constant.QuestionConstants;
import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 题目逻辑关系 业务层
 */
@Service
public class QmQuestionLogicService extends MpBaseService<QmQuestionLogic> {

    public List<QmQuestionLogic> listByQuestion(Long questionId) {
        return lambdaQuery().eq(QmQuestionLogic::getQuestionId, questionId).list();
    }

    /** 按多个题目 ID 批量查询逻辑（避免 N+1） */
    public List<QmQuestionLogic> listByQuestionIds(List<Long> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            return Collections.emptyList();
        }
        return lambdaQuery().in(QmQuestionLogic::getQuestionId, questionIds)
                .orderByAsc(QmQuestionLogic::getId).list();
    }

    /** 替换某题目的全部逻辑规则（先删后插） */
    @Transactional(rollbackFor = Exception.class)
    public void replaceLogic(Long questionId, List<QmQuestionLogic> logic) {
        remove(new LambdaQueryWrapper<QmQuestionLogic>()
                .eq(QmQuestionLogic::getQuestionId, questionId));
        if (logic == null || logic.isEmpty()) {
            return;
        }
        List<QmQuestionLogic> toSave = new ArrayList<>();
        for (QmQuestionLogic l : logic) {
            if (l == null || l.getCondQuestionId() == null) {
                continue;
            }
            l.setId(null);
            l.setQuestionId(questionId);
            if (l.getOp() == null) {
                l.setOp(QuestionConstants.OP_EQ);
            }
            if (l.getAction() == null) {
                l.setAction(QuestionConstants.ACTION_SHOW);
            }
            toSave.add(l);
        }
        if (!toSave.isEmpty()) {
            saveBatch(toSave);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteByQuestion(Long questionId) {
        return baseMapper.delete(new LambdaQueryWrapper<QmQuestionLogic>()
                .eq(QmQuestionLogic::getQuestionId, questionId));
    }
}
