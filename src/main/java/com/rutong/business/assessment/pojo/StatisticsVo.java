package com.rutong.business.assessment.pojo;

import lombok.Data;

/**
 * 过程监控统计
 */
@Data
public class StatisticsVo {

    /** 总分发数 */
    private long total;

    /** 已提交数 */
    private long submitted;

    /** 已退回数 */
    private long returned;

    /** 已完成数（与 submitted 口径一致，预留细分） */
    private long completed;

    /** 回收率 = 已回收 / 总分发 */
    private double recoveryRate;

    /** 完成率 = 已完成 / 已回收 */
    private double completionRate;
}
