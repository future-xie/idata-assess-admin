package com.rutong.business.questionnaire.pojo;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

/**
 * 题目导入 Excel 行模型
 * 列顺序：章节 | 题型 | 题干 | 选项(逗号分隔) | 是否必填(Y/N)
 */
@Data
public class QuestionImportRow {

    @ExcelProperty("章节")
    private String chapterName;

    @ExcelProperty("题型")
    private String questionType;

    @ExcelProperty("题干")
    private String title;

    @ExcelProperty("选项")
    private String options;

    @ExcelProperty("必填")
    private String required;
}
