package com.rutong.business.system.service;

import com.rutong.business.system.query.SysDeptQuery;
import com.rutong.framework.bean.TreeSelect;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.entity.SysUser;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 部门管理 服务实现
 */
@Service
public class SysDeptService extends BaseService<SysDept> {

    /**
     * 查询部门管理数据
     */
    public List<SysDept> selectDeptList(SysDeptQuery dept) {
        return dao.findAll(SysDept.class, dept, null);
    }

    /**
     * 查询部门树结构信息
     */
    public List<TreeSelect> selectDeptTreeList(SysDeptQuery dept) {
        List<SysDept> depts = selectDeptList(dept);
        return buildDeptTreeSelect(depts);
    }

    /**
     * 构建前端所需要下拉树结构
     */
    public List<TreeSelect> buildDeptTreeSelect(List<SysDept> depts) {
        return depts.stream().map(TreeSelect::new).collect(Collectors.toList());
    }

    /**
     * 根据角色ID查询部门树信息
     */
    public List<Long> selectDeptListByRoleId(Long roleId) {
        SysRole role = dao.findById(SysRole.class, roleId);
        String sql = "select d.id from sys_dept d " +
                " left join sys_role_dept rd on d.id = rd.dept_id " +
                " where rd.role_id = " + roleId;
        sql += " order by d.parent_id, d.order_num";
        return dao.executeSQLQuery(Long.class, sql);
    }

    public Set<Long> getChildrenByDeptId(Long deptId) {
        String sql = "select id from sys_dept where id = " + deptId + " or id in ( SELECT t.id FROM sys_dept t WHERE find_in_set(" + deptId + ", ancestors) )";
        return dao.executeSQLQuery(Long.class, sql).stream().collect(Collectors.toSet());
    }

    /**
     * 是否存在子节点
     *
     * @param deptId 部门ID
     * @return 结果
     */
    public boolean hasChildByDeptId(Long deptId) {
        long result = dao.countByProperty(SysDept.class, "parentId", deptId);
        return result > 0;
    }

    /**
     * 查询部门是否存在用户
     *
     * @param deptId 部门ID
     * @return 结果 true 存在 false 不存在
     */
    public boolean checkDeptExistUser(Long deptId) {
        long result = dao.countByProperty(SysUser.class, "dept.id", deptId);
        return result > 0;
    }

    /**
     * 校验部门名称是否唯一
     *
     * @param dept 部门信息
     * @return 结果
     */
    public boolean checkDeptNameUnique(SysDept dept) {
        Long deptId = StringUtils.isNull(dept.getId()) ? -1L : dept.getId();
        Long parentId;
        if (dept.getParent() != null && dept.getParent().getId() != null) {
            parentId = dept.getParent().getId();
        } else if (dept.getParentId() != null) {
            parentId = dept.getParentId();
        } else {
            parentId = 0L;
        }
        SysDept info;
        if (parentId == 0L) {
            info = dao.findByPropertyFirst(SysDept.class, "deptName", dept.getDeptName(), "parentId", null);
        } else {
            info = dao.findByPropertyFirst(SysDept.class, "deptName", dept.getDeptName(), "parentId", parentId);
        }
        if (StringUtils.isNotNull(info) && info.getId().longValue() != deptId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }
}
