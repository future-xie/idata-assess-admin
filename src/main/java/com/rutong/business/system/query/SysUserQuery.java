package com.rutong.business.system.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

import java.util.Set;

@Data
public class SysUserQuery {

    private Long deptId;

    @Query(type = Query.Type.IN, propName = "deptId")
    private Set<Long> deptIds;

    /** 用户名（模糊） */
    private String userName;

    /** 手机号（模糊） */
    private String phonenumber;

    /** 状态（1正常 0停用） */
    private String status;

}
