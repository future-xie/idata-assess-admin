package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysDictData;
import com.rutong.business.system.query.SysDictDataQuery;
import com.rutong.business.system.service.SysDictDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 数据字典信息
 */
@RestController
@RequestMapping("/system/dict/data")
public class SysDictDataController {
    @Autowired
    private SysDictDataService dictDataService;

    @PreAuthorize("@ss.hasPermi('system:dict:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysDictDataQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:list')")
    @GetMapping(value = "/type/{dictType}")
    public AjaxResult loadDictDataList(@PathVariable String dictType) {
        return AjaxResult.success(dictDataService.loadDictDataList(dictType));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:add')")
    @OperLog(title = "字典数据", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysDictData data) {
        return AjaxResult.success(dictDataService.insertDictData(data));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:edit')")
    @OperLog(title = "字典数据", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysDictData data) {
        return AjaxResult.success(dictDataService.updateDictData(data));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:remove')")
    @OperLog(title = "字典数据", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(Long[] ids) {
        dictDataService.deleteDictDataByIds(ids);
        return AjaxResult.success();
    }

    public BaseService getService() {
        return dictDataService;
    }
}