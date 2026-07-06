package com.rutong.business.questionnaire.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

/**
 * 问卷模板查询条件
 */
@Data
public class QmTemplateQuery {

    /** 模板名称（模糊） */
    @Query(type = Query.Type.INNER_LIKE)
    private String templateName;

    /** 分类（等值） */
    @Query(type = Query.Type.EQUAL)
    private String category;

    /** 状态（等值） */
    @Query(type = Query.Type.EQUAL)
    private String status;

    /** 来源类型（等值） */
    @Query(type = Query.Type.EQUAL)
    private String sourceType;
}
