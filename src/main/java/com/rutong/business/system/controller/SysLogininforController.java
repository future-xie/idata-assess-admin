package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.query.SysLogininforQuery;
import com.rutong.business.system.service.SysLogininforService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/logininfor")
public class SysLogininforController {

    @Autowired
    private SysLogininforService logininforService;

    @PreAuthorize("@ss.hasPermi('system:logininfor:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysLogininforQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:logininfor:remove')")
    @OperLog(title = "登录日志", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    public BaseService getService() {
        return logininforService;
    }
}