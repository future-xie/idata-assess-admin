package com.rutong.business.questionnaire.controller;

import com.rutong.business.questionnaire.entity.QmChapter;
import com.rutong.business.questionnaire.service.QmChapterService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 问卷章节 控制器
 */
@RestController
@RequestMapping("/questionnaire/chapter")
public class QmChapterController {

    @Autowired
    private QmChapterService chapterService;

    /**
     * 新增章节
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷章节", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@Validated @RequestBody QmChapter data) {
        return AjaxResult.success(chapterService.insert(data));
    }

    /**
     * 修改章节（重命名 / 排序 / 显隐）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷章节", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody QmChapter data) {
        return AjaxResult.success(chapterService.update(data));
    }

    /**
     * 删除章节
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷章节", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        chapterService.deleteByIds(ids);
        return AjaxResult.success();
    }
}
