package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.security.service.PermissionService;
import com.rutong.framework.security.service.TokenService;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.query.SysRoleQuery;
import com.rutong.business.system.service.SysDeptService;
import com.rutong.business.system.service.SysRoleService;
import com.rutong.business.system.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 角色信息
 */
@RestController
@RequestMapping("/system/role")
public class SysRoleController {
    @Autowired
    private SysRoleService roleService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private SysUserService userService;

    @Autowired
    private SysDeptService deptService;

    @PreAuthorize("@ss.hasPermi('system:role:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysRoleQuery query, PageBean page) {
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @GetMapping("/allList")
    public AjaxResult allList(SysRoleQuery query) {
        return AjaxResult.success(getService().findAll(query, List.of()));
    }

    @PreAuthorize("@ss.hasPermi('system:role:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        AjaxResult ajax = AjaxResult.success(roleService.findById(id));
        ajax.put("deptIds", deptService.selectDeptListByRoleId(id));
        return ajax;
    }

    @PreAuthorize("@ss.hasPermi('system:role:add')")
    @OperLog(title = "角色管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysRole data) {
        if (!roleService.checkRoleNameUnique(data)) {
            return AjaxResult.error("新增角色'" + data.getRoleName() + "'失败，角色名称已存在");
        } else if (!roleService.checkRoleKeyUnique(data)) {
            return AjaxResult.error("新增角色'" + data.getRoleName() + "'失败，角色权限已存在");
        }
        return AjaxResult.success(roleService.insertRole(data));
    }

    @PreAuthorize("@ss.hasPermi('system:role:edit')")
    @OperLog(title = "角色管理", businessType = BusinessType.UPDATE)
    @PostMapping(value = "/update")
    public AjaxResult editData(@RequestBody SysRole data) {
        if (!roleService.checkRoleNameUnique(data)) {
            return AjaxResult.error("修改角色'" + data.getRoleName() + "'失败，角色名称已存在");
        } else if (!roleService.checkRoleKeyUnique(data)) {
            return AjaxResult.error("修改角色'" + data.getRoleName() + "'失败，角色权限已存在");
        }
        if (roleService.updateRole(data) > 0) {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            SysUser user = userService.findById(loginUser.getUserId());
            if (StringUtils.isNotNull(user) && !user.isAdmin()) {
                loginUser.setPermissions(permissionService.getMenuPermission(loginUser));
                tokenService.setLoginUser(loginUser);
            }
            return AjaxResult.success();
        }
        return AjaxResult.error("修改角色'" + data.getRoleName() + "'失败，请联系管理员");
    }

    @PreAuthorize("@ss.hasPermi('system:role:remove')")
    @OperLog(title = "角色管理", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        getService().deleteByIds(ids);
        return AjaxResult.success();
    }

    @PostMapping("/deleteById/{id}")
    public AjaxResult delDataById(@PathVariable("id") Long id) {
        return AjaxResult.success(getService().deleteById(id));
    }

    public AjaxResult preData(SysRole data) {
        return null;
    }

    @PreAuthorize("@ss.hasPermi('system:role:edit')")
    @OperLog(title = "角色管理", businessType = BusinessType.GRANT)
    @PostMapping("/authMenu")
    public AjaxResult authMenu(@RequestBody Map<String, Object> params) {
        Long roleId = Long.valueOf(params.get("roleId").toString());
        @SuppressWarnings("unchecked")
        List<Long> menuIds = ((List<Number>) params.get("menuIds")).stream()
                .map(Number::longValue).collect(java.util.stream.Collectors.toList());
        roleService.authMenu(roleId, menuIds);
        return AjaxResult.success();
    }

    public BaseService getService() {
        return roleService;
    }
}