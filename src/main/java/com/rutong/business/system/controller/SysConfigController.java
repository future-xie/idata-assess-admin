package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.mybatis.objectquery.SortFilter;
import com.rutong.business.system.entity.SysConfig;
import com.rutong.framework.service.MpBaseService;
import com.rutong.business.system.query.SysConfigQuery;
import com.rutong.business.system.service.SysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 参数配置 信息操作处理
 */
@RestController
@RequestMapping("/system/config")
public class SysConfigController {
    @Autowired
    private SysConfigService configService;

    @PreAuthorize("@ss.hasPermi('system:config:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysConfigQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:config:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    /**
     * 根据参数键名查询参数值
     */
    @PreAuthorize("@ss.hasPermi('system:config:query')")
    @GetMapping(value = "/configKey/{configKey}")
    public AjaxResult getConfigKey(@PathVariable String configKey) {
        return AjaxResult.success(configService.selectConfigByKey(configKey));
    }

    public AjaxResult preData(SysConfig config) {
        if (!configService.checkConfigKeyUnique(config)) {
            return AjaxResult.error("修改参数'" + config.getConfigName() + "'失败，参数键名已存在");
        }
        return null;
    }

    @PreAuthorize("@ss.hasPermi('system:config:add')")
    @OperLog(title = "参数管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysConfig data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().insert(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:config:edit')")
    @OperLog(title = "参数管理", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysConfig data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().update(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:config:remove')")
    @OperLog(title = "参数管理", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    public MpBaseService<SysConfig> getService() {
        return configService;
    }
}