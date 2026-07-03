package com.rutong.business.questionnaire.controller;

import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import com.rutong.business.questionnaire.service.QmQuestionLogicService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 题目逻辑关系 控制器（单条规则增删改，供"逻辑配置"页使用）
 */
@RestController
@RequestMapping("/questionnaire/logic")
public class QmQuestionLogicController {

    @Autowired
    private QmQuestionLogicService logicService;

    /** 新增一条逻辑条件 */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "题目逻辑", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody QmQuestionLogic data) {
        return AjaxResult.success(logicService.insert(data));
    }

    /** 修改一条逻辑条件 */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "题目逻辑", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody QmQuestionLogic data) {
        return AjaxResult.success(logicService.update(data));
    }

    /** 删除逻辑条件 */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "题目逻辑", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        logicService.deleteByIds(ids);
        return AjaxResult.success();
    }
}
