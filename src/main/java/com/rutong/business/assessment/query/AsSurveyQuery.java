package com.rutong.business.assessment.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

/**
 * 评估实例查询条件
 */
@Data
public class AsSurveyQuery {

    /** 模板 ID */
    @Query(type = Query.Type.EQUAL)
    private Long templateId;

    /** 受访者姓名（模糊） */
    @Query(type = Query.Type.INNER_LIKE)
    private String respondentName;

    /** 受访者邮箱（模糊） */
    @Query(type = Query.Type.INNER_LIKE)
    private String respondentEmail;

    /** 状态 */
    @Query(type = Query.Type.EQUAL)
    private String status;
}
