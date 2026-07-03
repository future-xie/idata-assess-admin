package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.query.SysOperLogQuery;
import com.rutong.business.system.service.SysOperLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/operlog")
public class SysOperLogController {

    @Autowired
    private SysOperLogService operLogService;

    @PreAuthorize("@ss.hasPermi('system:operlog:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysOperLogQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:operlog:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    @PreAuthorize("@ss.hasPermi('system:operlog:remove')")
    @OperLog(title = "操作日志", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    public BaseService getService() {
        return operLogService;
    }
}