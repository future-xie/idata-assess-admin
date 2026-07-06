package com.rutong.business.system.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rutong.business.system.entity.SysDept;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.system.mapper.SysDeptMapper;
import com.rutong.business.system.mapper.SysUserMapper;
import com.rutong.business.system.query.SysDeptQuery;
import com.rutong.framework.bean.TreeSelect;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 部门管理 服务实现
 */
@Service
public class SysDeptService extends MpBaseService<SysDept> {

    @Autowired
    private SysDeptMapper deptMapper;
    @Autowired
    private SysUserMapper userMapper;

    /**
     * 查询部门管理数据（带数据权限）
     */
    public List<SysDept> selectDeptList(SysDeptQuery dept) {
        return findAll(dept, null);
    }

    /**
     * 由扁平部门列表构建嵌套 TreeSelect（SysDept 已无 children 关联，按 parentId 手动嵌套）
     */
    public List<TreeSelect> buildDeptTreeSelect(List<SysDept> depts) {
        Map<Long, TreeSelect> map = new LinkedHashMap<>();
        for (SysDept d : depts) {
            map.put(d.getId(), new TreeSelect(d));
        }
        List<TreeSelect> roots = new ArrayList<>();
        for (SysDept d : depts) {
            TreeSelect ts = map.get(d.getId());
            if (d.getParentId() == null || !map.containsKey(d.getParentId())) {
                roots.add(ts);
            } else {
                map.get(d.getParentId()).getChildren().add(ts);
            }
        }
        return roots;
    }

    /**
     * 根据角色ID查询部门 ID 列表
     */
    public List<Long> selectDeptListByRoleId(Long roleId) {
        return deptMapper.selectDeptIdsByRoleId(roleId);
    }

    /**
     * 部门及其所有子部门 ID 集合（find_in_set 递归树）
     */
    public Set<Long> getChildrenByDeptId(Long deptId) {
        return deptMapper.selectDeptIdsByAncestors(deptId).stream().collect(Collectors.toSet());
    }

    public boolean hasChildByDeptId(Long deptId) {
        return lambdaQuery().eq(SysDept::getParentId, deptId).count() > 0;
    }

    /**
     * 查询部门是否存在用户（原 dao.countByProperty("dept.id", deptId)）
     */
    public boolean checkDeptExistUser(Long deptId) {
        return userMapper.selectCount(new LambdaQueryWrapper<SysUser>().eq(SysUser::getDeptId, deptId)) > 0;
    }

    /**
     * 校验部门名称是否唯一（同级下）
     */
    public boolean checkDeptNameUnique(SysDept dept) {
        Long deptId = StringUtils.isNull(dept.getId()) ? -1L : dept.getId();
        Long parentId = dept.getParentId() != null ? dept.getParentId() : 0L;
        SysDept info = lambdaQuery()
                .eq(SysDept::getDeptName, dept.getDeptName())
                .eq(SysDept::getParentId, parentId)
                .one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != deptId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 新增部门：自动填充 ancestors（父的 ancestors + "," + 父 id）。顶级部门 parent_id=0
     *（外键已由 V4 迁移移除，parent_id=0 不再受限）。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insert(SysDept dept) {
        Long parentId = dept.getParentId() != null ? dept.getParentId() : 0L;
        dept.setParentId(parentId);
        dept.setAncestors(buildAncestors(parentId));
        return super.insert(dept);
    }

    /**
     * 修改部门：父级变更时重算自身 ancestors，并级联更新子孙（旧前缀替换为新前缀）。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(SysDept dept) {
        Long parentId = dept.getParentId() != null ? dept.getParentId() : 0L;
        if (parentId.equals(dept.getId())) {
            throw new ServiceException("修改部门失败，上级部门不能是自己");
        }
        dept.setParentId(parentId);
        SysDept oldDept = findById(dept.getId());
        if (oldDept == null) {
            return super.update(dept);
        }
        String newAncestors = buildAncestors(parentId);
        String oldAncestors = oldDept.getAncestors();
        dept.setAncestors(newAncestors);
        int rows = super.update(dept);
        // 父级变化：级联替换子孙 ancestors 的旧前缀为新前缀
        if (oldAncestors != null && !oldAncestors.equals(newAncestors)) {
            deptMapper.updateDeptChildrenAncestors(dept.getId(), oldAncestors, newAncestors);
        }
        return rows;
    }

    /** 计算指定父级的 ancestors：顶级(0/null) → "0"；否则 父的 ancestors + "," + 父 id */
    private String buildAncestors(Long parentId) {
        if (parentId == null || parentId == 0L) {
            return "0";
        }
        SysDept parent = findById(parentId);
        if (parent == null) {
            return "0";
        }
        return (parent.getAncestors() != null ? parent.getAncestors() : "0") + "," + parentId;
    }
}
