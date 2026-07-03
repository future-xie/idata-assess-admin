package com.rutong.business.questionnaire.controller;

import com.rutong.business.questionnaire.pojo.QuestionVo;
import com.rutong.business.questionnaire.service.QmQuestionService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 题目 控制器（含题型配置：选项 + 结构化参数）
 */
@RestController
@RequestMapping("/questionnaire/question")
public class QmQuestionController {

    @Autowired
    private QmQuestionService questionService;

    /**
     * 按模板查询题目（含选项，按 orderNum 升序）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:query')")
    @GetMapping("/list")
    public AjaxResult list(@RequestParam Long templateId) {
        return AjaxResult.success(questionService.listVoByTemplate(templateId));
    }

    /**
     * 题目详情（含选项）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:query')")
    @GetMapping("/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return AjaxResult.success(questionService.getVo(id));
    }

    /**
     * 新增题目（含选项）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody QuestionVo vo) {
        return AjaxResult.success(questionService.saveQuestion(vo));
    }

    /**
     * 修改题目（含选项）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody QuestionVo vo) {
        return AjaxResult.success(questionService.updateQuestionVo(vo));
    }

    /**
     * 删除题目（级联删除选项）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        questionService.deleteByIds(ids);
        return AjaxResult.success();
    }

    /**
     * 拖拽排序 / 跨章节移动（body: [{id, chapterId, orderNum}, ...]，全量顺序快照）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.UPDATE)
    @PostMapping("/reorder")
    public AjaxResult reorder(@RequestBody List<QuestionVo> items) {
        questionService.reorder(items.stream().map(v -> (com.rutong.business.questionnaire.entity.QmQuestion) v).collect(java.util.stream.Collectors.toList()));
        return AjaxResult.success();
    }

    /**
     * 复制题目（含选项）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.INSERT)
    @PostMapping("/copy/{id}")
    public AjaxResult copy(@PathVariable Long id) {
        return AjaxResult.success(questionService.copy(id));
    }

    /**
     * 收藏到个人题库
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷题目", businessType = BusinessType.OTHER)
    @PostMapping("/collect/{id}")
    public AjaxResult collect(@PathVariable Long id) {
        return AjaxResult.success(questionService.collectToPersonal(id));
    }
}
