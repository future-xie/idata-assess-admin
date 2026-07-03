package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.query.SysUserQuery;
import com.rutong.business.system.service.SysDeptService;
import com.rutong.business.system.service.SysRoleService;
import com.rutong.business.system.service.SysUserService;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 用户信息
 */
@RestController
@RequestMapping("/system/user")
public class SysUserController {
    @Autowired
    private SysUserService userService;

    @Autowired
    private SysRoleService roleService;

    @Autowired
    private SysDeptService deptService;

    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUserQuery query, PageBean page) {
        if (query.getDeptId() != null) {
            Set<Long> deptIds = deptService.getChildrenByDeptId(query.getDeptId());
            query.setDeptIds(deptIds);
        }
        return getService().findAllByPage(page, query, List.of(new SortFilter("id", SortFilter.DESC)));
    }

    @PreAuthorize("@ss.hasPermi('system:user:query')")
    @GetMapping(value = "/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable(required = false) Long id) {
        AjaxResult ajax = AjaxResult.success();
        if (id != null) {
            SysUser sysUser = userService.findById(id);
            ajax.put(AjaxResult.DATA_TAG, sysUser);

            Set<SysRole> roles = sysUser.getRoles();
            ajax.put("roleIds", roles.stream().map(SysRole::getId).collect(Collectors.toList()));
        }
        List<SysRole> roles = roleService.selectRoleAll();
        ajax.put("roles", roles);
        return ajax;
    }

    @PreAuthorize("@ss.hasPermi('system:user:add')")
    @OperLog(title = "用户管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult addData(@Validated @RequestBody SysUser data) {
        if (!userService.checkUserNameUnique(data)) {
            return AjaxResult.error("新增用户'" + data.getUserName() + "'失败，登录账号已存在");
        }
        data.setPassword(SecurityUtils.encryptPassword(data.getPassword()));
        return AjaxResult.success(userService.insert(data));
    }

    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @OperLog(title = "用户管理", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult editData(@Validated @RequestBody SysUser data) {
        userService.checkUserAllowed(data.getId());

        if (!userService.checkUserNameUnique(data)) {
            return AjaxResult.error("修改用户'" + data.getUserName() + "'失败，登录账号已存在");
        }
        return AjaxResult.success(userService.update(data));
    }

    @PreAuthorize("@ss.hasPermi('system:user:remove')")
    @OperLog(title = "用户管理", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delData(@PathVariable Long[] ids) {
        if (ArrayUtils.contains(ids, SecurityUtils.getUserId())) {
            return AjaxResult.error("当前用户不能删除");
        }
        return AjaxResult.success(userService.deleteUserByIds(ids));
    }

    /**
     * 重置密码（默认密码654321）
     */
    @PreAuthorize("@ss.hasPermi('system:user:edit')")
    @OperLog(title = "用户管理", businessType = BusinessType.UPDATE)
    @PostMapping("/resetPwd")
    public AjaxResult resetPwd(@RequestBody SysUser user) {
        userService.checkUserAllowed(user.getId());
        user.setPassword(SecurityUtils.encryptPassword("654321"));
        return AjaxResult.success(userService.resetUserPwd(user.getId(), user.getPassword()));
    }

    public BaseService getService() {
        return userService;
    }
}