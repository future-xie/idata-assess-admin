package com.rutong.business.system.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.rutong.business.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "sys_user")
public class SysUser extends BaseEntity {

    private String userName;
    private String nickName;
    /**
     * 密码
     */
    private String password;
    /** 手机号码 */
    private String phonenumber;
    /** 用户邮箱 */
    private String email;
    /**
     * 帐号状态（1正常 0停用）
     */
    private String status;

    //头像
    @Column(length = 1024)
    private String avatar;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToMany
    @JoinTable(
            name = "sys_user_role",          // 中间表名
            joinColumns = @JoinColumn(name = "user_id"),   // 当前实体在中间表的外键
            inverseJoinColumns = @JoinColumn(name = "role_id") // 对方实体在中间表的外键
    )
    private Set<SysRole> roles  = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "dept_id", nullable = false)
    private SysDept dept;

    public boolean isAdmin() {
        return isAdmin(this.getId());
    }

    public static boolean isAdmin(Long userId) {
        return userId != null && 1L == userId;
    }
}
