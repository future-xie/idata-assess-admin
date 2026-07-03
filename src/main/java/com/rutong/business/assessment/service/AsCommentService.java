package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsComment;
import com.rutong.business.common.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 题目注释 业务层
 */
@Service
public class AsCommentService extends BaseService<AsComment> {

    /**
     * 按题目查询注释
     */
    public List<AsComment> listByQuestion(Long surveyId, Long questionId) {
        return dao.findByProperty(AsComment.class, "surveyId", surveyId).stream()
                .filter(c -> questionId.equals(c.getQuestionId()))
                .toList();
    }
}
