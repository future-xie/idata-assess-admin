package com.rutong.business.questionnaire.controller;

import com.rutong.business.questionnaire.pojo.RiskRuleVo;
import com.rutong.business.questionnaire.service.QmRiskRuleService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 风险规则 控制器（规则 + 多条件）
 */
@RestController
@RequestMapping("/questionnaire/riskRule")
public class QmRiskRuleController {

    @Autowired
    private QmRiskRuleService riskRuleService;

    /** 按模板查询规则（含条件 + 风险库信息） */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @GetMapping("/list")
    public AjaxResult list(@RequestParam Long templateId) {
        return AjaxResult.success(riskRuleService.listVoByTemplate(templateId));
    }

    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "风险规则", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody RiskRuleVo vo) {
        riskRuleService.saveRule(vo);
        return AjaxResult.success();
    }

    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "风险规则", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody RiskRuleVo vo) {
        riskRuleService.updateRule(vo);
        return AjaxResult.success();
    }

    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "风险规则", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        riskRuleService.deleteByIds(ids);
        return AjaxResult.success();
    }
}
