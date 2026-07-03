package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 题目逻辑关系 业务层
 */
@Service
public class QmQuestionLogicService extends BaseService<QmQuestionLogic> {

    public List<QmQuestionLogic> listByQuestion(Long questionId) {
        return dao.findByProperty(QmQuestionLogic.class, "questionId", questionId);
    }

    /** 按多个题目 ID 批量查询逻辑（避免 N+1） */
    public List<QmQuestionLogic> listByQuestionIds(List<Long> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            return Collections.emptyList();
        }
        return dao.executeHqlInQuery(QmQuestionLogic.class,
                "from QmQuestionLogic l where l.questionId in (:ids) order by l.id",
                "ids", questionIds);
    }

    /** 替换某题目的全部逻辑规则（先删后插） */
    @Transactional
    public void replaceLogic(Long questionId, List<QmQuestionLogic> logic) {
        dao.deleteByProperty(QmQuestionLogic.class, "questionId", questionId);
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
                l.setOp("EQ");
            }
            if (l.getAction() == null) {
                l.setAction("SHOW");
            }
            toSave.add(l);
        }
        if (!toSave.isEmpty()) {
            dao.bulkSave(toSave);
        }
    }

    @Transactional
    public int deleteByQuestion(Long questionId) {
        return dao.deleteByProperty(QmQuestionLogic.class, "questionId", questionId);
    }
}
