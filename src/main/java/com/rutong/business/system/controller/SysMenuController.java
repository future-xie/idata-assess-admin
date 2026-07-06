package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.utils.StringUtils;
import com.rutong.framework.service.MpBaseService;
import com.rutong.business.system.entity.SysMenu;
import com.rutong.business.system.query.SysMenuQuery;
import com.rutong.business.system.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 菜单信息
 */
@RestController
@RequestMapping("/system/menu")
public class SysMenuController {
    @Autowired
    private SysMenuService menuService;

    @PreAuthorize("@ss.hasPermi('system:menu:list')")
    @GetMapping("/allList")
    public AjaxResult allList(SysMenuQuery query) {
        return AjaxResult.success(getService().findAll(query, java.util.Collections.emptyList()));
    }

    @PreAuthorize("@ss.hasPermi('system:menu:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        return AjaxResult.success(getService().findById(id));
    }

    /**
     * 加载菜单树列表
     */
    @PreAuthorize("@ss.hasPermi('system:menu:list')")
    @GetMapping("/treeselect")
    public AjaxResult treeselect() {
        List<SysMenu> menus = menuService.selectMenuByUserId(SecurityUtils.getUserId());
        return AjaxResult.success(menuService.buildMenuTreeSelect(menus));
    }

    /**
     * 加载对应角色菜单列表树
     */
    @PreAuthorize("@ss.hasPermi('system:menu:list')")
    @GetMapping(value = "/roleMenuTreeselect/{roleId}")
    public AjaxResult roleMenuTreeselect(@PathVariable("roleId") Long roleId) {
        // 角色授权需展示全部菜单（含按钮 F 级操作权限）
        List<SysMenu> menus = menuService.selectAllMenuTree();
        AjaxResult ajax = AjaxResult.success();
        ajax.put("checkedKeys", menuService.selectMenuListByRoleId(roleId));
        ajax.put("menus", menuService.buildMenuTreeSelect(menus));
        return ajax;
    }

    public AjaxResult preData(SysMenu data) {
        if (data.getId() == null) {
            if (!menuService.checkMenuNameUnique(data)) {
                return AjaxResult.error("新增菜单'" + data.getMenuName() + "'失败，菜单名称已存在");
            } else if (UserConstants.YES_FRAME.equals(data.getIsFrame()) && !StringUtils.ishttp(data.getPath())) {
                return AjaxResult.error("新增菜单'" + data.getMenuName() + "'失败，地址必须以http(s)://开头");
            }
        } else {
            if (!menuService.checkMenuNameUnique(data)) {
                return AjaxResult.error("修改菜单'" + data.getMenuName() + "'失败，菜单名称已存在");
            } else if (UserConstants.YES_FRAME.equals(data.getIsFrame()) && !StringUtils.ishttp(data.getPath())) {
                return AjaxResult.error("修改菜单'" + data.getMenuName() + "'失败，地址必须以http(s)://开头");
            } else if (data.getParentId() != null && data.getId().equals(data.getParentId())) {
                return AjaxResult.error("修改菜单'" + data.getMenuName() + "'失败，上级菜单不能选择自己");
            }
        }
        return null;
    }

    @PreAuthorize("@ss.hasPermi('system:menu:add')")
    @OperLog(title = "菜单管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysMenu data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().insert(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:menu:edit')")
    @OperLog(title = "菜单管理", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysMenu data) {
        AjaxResult result = preData(data);
        if (result == null) {
            return AjaxResult.success(getService().update(data));
        }
        return result;
    }

    @PreAuthorize("@ss.hasPermi('system:menu:remove')")
    @OperLog(title = "菜单管理", businessType = BusinessType.DELETE)
    @PostMapping("/deleteById/{id}")
    public AjaxResult delDataById(@PathVariable Long id) {
        if (menuService.hasChildByMenuId(id)) {
            return AjaxResult.warn("存在子菜单,不允许删除");
        }
        return AjaxResult.success(getService().deleteById(id));
    }

    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    public MpBaseService<SysMenu> getService() {
        return menuService;
    }
}