package com.rutong.business.questionnaire.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rutong.business.questionnaire.constant.QuestionConstants;
import com.rutong.business.questionnaire.entity.QmRiskRuleCond;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 风险规则条件 业务层
 */
@Service
public class QmRiskRuleCondService extends MpBaseService<QmRiskRuleCond> {

    public List<QmRiskRuleCond> listByRule(Long ruleId) {
        return lambdaQuery().eq(QmRiskRuleCond::getRuleId, ruleId).list();
    }

    /** 按多个规则 ID 批量查询条件 */
    public List<QmRiskRuleCond> listByRuleIds(List<Long> ruleIds) {
        if (ruleIds == null || ruleIds.isEmpty()) {
            return Collections.emptyList();
        }
        return lambdaQuery().in(QmRiskRuleCond::getRuleId, ruleIds)
                .orderByAsc(QmRiskRuleCond::getId).list();
    }

    /** 替换某规则的全部条件（先删后插） */
    @Transactional(rollbackFor = Exception.class)
    public void replaceConditions(Long ruleId, List<QmRiskRuleCond> conditions) {
        remove(new LambdaQueryWrapper<QmRiskRuleCond>()
                .eq(QmRiskRuleCond::getRuleId, ruleId));
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
                c.setOp(QuestionConstants.OP_EQ);
            }
            toSave.add(c);
        }
        if (!toSave.isEmpty()) {
            saveBatch(toSave);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteByRule(Long ruleId) {
        return baseMapper.delete(new LambdaQueryWrapper<QmRiskRuleCond>()
                .eq(QmRiskRuleCond::getRuleId, ruleId));
    }
}
