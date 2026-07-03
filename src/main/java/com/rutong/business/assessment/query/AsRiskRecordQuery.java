package com.rutong.business.assessment.query;

import com.rutong.framework.dao.objectquery.Query;
import lombok.Data;

/**
 * 风险记录查询条件
 */
@Data
public class AsRiskRecordQuery {

    /** 风险等级：HIGH/MID/LOW */
    @Query(type = Query.Type.EQUAL)
    private String level;

    /** 处理状态：PENDING/PROCESSING/CLOSED */
    @Query(type = Query.Type.EQUAL)
    private String handleStatus;

    /** 整改状态：UNPROCESSED/PROCESSING/RECTIFIED/UNRECTIFIED */
    @Query(type = Query.Type.EQUAL)
    private String processStatus;

    /** 风险描述（模糊） */
    @Query(type = Query.Type.INNER_LIKE)
    private String riskDesc;
}
