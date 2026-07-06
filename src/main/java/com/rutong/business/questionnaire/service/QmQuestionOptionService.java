package com.rutong.business.questionnaire.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 题目选项 业务层（题型配置子表）
 */
@Service
public class QmQuestionOptionService extends MpBaseService<QmQuestionOption> {

    /**
     * 按题目查询选项
     */
    public List<QmQuestionOption> listByQuestion(Long questionId) {
        return lambdaQuery().eq(QmQuestionOption::getQuestionId, questionId).list();
    }

    /**
     * 按多个题目 ID 批量查询选项（避免 N+1）
     */
    public List<QmQuestionOption> listByQuestionIds(List<Long> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            return Collections.emptyList();
        }
        return lambdaQuery().in(QmQuestionOption::getQuestionId, questionIds)
                .orderByAsc(QmQuestionOption::getOrderNum).list();
    }

    /**
     * 替换某题目的全部选项（先删后插）
     */
    @Transactional(rollbackFor = Exception.class)
    public void replaceOptions(Long questionId, List<QmQuestionOption> options) {
        remove(new LambdaQueryWrapper<QmQuestionOption>()
                .eq(QmQuestionOption::getQuestionId, questionId));
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
            saveBatch(toSave);
        }
    }

    /**
     * 删除某题目的全部选项
     */
    @Transactional(rollbackFor = Exception.class)
    public int deleteByQuestion(Long questionId) {
        return baseMapper.delete(new LambdaQueryWrapper<QmQuestionOption>()
                .eq(QmQuestionOption::getQuestionId, questionId));
    }
}
