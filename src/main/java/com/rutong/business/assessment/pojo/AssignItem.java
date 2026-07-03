package com.rutong.business.assessment.pojo;

import lombok.Data;

import java.util.List;

/**
 * 单个受访人的章节分配。
 */
@Data
public class AssignItem {

    /** 受访人用户 ID */
    private Long userId;

    /** 分配的章节 ID（空表示全部章节） */
    private List<Long> chapterIds;
}
