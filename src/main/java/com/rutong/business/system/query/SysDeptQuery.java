package com.rutong.business.system.query;

import com.rutong.framework.mybatis.objectquery.Query;
import lombok.Data;

@Data
public class SysDeptQuery{

    @Query(type = Query.Type.IS_NULL,propName = "parentId")
    private Boolean parentIdIsNull;

}
