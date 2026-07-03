-- 题目修改请求记录表
-- 用于持久化"创建请求"操作,前端查看请求时拉取该题的所有请求列表

CREATE TABLE IF NOT EXISTS as_request (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    survey_id BIGINT NOT NULL COMMENT '评估实例ID',
    question_id BIGINT NOT NULL COMMENT '题目ID',
    content VARCHAR(2000) NOT NULL COMMENT '请求内容',
    create_by VARCHAR(100) DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    update_by VARCHAR(100) DEFAULT NULL COMMENT '更新人',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间',
    remark VARCHAR(1024) DEFAULT NULL COMMENT '备注',
    INDEX idx_as_request_survey_question (survey_id, question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目修改请求';
