package com.rutong.business.questionnaire.controller;

import com.rutong.business.questionnaire.entity.QmTemplate;
import com.rutong.business.questionnaire.query.QmTemplateQuery;
import com.rutong.business.questionnaire.service.QmTemplateService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 问卷模板 控制器
 */
@RestController
@RequestMapping("/questionnaire/template")
public class QmTemplateController {

    @Autowired
    private QmTemplateService templateService;

    /**
     * 分页查询
     */
    @PreAuthorize("@ss.hasPermi('qm:template:list')")
    @GetMapping("/list")
    public TableDataInfo list(QmTemplateQuery query, PageBean page) {
        return templateService.findAllByPage(page, query,
                List.of(new com.rutong.framework.mybatis.objectquery.SortFilter("id", com.rutong.framework.mybatis.objectquery.SortFilter.DESC)));
    }

    /**
     * 详情：模板 + 章节 + 题目
     */
    @PreAuthorize("@ss.hasPermi('qm:template:query')")
    @GetMapping("/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return AjaxResult.success(templateService.detail(id));
    }

    /**
     * 空白创建
     */
    @PreAuthorize("@ss.hasPermi('qm:template:add')")
    @OperLog(title = "问卷模板", businessType = BusinessType.INSERT)
    @PostMapping("/createBlank")
    public AjaxResult createBlank(@RequestBody QmTemplate data) {
        return AjaxResult.success(templateService.createBlank(data));
    }

    /**
     * 模板创建（从行业模板库）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:add')")
    @OperLog(title = "问卷模板", businessType = BusinessType.INSERT)
    @PostMapping("/createFromLibrary/{libId}")
    public AjaxResult createFromLibrary(@PathVariable Long libId) {
        return AjaxResult.success(templateService.createFromLibrary(libId));
    }

    /**
     * 复制创建
     */
    @PreAuthorize("@ss.hasPermi('qm:template:add')")
    @OperLog(title = "问卷模板", businessType = BusinessType.INSERT)
    @PostMapping("/copyFrom/{srcId}")
    public AjaxResult copyFrom(@PathVariable Long srcId) {
        return AjaxResult.success(templateService.copyFrom(srcId));
    }

    /**
     * 导入创建（Excel）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:import')")
    @OperLog(title = "问卷模板", businessType = BusinessType.IMPORT)
    @PostMapping("/import")
    public AjaxResult importFromExcel(@RequestParam("file") MultipartFile file,
                                      @RequestParam("templateName") String templateName,
                                      @RequestParam(value = "category", required = false) String category) {
        return AjaxResult.success(templateService.importFromExcel(templateName, category, file));
    }

    /**
     * 修改
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷模板", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult edit(@RequestBody QmTemplate data) {
        return AjaxResult.success(templateService.update(data));
    }

    /**
     * 发布
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷模板", businessType = BusinessType.UPDATE)
    @PostMapping("/publish/{id}")
    public AjaxResult publish(@PathVariable Long id) {
        return AjaxResult.success(templateService.publish(id));
    }

    /**
     * 归档
     */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @OperLog(title = "问卷模板", businessType = BusinessType.UPDATE)
    @PostMapping("/archive/{id}")
    public AjaxResult archive(@PathVariable Long id) {
        return AjaxResult.success(templateService.archive(id));
    }

    /**
     * 删除
     */
    @PreAuthorize("@ss.hasPermi('qm:template:remove')")
    @OperLog(title = "问卷模板", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        templateService.deleteByIds(ids);
        return AjaxResult.success();
    }

    /**
     * 行业模板库列表（用于"模板创建"选择）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:list')")
    @GetMapping("/library")
    public AjaxResult library() {
        return AjaxResult.success(templateService.listLibrary());
    }

    /**
     * 个人题库（收藏的题目）
     */
    @PreAuthorize("@ss.hasPermi('qm:template:list')")
    @GetMapping("/personal")
    public AjaxResult personal() {
        return AjaxResult.success(templateService.listPersonalQuestion());
    }
}
