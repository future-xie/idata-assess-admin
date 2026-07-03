package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysDictType;
import com.rutong.business.system.query.SysDictTypeQuery;
import com.rutong.business.system.service.SysDictTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 数据字典信息
 */
@RestController
@RequestMapping("/system/dict/type")
public class SysDictTypeController {
    @Autowired
    private SysDictTypeService dictTypeService;

    @PreAuthorize("@ss.hasPermi('system:dict:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysDictTypeQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:add')")
    @OperLog(title = "字典类型", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysDictType data) {
        if (!dictTypeService.checkDictTypeUnique(data)) {
            return AjaxResult.error("新增字典'" + data.getDictName() + "'失败，字典类型已存在");
        }
        return AjaxResult.success(dictTypeService.insertDictType(data));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:edit')")
    @OperLog(title = "字典类型", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysDictType data) {
        if (!dictTypeService.checkDictTypeUnique(data)) {
            return AjaxResult.error("修改字典'" + data.getDictName() + "'失败，字典类型已存在");
        }
        return AjaxResult.success(dictTypeService.update(data));
    }

    @PreAuthorize("@ss.hasPermi('system:dict:remove')")
    @OperLog(title = "字典类型", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        dictTypeService.deleteDictTypeByIds(ids);
        return AjaxResult.success();
    }

    /**
     * 刷新字典缓存
     */
    @PreAuthorize("@ss.hasPermi('system:dict:remove')")
    @OperLog(title = "字典类型", businessType = BusinessType.CLEAN)
    @DeleteMapping("/refreshCache")
    public AjaxResult refreshCache() {
        dictTypeService.resetDictCache();
        return AjaxResult.success();
    }

    public BaseService getService() {
        return dictTypeService;
    }
}