package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmRiskRuleCond;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 风险规则条件 业务层
 */
@Service
public class QmRiskRuleCondService extends BaseService<QmRiskRuleCond> {

    public List<QmRiskRuleCond> listByRule(Long ruleId) {
        return dao.findByProperty(QmRiskRuleCond.class, "ruleId", ruleId);
    }

    /** 按多个规则 ID 批量查询条件 */
    public List<QmRiskRuleCond> listByRuleIds(List<Long> ruleIds) {
        if (ruleIds == null || ruleIds.isEmpty()) {
            return Collections.emptyList();
        }
        return dao.executeHqlInQuery(QmRiskRuleCond.class,
                "from QmRiskRuleCond c where c.ruleId in (:ids) order by c.id",
                "ids", ruleIds);
    }

    /** 替换某规则的全部条件（先删后插） */
    @Transactional
    public void replaceConditions(Long ruleId, List<QmRiskRuleCond> conditions) {
        dao.deleteByProperty(QmRiskRuleCond.class, "ruleId", ruleId);
        if (conditions == null || conditions.isEmpty()) {
            return;
        }
        List<QmRiskRuleCond> toSave = new ArrayList<>();
        for (QmRiskRuleCond c : conditions) {
            if (c == null || c.getCondQuestionId() == null) {
                continue;
            }
            c.setId(null);
            c.setRuleId(ruleId);
            if (c.getOp() == null) {
                c.setOp("EQ");
            }
            toSave.add(c);
        }
        if (!toSave.isEmpty()) {
            dao.bulkSave(toSave);
        }
    }

    @Transactional
    public int deleteByRule(Long ruleId) {
        return dao.deleteByProperty(QmRiskRuleCond.class, "ruleId", ruleId);
    }
}
