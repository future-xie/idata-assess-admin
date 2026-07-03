package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsRiskRecord;
import com.rutong.business.common.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 风险记录 业务层(评估题目维度)
 */
@Service
public class AsRiskRecordService extends BaseService<AsRiskRecord> {

    /**
     * 查询某评估实例下某题的所有风险记录(按创建时间倒序)
     */
    public List<AsRiskRecord> listByQuestion(Long surveyId, Long questionId) {
        String hql = "from AsRiskRecord where surveyId = ?1 and questionId = ?2 order by createTime desc";
        return dao.executeHqlQuery(AsRiskRecord.class, hql, surveyId, questionId);
    }

    /** 统计某评估实例下每题的风险记录数(返回 qid -> count) */
    public Map<Long, Long> countByQuestion(Long surveyId) {
        List<AsRiskRecord> all = dao.findByProperty(AsRiskRecord.class, "surveyId", surveyId);
        Map<Long, Long> result = new HashMap<>();
        for (AsRiskRecord r : all) {
            if (r.getQuestionId() == null) continue;
            result.merge(r.getQuestionId(), 1L, Long::sum);
        }
        return result;
    }

    /**
     * 创建一条风险记录(由前端"标记风险"弹窗调用)
     * @param surveyId 评估实例 ID
     * @param questionId 题目 ID
     * @param level 风险等级 HIGH/MID/LOW
     * @param riskDesc 风险描述
     */
    public AsRiskRecord create(Long surveyId, Long questionId, String level, String riskDesc) {
        AsRiskRecord r = new AsRiskRecord();
        r.setSurveyId(surveyId);
        r.setQuestionId(questionId);
        r.setLevel(level);
        r.setRiskDesc(riskDesc);
        r.setHandleStatus("PENDING");
        insert(r);
        return r;
    }
}
