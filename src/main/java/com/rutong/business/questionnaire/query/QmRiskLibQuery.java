package com.rutong.business.questionnaire.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

/**
 * 风险库查询条件
 */
@Data
public class QmRiskLibQuery {

    /** 风险名称（模糊） */
    @Query(type = Query.Type.INNER_LIKE)
    private String riskName;
}
