package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.service.MpBaseService;
import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.query.SysDeptQuery;
import com.rutong.business.system.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 部门信息
 */
@RestController
@RequestMapping("/system/dept")
public class SysDeptController {
    @Autowired
    private SysDeptService deptService;

    @PreAuthorize("@ss.hasPermi('system:dept:list')")
    @GetMapping("/allList")
    public AjaxResult allList(SysDeptQuery query) {
        return AjaxResult.success(getService().findAll(query, java.util.Collections.emptyList()));
    }

    @PreAuthorize("@ss.hasPermi('system:dept:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    /**
     * 获取部门下拉树列表
     */
    @PreAuthorize("@ss.hasPermi('system:dept:list')")
    @GetMapping("/treeselect")
    public AjaxResult treeselect() {
        List<SysDept> depts = deptService.findAll();
        return AjaxResult.success(deptService.buildDeptTreeSelect(depts));
    }

    public AjaxResult preData(SysDept data) {
        if (!deptService.checkDeptNameUnique(data)) {
            String action = data.getId() == null ? "新增" : "修改";
            return AjaxResult.error(action + "部门'" + data.getDeptName() + "'失败，部门名称已存在");
        }
        return null;
    }

    @PreAuthorize("@ss.hasPermi('system:dept:add')")
    @OperLog(title = "部门管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysDept data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().insert(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:dept:edit')")
    @OperLog(title = "部门管理", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysDept data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().update(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:dept:remove')")
    @OperLog(title = "部门管理", businessType = BusinessType.DELETE)
    @PostMapping("/deleteById/{id}")
    public AjaxResult delDataById(@PathVariable Long id) {
        if (deptService.hasChildByDeptId(id)) {
            return AjaxResult.error("存在子部门,不允许删除");
        }
        if (deptService.checkDeptExistUser(id)) {
            return AjaxResult.error("部门存在用户,不允许删除");
        }
        return AjaxResult.success(getService().deleteById(id));
    }

    @PreAuthorize("@ss.hasPermi('system:dept:remove')")
    @OperLog(title = "部门管理", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        for (Long id : ids) {
            if (deptService.hasChildByDeptId(id)) {
                return AjaxResult.error("存在子部门,不允许删除");
            }
            if (deptService.checkDeptExistUser(id)) {
                return AjaxResult.error("部门存在用户,不允许删除");
            }
        }
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    public MpBaseService<SysDept> getService() {
        return deptService;
    }
}