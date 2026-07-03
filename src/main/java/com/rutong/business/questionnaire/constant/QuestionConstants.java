package com.rutong.business.questionnaire.constant;

/**
 * 问卷模块常量
 */
public class QuestionConstants {

    /** 来源类型 */
    public static final String SOURCE_BLANK = "BLANK";
    public static final String SOURCE_TEMPLATE = "TEMPLATE";
    public static final String SOURCE_COPY = "COPY";
    public static final String SOURCE_IMPORT = "IMPORT";

    /** 模板状态 */
    public static final String STATUS_DRAFT = "DRAFT";
    public static final String STATUS_PUBLISHED = "PUBLISHED";
    public static final String STATUS_ARCHIVED = "ARCHIVED";

    /** 题型 */
    public static final String TYPE_RADIO = "RADIO";
    public static final String TYPE_CHECKBOX = "CHECKBOX";
    public static final String TYPE_SELECT = "SELECT";
    public static final String TYPE_TEXT = "TEXT";
    public static final String TYPE_DATE = "DATE";
    public static final String TYPE_BOOLEAN = "BOOLEAN";
    public static final String TYPE_UPLOAD = "UPLOAD";
    public static final String TYPE_DESCRIPTION = "DESCRIPTION";

    /** 选项类型（qm_question_option.opt_type） */
    public static final String OPT_OPTION = "OPTION";

    /** 逻辑操作符（qm_question_logic.op） */
    public static final String OP_EQ = "EQ";
    public static final String OP_NE = "NE";
    public static final String OP_IN = "IN";

    /** 逻辑动作（qm_question_logic.action） */
    public static final String ACTION_SHOW = "SHOW";
    public static final String ACTION_HIDE = "HIDE";

    /** 通用是否 */
    public static final String YES = "Y";
    public static final String NO = "N";

    private QuestionConstants() {
    }
}
