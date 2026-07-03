package com.rutong.business.system.query;

import com.rutong.framework.dao.objectquery.Query;
import lombok.Data;

import java.util.Date;

@Data
public class SysLogininforQuery {

    @Query(type = Query.Type.INNER_LIKE)
    private String userName;

    /**
     * 登录状态 0成功 1失败
     */
    @Query(type = Query.Type.EQUAL)
    private String status;

    /**
     * 登录IP地址
     */
    @Query(type = Query.Type.INNER_LIKE)
    private String ipaddr;

    @Query(type = Query.Type.GREATER_THAN,propName = "createTime")
    private Date startTime;
    @Query(type = Query.Type.LESS_THAN,propName = "createTime")
    private Date endTime;

}
