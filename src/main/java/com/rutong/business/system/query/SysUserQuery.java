package com.rutong.business.system.query;

import com.rutong.framework.dao.objectquery.Query;
import lombok.Data;

import java.util.Set;

@Data
public class SysUserQuery{

    private Long deptId;

    @Query(type = Query.Type.IN, propName = "deptId")
    private Set<Long> deptIds;

}
