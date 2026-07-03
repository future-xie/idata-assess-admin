package com.rutong.business.system.query;

import com.rutong.framework.dao.objectquery.Query;
import lombok.Data;

import java.util.Date;

@Data
public class SysOperLogQuery {

    @Query(type = Query.Type.INNER_LIKE)
    private String title;
    @Query(type = Query.Type.INNER_LIKE)
    private String operName;
    @Query(type = Query.Type.INNER_LIKE)
    private String operUrl;
    @Query(type = Query.Type.INNER_LIKE)
    private String operIp;

    @Query(type = Query.Type.EQUAL)
    private Integer status;

    @Query(type = Query.Type.GREATER_THAN,propName = "createTime")
    private Date startTime;
    @Query(type = Query.Type.LESS_THAN,propName = "createTime")
    private Date endTime;
}
