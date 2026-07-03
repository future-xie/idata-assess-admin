package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 题目选项 业务层（题型配置子表）
 */
@Service
public class QmQuestionOptionService extends BaseService<QmQuestionOption> {

    /**
     * 按题目查询选项
     */
    public List<QmQuestionOption> listByQuestion(Long questionId) {
        return dao.findByProperty(QmQuestionOption.class, "questionId", questionId);
    }

    /**
     * 按多个题目 ID 批量查询选项（避免 N+1）
     */
    @SuppressWarnings("unchecked")
    public List<QmQuestionOption> listByQuestionIds(List<Long> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            return Collections.emptyList();
        }
        return dao.executeHqlInQuery(QmQuestionOption.class,
                "from QmQuestionOption o where o.questionId in (:ids) order by o.orderNum",
                "ids", questionIds);
    }

    /**
     * 替换某题目的全部选项（先删后插）
     */
    @Transactional
    public void replaceOptions(Long questionId, List<QmQuestionOption> options) {
        dao.deleteByProperty(QmQuestionOption.class, "questionId", questionId);
        if (options == null || options.isEmpty()) {
            return;
        }
        int order = 1;
        List<QmQuestionOption> toSave = new ArrayList<>();
        for (QmQuestionOption o : options) {
            if (o == null) {
                continue;
            }
            o.setId(null);
            o.setQuestionId(questionId);
            if (o.getOrderNum() == null) {
                o.setOrderNum(order);
            }
            order++;
            toSave.add(o);
        }
        if (!toSave.isEmpty()) {
            dao.bulkSave(toSave);
        }
    }

    /**
     * 删除某题目的全部选项
     */
    @Transactional
    public int deleteByQuestion(Long questionId) {
        return dao.deleteByProperty(QmQuestionOption.class, "questionId", questionId);
    }
}
