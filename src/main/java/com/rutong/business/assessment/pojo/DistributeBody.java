package com.rutong.business.assessment.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 发起评估请求体。
 * assignments：每个受访人的分配；chapterIds 为空表示该受访人回答全部章节。
 */
@Data
public class DistributeBody {

    /** 评估模板 ID */
    private Long templateId;

    /** 评估名称 */
    private String title;

    /** 评估人（用户 ID） */
    private List<Long> assessorIds;

    /** 截止日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dueDate;

    /** 受访人分配列表 */
    private List<AssignItem> assignments;
}
