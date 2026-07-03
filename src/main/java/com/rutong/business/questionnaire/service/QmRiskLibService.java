package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmRiskLib;
import org.springframework.stereotype.Service;

/**
 * 风险库 业务层。评分（影响×概率）与等级（按固有评分）在新增/修改时自动计算。
 */
@Service
public class QmRiskLibService extends BaseService<QmRiskLib> {

    @Override
    public int insert(QmRiskLib r) {
        recalc(r);
        return super.insert(r);
    }

    @Override
    public int update(QmRiskLib r) {
        recalc(r);
        return super.update(r);
    }

    private void recalc(QmRiskLib r) {
        r.setInherentScore(score(r.getInherentImpact(), r.getInherentProbability()));
        r.setTargetScore(score(r.getTargetImpact(), r.getTargetProbability()));
        r.setResidualScore(score(r.getResidualImpact(), r.getResidualProbability()));
        // 等级按固有评分推导（固有评分存在时覆盖）
        Integer s = r.getInherentScore();
        if (s != null) {
            r.setLevel(s >= 15 ? "HIGH" : (s >= 8 ? "MID" : "LOW"));
        }
    }

    private Integer score(Integer impact, Integer probability) {
        if (impact == null || probability == null) {
            return null;
        }
        return impact * probability;
    }
}
