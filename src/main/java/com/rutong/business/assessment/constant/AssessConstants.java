package com.rutong.business.assessment.constant;

/**
 * 评估模块常量
 */
public class AssessConstants {

    /** 评估状态 */
    public static final String STATUS_DISTRIBUTED = "DISTRIBUTED";
    public static final String STATUS_FILLING = "FILLING";
    /** 已废弃(保留以兼容历史代码),提交后状态应使用 STATUS_REVIEWING */
    @Deprecated
    public static final String STATUS_SUBMITTED = "SUBMITTED";
    /** 审核中(受访人/管理端提交后进入该状态) */
    public static final String STATUS_REVIEWING = "REVIEWING";
    public static final String STATUS_RETURNED = "RETURNED";
    /** 审核通过(完成审核时选择"通过") */
    public static final String STATUS_APPROVED = "APPROVED";
    /** 已拒绝(完成审核时选择"拒绝") */
    public static final String STATUS_REJECTED = "REJECTED";

    /** 风险等级 */
    public static final String LEVEL_HIGH = "HIGH";
    public static final String LEVEL_MID = "MID";
    public static final String LEVEL_LOW = "LOW";

    /** 风险处理状态 */
    public static final String HANDLE_PENDING = "PENDING";
    public static final String HANDLE_PROCESSING = "PROCESSING";
    public static final String HANDLE_CLOSED = "CLOSED";

    /** 风险整改状态（处理-审核工单） */
    public static final String PROCESS_STATUS_UNPROCESSED = "UNPROCESSED";
    public static final String PROCESS_STATUS_PROCESSING = "PROCESSING";
    public static final String PROCESS_STATUS_RECTIFIED = "RECTIFIED";
    public static final String PROCESS_STATUS_UNRECTIFIED = "UNRECTIFIED";

    /** 角色 / 请求发起方 */
    public static final String ROLE_RESPONDENT = "RESPONDENT";
    public static final String ROLE_REVIEWER = "REVIEWER";

    /** 通用是否 */
    public static final String YES = "Y";
    public static final String NO = "N";

    private AssessConstants() {
    }
}
