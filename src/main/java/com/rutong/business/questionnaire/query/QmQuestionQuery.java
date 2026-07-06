package com.rutong.business.questionnaire.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

/**
 * 题目查询条件
 */
@Data
public class QmQuestionQuery {

    /** 所属模板 ID */
    @Query(type = Query.Type.EQUAL)
    private Long templateId;

    /** 所属章节 ID */
    @Query(type = Query.Type.EQUAL)
    private Long chapterId;

    /** 题型 */
    @Query(type = Query.Type.EQUAL)
    private String questionType;
}
