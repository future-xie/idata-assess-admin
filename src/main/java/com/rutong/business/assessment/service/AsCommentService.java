package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsComment;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 题目注释 业务层
 */
@Service
public class AsCommentService extends MpBaseService<AsComment> {

    /**
     * 按题目查询注释
     */
    public List<AsComment> listByQuestion(Long surveyId, Long questionId) {
        return lambdaQuery()
                .eq(AsComment::getSurveyId, surveyId)
                .eq(AsComment::getQuestionId, questionId)
                .list();
    }
}
