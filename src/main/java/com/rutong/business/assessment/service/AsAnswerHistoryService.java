package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsAnswerHistory;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 答案变更历史 业务层
 */
@Service
public class AsAnswerHistoryService extends MpBaseService<AsAnswerHistory> {

    /**
     * 按题目查询变更历史
     */
    public List<AsAnswerHistory> listByQuestion(Long surveyId, Long questionId) {
        return lambdaQuery()
                .eq(AsAnswerHistory::getSurveyId, surveyId)
                .eq(AsAnswerHistory::getQuestionId, questionId)
                .list();
    }
}
