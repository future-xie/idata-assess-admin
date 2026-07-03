package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsRequest;
import com.rutong.business.common.service.BaseService;
import com.rutong.framework.dao.objectquery.SortFilter;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 题目修改请求 业务层
 */
@Service
public class AsRequestService extends BaseService<AsRequest> {

    /**
     * 查询某评估实例下某题的所有请求(按时间倒序)。
     * 注:BaseService 的 findByProperty 仅支持单字段,本题采用 HQL 自行查询。
     */
    public List<AsRequest> listByQuestion(Long surveyId, Long questionId) {
        String hql = "from AsRequest where surveyId = ?1 and questionId = ?2 order by createTime desc";
        return dao.executeHqlQuery(AsRequest.class, hql, surveyId, questionId);
    }

    /** 统计某评估实例下每题的请求数(返回 qid -> count) */
    public Map<Long, Long> countByQuestion(Long surveyId) {
        List<AsRequest> all = dao.findByProperty(AsRequest.class, "surveyId", surveyId);
        Map<Long, Long> result = new HashMap<>();
        for (AsRequest r : all) {
            if (r.getQuestionId() == null) continue;
            result.merge(r.getQuestionId(), 1L, Long::sum);
        }
        return result;
    }

    /** 创建一条请求(由 BaseService.insert 自动写入 createBy/createTime) */
    public AsRequest create(Long surveyId, Long questionId, String content) {
        AsRequest r = new AsRequest();
        r.setSurveyId(surveyId);
        r.setQuestionId(questionId);
        r.setContent(content);
        insert(r);
        return r;
    }
}
