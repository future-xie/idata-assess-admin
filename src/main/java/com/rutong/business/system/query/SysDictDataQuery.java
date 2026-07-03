package com.rutong.business.system.query;

import com.rutong.framework.dao.objectquery.Query;
import lombok.Data;

@Data
public class SysDictDataQuery{

    @Query(type = Query.Type.EQUAL,propName = "id",joinName = "dictType")
    private Long dictTypeId;

}
