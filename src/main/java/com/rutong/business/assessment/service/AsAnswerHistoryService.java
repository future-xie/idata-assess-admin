package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsAnswerHistory;
import com.rutong.business.common.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 答案变更历史 业务层
 */
@Service
public class AsAnswerHistoryService extends BaseService<AsAnswerHistory> {

    /**
     * 按题目查询变更历史
     */
    public List<AsAnswerHistory> listByQuestion(Long surveyId, Long questionId) {
        return dao.findByProperty(AsAnswerHistory.class, "surveyId", surveyId).stream()
                .filter(h -> questionId.equals(h.getQuestionId()))
                .toList();
    }
}
