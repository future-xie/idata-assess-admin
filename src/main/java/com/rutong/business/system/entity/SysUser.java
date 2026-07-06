package com.rutong.business.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_user")
public class SysUser extends BaseEntity {

    private String userName;
    private String nickName;
    /** 密码 */
    private String password;
    /** 手机号码 */
    private String phonenumber;
    /** 用户邮箱 */
    private String email;
    /** 帐号状态（1正常 0停用） */
    private String status;

    /** 头像 */
    private String avatar;

    /** 部门 ID（持久化，对应 dept_id 列；原 JPA @ManyToOne dept 已移除） */
    @TableField(value = "dept_id")
    private Long deptId;

    /** 部门名称（关联 sys_dept 查询得到，不持久化） */
    @TableField(exist = false)
    private String deptName;

    /** 角色 ID 列表（新增/编辑用户时维护 sys_user_role，不持久化到 sys_user） */
    @TableField(exist = false)
    private java.util.List<Long> roleIds;

    public boolean isAdmin() {
        return isAdmin(this.getId());
    }

    public static boolean isAdmin(Long userId) {
        return userId != null && 1L == userId;
    }
}
