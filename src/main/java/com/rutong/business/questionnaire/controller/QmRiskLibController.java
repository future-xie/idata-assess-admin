package com.rutong.business.questionnaire.controller;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmRiskLib;
import com.rutong.business.questionnaire.query.QmRiskLibQuery;
import com.rutong.business.questionnaire.service.QmRiskLibService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 风险库 控制器（风险管理模块下维护；规则配置引用）。
 */
@RestController
@RequestMapping("/questionnaire/riskLib")
public class QmRiskLibController {

    @Autowired
    private QmRiskLibService riskLibService;

    /** 全部风险库项（供规则配置下拉用） */
    @PreAuthorize("@ss.hasPermi('qm:template:edit')")
    @GetMapping("/list")
    public AjaxResult list() {
        return AjaxResult.success(riskLibService.findAll());
    }

    /** 分页查询（风险管理页） */
    @PreAuthorize("@ss.hasPermi('risk:library:list')")
    @GetMapping("/page")
    public TableDataInfo page(QmRiskLibQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    /** 详情 */
    @PreAuthorize("@ss.hasPermi('risk:library:query')")
    @GetMapping("/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return AjaxResult.success(riskLibService.findById(id));
    }

    @PreAuthorize("@ss.hasPermi('risk:library:add')")
    @OperLog(title = "风险库", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody QmRiskLib data) {
        return AjaxResult.success(riskLibService.insert(data));
    }

    @PreAuthorize("@ss.hasPermi('risk:library:edit')")
    @OperLog(title = "风险库", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody QmRiskLib data) {
        return AjaxResult.success(riskLibService.update(data));
    }

    @PreAuthorize("@ss.hasPermi('risk:library:remove')")
    @OperLog(title = "风险库", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        riskLibService.deleteByIds(ids);
        return AjaxResult.success();
    }

    public BaseService getService() {
        return riskLibService;
    }
}
