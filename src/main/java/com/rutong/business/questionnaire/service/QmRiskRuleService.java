package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmRiskLib;
import com.rutong.business.questionnaire.entity.QmRiskRule;
import com.rutong.business.questionnaire.entity.QmRiskRuleCond;
import com.rutong.business.questionnaire.pojo.RiskRuleVo;
import com.rutong.framework.utils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 风险规则 业务层（规则 + 多条件，级联管理）
 */
@Service
public class QmRiskRuleService extends BaseService<QmRiskRule> {

    @Autowired
    private QmRiskRuleCondService condService;

    /**
     * 按模板查询规则（含条件 + 风险库名/描述/等级），供前端配置与评估使用。
     */
    public List<RiskRuleVo> listVoByTemplate(Long templateId) {
        List<QmRiskRule> rules = dao.findByProperty(QmRiskRule.class, "templateId", templateId);
        if (rules.isEmpty()) {
            return new ArrayList<>();
        }
        List<Long> ruleIds = rules.stream().map(QmRiskRule::getId).collect(Collectors.toList());
        Map<Long, List<QmRiskRuleCond>> condByRule = condService.listByRuleIds(ruleIds).stream()
                .collect(Collectors.groupingBy(QmRiskRuleCond::getRuleId));

        List<Long> libIds = rules.stream().map(QmRiskRule::getRiskLibId)
                .filter(java.util.Objects::nonNull).distinct().collect(Collectors.toList());
        Map<Long, QmRiskLib> libMap = libIds.isEmpty() ? new HashMap<>()
                : dao.executeHqlInQuery(QmRiskLib.class,
                        "from QmRiskLib r where r.id in (:ids)", "ids", libIds).stream()
                .collect(Collectors.toMap(QmRiskLib::getId, r -> r));

        List<RiskRuleVo> result = new ArrayList<>();
        for (QmRiskRule rule : rules) {
            RiskRuleVo vo = toVo(rule, condByRule.get(rule.getId()), libMap.get(rule.getRiskLibId()));
            result.add(vo);
        }
        return result;
    }

    @Transactional
    public RiskRuleVo saveRule(RiskRuleVo vo) {
        QmRiskRule rule = toEntity(vo);
        rule.setId(null);
        insert(rule);
        condService.replaceConditions(rule.getId(), vo.getConditions());
        return null;
    }

    @Transactional
    public RiskRuleVo updateRule(RiskRuleVo vo) {
        QmRiskRule rule = toEntity(vo);
        update(rule);
        condService.replaceConditions(rule.getId(), vo.getConditions());
        return null;
    }

    @Override
    @Transactional
    public int deleteById(Serializable id) {
        condService.deleteByRule((Long) id);
        return super.deleteById(id);
    }

    // ===================== 私有辅助 =====================

    private RiskRuleVo toVo(QmRiskRule rule, List<QmRiskRuleCond> conditions, QmRiskLib lib) {
        RiskRuleVo vo = new RiskRuleVo();
        try {
            BeanUtils.copyProperties(vo, rule);
        } catch (Exception e) {
            throw new RuntimeException("风险规则视图转换失败", e);
        }
        vo.setConditions(conditions == null ? new ArrayList<>() : conditions);
        if (lib != null) {
            vo.setRiskName(lib.getRiskName());
            vo.setRiskDesc(lib.getRiskDesc());
            if (rule.getLevel() == null) {
                vo.setLevel(lib.getLevel());
            }
        }
        return vo;
    }

    private QmRiskRule toEntity(RiskRuleVo vo) {
        QmRiskRule rule = new QmRiskRule();
        try {
            BeanUtils.copyProperties(rule, vo);
        } catch (Exception e) {
            throw new RuntimeException("风险规则转换失败", e);
        }
        return rule;
    }
}
