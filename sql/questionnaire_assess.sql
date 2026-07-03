-- =====================================================================
-- 问卷模板 + 评估管理 模块 DDL 与菜单种子
-- 适配 base_admin 框架（Spring Data JPA，ddl-auto=update 也会自动建表）
-- 字符集 utf8mb4；表前缀 qm_(问卷) / as_(评估)
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 问卷模板
-- ----------------------------
DROP TABLE IF EXISTS `qm_template`;
CREATE TABLE `qm_template` (
  `id`            BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`     VARCHAR(100) NULL,
  `create_time`   DATETIME(6) NULL,
  `remark`        VARCHAR(1024) NULL,
  `update_by`     VARCHAR(100) NULL,
  `update_time`   DATETIME(6) NULL,
  `template_name` VARCHAR(255) NULL,
  `category`      VARCHAR(255) NULL,
  `source_type`   VARCHAR(32) NULL,
  `status`        VARCHAR(32) NULL,
  `style_config`  TEXT NULL,
  `description`   VARCHAR(1024) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 章节
-- ----------------------------
DROP TABLE IF EXISTS `qm_chapter`;
CREATE TABLE `qm_chapter` (
  `id`          BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`   VARCHAR(100) NULL,
  `create_time` DATETIME(6) NULL,
  `remark`      VARCHAR(1024) NULL,
  `update_by`   VARCHAR(100) NULL,
  `update_time` DATETIME(6) NULL,
  `template_id` BIGINT NULL,
  `chapter_name` VARCHAR(255) NULL,
  `order_num`   INT NULL,
  `visible`     VARCHAR(8) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 题目
-- ----------------------------
DROP TABLE IF EXISTS `qm_question`;
CREATE TABLE `qm_question` (
  `id`             BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`      VARCHAR(100) NULL,
  `create_time`    DATETIME(6) NULL,
  `remark`         VARCHAR(1024) NULL,
  `update_by`      VARCHAR(100) NULL,
  `update_time`    DATETIME(6) NULL,
  `template_id`    BIGINT NULL,
  `chapter_id`     BIGINT NULL,
  `question_type`  VARCHAR(32) NULL,
  `title`          VARCHAR(1024) NULL,
  `required`       VARCHAR(8) NULL,
  `order_num`      INT NULL,
  -- 文本类校验参数
  `min_len`        INT NULL,
  `max_len`        INT NULL,
  `regex`          VARCHAR(512) NULL,
  `placeholder`    VARCHAR(255) NULL,
  -- 上传题参数
  `max_count`      INT NULL,
  `max_size`       BIGINT NULL,
  `accept`         VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template_chapter` (`template_id`, `chapter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 题目选项（题型配置子表，替代 JSON）
-- ----------------------------
DROP TABLE IF EXISTS `qm_question_option`;
CREATE TABLE `qm_question_option` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `question_id`  BIGINT NULL,
  `opt_type`     VARCHAR(16) NULL,
  `opt_label`    VARCHAR(255) NULL,
  `opt_value`    VARCHAR(255) NULL,
  `order_num`    INT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 题目逻辑关系（显示逻辑，结构化存储，替代 JSON）
-- ----------------------------
DROP TABLE IF EXISTS `qm_question_logic`;
CREATE TABLE `qm_question_logic` (
  `id`               BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`        VARCHAR(100) NULL,
  `create_time`      DATETIME(6) NULL,
  `remark`           VARCHAR(1024) NULL,
  `update_by`        VARCHAR(100) NULL,
  `update_time`      DATETIME(6) NULL,
  `question_id`      BIGINT NULL,
  `cond_question_id` BIGINT NULL,
  `op`               VARCHAR(16) NULL,
  `cond_value`       VARCHAR(512) NULL,
  `action`           VARCHAR(8) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 个人题库
-- ----------------------------
DROP TABLE IF EXISTS `qm_personal_question`;
CREATE TABLE `qm_personal_question` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `user_id`      BIGINT NULL,
  `question_snapshot` TEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 行业模板库
-- ----------------------------
DROP TABLE IF EXISTS `qm_template_library`;
CREATE TABLE `qm_template_library` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `category`     VARCHAR(255) NULL,
  `template_name` VARCHAR(255) NULL,
  `snapshot`     TEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 评估/分发实例
-- ----------------------------
DROP TABLE IF EXISTS `as_survey`;
CREATE TABLE `as_survey` (
  `id`               BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`        VARCHAR(100) NULL,
  `create_time`      DATETIME(6) NULL,
  `remark`           VARCHAR(1024) NULL,
  `update_by`        VARCHAR(100) NULL,
  `update_time`      DATETIME(6) NULL,
  `template_id`      BIGINT NULL,
  `title`            VARCHAR(255) NULL,
  `respondent_name`  VARCHAR(255) NULL,
  `respondent_email` VARCHAR(255) NULL,
  `fill_token`       VARCHAR(128) NULL,
  `status`           VARCHAR(32) NULL,
  `assessor_ids`     VARCHAR(255) NULL,
  `due_date`         DATETIME(6) NULL,
  `chapter_scope`    VARCHAR(255) NULL,
  `distribute_time`  DATETIME(6) NULL,
  `submit_time`      DATETIME(6) NULL,
  `oper_user_id`     BIGINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_token` (`fill_token`),
  KEY `idx_template_status` (`template_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 答卷答案
-- ----------------------------
DROP TABLE IF EXISTS `as_answer`;
CREATE TABLE `as_answer` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `survey_id`    BIGINT NULL,
  `question_id`  BIGINT NULL,
  `answer_value` TEXT NULL,
  `risk_flag`    VARCHAR(8) NULL,
  `version`      INT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_survey_ver` (`survey_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 风险记录
-- ----------------------------
DROP TABLE IF EXISTS `as_risk_record`;
CREATE TABLE `as_risk_record` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `survey_id`    BIGINT NULL,
  `question_id`  BIGINT NULL,
  `risk_desc`    VARCHAR(1024) NULL,
  `level`        VARCHAR(16) NULL,
  `handle_status` VARCHAR(32) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_survey` (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 答案变更历史（活动流）
-- ----------------------------
DROP TABLE IF EXISTS `as_answer_history`;
CREATE TABLE `as_answer_history` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `survey_id`    BIGINT NULL,
  `question_id`  BIGINT NULL,
  `old_value`    TEXT NULL,
  `new_value`    TEXT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_survey_question` (`survey_id`, `question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 风险库（风险管理模块维护；风险规则引用）
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_lib`;
CREATE TABLE `qm_risk_lib` (
  `id`                  BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`           VARCHAR(100) NULL,
  `create_time`         DATETIME(6) NULL,
  `remark`              VARCHAR(1024) NULL,
  `update_by`           VARCHAR(100) NULL,
  `update_time`         DATETIME(6) NULL,
  `risk_name`           VARCHAR(300) NULL,
  `level`               VARCHAR(16) NULL,
  `risk_desc`           VARCHAR(4000) NULL,
  `category`            VARCHAR(255) NULL,
  `threat`              VARCHAR(255) NULL,
  `vulnerability`       VARCHAR(255) NULL,
  `treatment_plan`      VARCHAR(1024) NULL,
  `inherent_impact`     INT NULL,
  `inherent_probability` INT NULL,
  `inherent_score`      INT NULL,
  `target_impact`       INT NULL,
  `target_probability`  INT NULL,
  `target_score`        INT NULL,
  `residual_impact`     INT NULL,
  `residual_probability` INT NULL,
  `residual_score`      INT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 风险规则（属某模板）
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_rule`;
CREATE TABLE `qm_risk_rule` (
  `id`           BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`    VARCHAR(100) NULL,
  `create_time`  DATETIME(6) NULL,
  `remark`       VARCHAR(1024) NULL,
  `update_by`    VARCHAR(100) NULL,
  `update_time`  DATETIME(6) NULL,
  `template_id`  BIGINT NULL,
  `rule_name`    VARCHAR(255) NULL,
  `risk_lib_id`  BIGINT NULL,
  `level`        VARCHAR(16) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- 风险规则条件（多条 AND）
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_rule_cond`;
CREATE TABLE `qm_risk_rule_cond` (
  `id`               BIGINT NOT NULL AUTO_INCREMENT,
  `create_by`        VARCHAR(100) NULL,
  `create_time`      DATETIME(6) NULL,
  `remark`           VARCHAR(1024) NULL,
  `update_by`        VARCHAR(100) NULL,
  `update_time`      DATETIME(6) NULL,
  `rule_id`          BIGINT NULL,
  `cond_question_id` BIGINT NULL,
  `op`               VARCHAR(16) NULL,
  `cond_value`       VARCHAR(512) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_rule` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- 风险库示例
-- =====================================================================
INSERT INTO `qm_risk_lib` (`risk_name`,`level`,`risk_desc`,`create_by`,`create_time`) VALUES
 ('未建立数据分类分级制度','HIGH','尚未对数据进行分类分级，敏感数据存在暴露风险','admin',NOW()),
 ('缺少个人数据获取同意','MID','采集个人数据时未获取有效同意','admin',NOW()),
 ('未做数据加密传输','HIGH','敏感数据明文传输，存在窃听风险','admin',NOW());

-- ----------------------------
-- 风险登记功能已并入 as_risk_record（评估产生的风险记录），risk_register 表不再使用
-- ----------------------------
DROP TABLE IF EXISTS `risk_register`;

-- =====================================================================
-- 菜单种子（sys_menu）
-- 字段顺序：id,create_by,create_time,remark,update_by,update_time,
--          component,icon,is_cache,is_frame,menu_name,menu_type,order_num,path,perms,query,route_name,visible,parent_id
-- 超管(userId=1)自动拥有所有菜单与 *:*:* 权限；普通角色需配合 sys_role_menu
-- =====================================================================

-- ---------- 问卷管理 ----------
INSERT INTO `sys_menu` VALUES (10000,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'Document','0','0','问卷管理','M',2,'questionnaire','',NULL,'','1',NULL);
INSERT INTO `sys_menu` VALUES (10010,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'questionnaire/template/index','EditPen','1','0','问卷模板','C',1,'template','qm:template:list',NULL,'','1',10000);
INSERT INTO `sys_menu` VALUES (10011,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','模板查询','F',1,'','qm:template:query',NULL,'','1',10010);
INSERT INTO `sys_menu` VALUES (10012,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','模板新增','F',2,'','qm:template:add',NULL,'','1',10010);
INSERT INTO `sys_menu` VALUES (10013,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','模板修改','F',3,'','qm:template:edit',NULL,'','1',10010);
INSERT INTO `sys_menu` VALUES (10014,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','模板删除','F',4,'','qm:template:remove',NULL,'','1',10010);
INSERT INTO `sys_menu` VALUES (10015,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','模板导入','F',5,'','qm:template:import',NULL,'','1',10010);
-- 问卷设计器（隐藏路由，从模板列表进入）
INSERT INTO `sys_menu` VALUES (10020,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'questionnaire/designer/index','','1','0','问卷设计器','C',2,'designer','qm:template:query',NULL,'','0',10000);

-- ---------- 评估管理 ----------
INSERT INTO `sys_menu` VALUES (11000,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'DataAnalysis','0','0','评估管理','M',3,'assessment','',NULL,'','1',NULL);
INSERT INTO `sys_menu` VALUES (11010,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'assessment/survey/index','Promotion','1','0','问卷分发','C',1,'survey','as:survey:list',NULL,'','1',11000);
INSERT INTO `sys_menu` VALUES (11011,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','分发查询','F',1,'','as:survey:query',NULL,'','1',11010);
INSERT INTO `sys_menu` VALUES (11012,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','问卷分发','F',2,'','as:survey:distribute',NULL,'','1',11010);
INSERT INTO `sys_menu` VALUES (11013,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','答卷退回','F',3,'','as:survey:return',NULL,'','1',11010);
INSERT INTO `sys_menu` VALUES (11014,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','分发删除','F',4,'','as:survey:remove',NULL,'','1',11010);
INSERT INTO `sys_menu` VALUES (11015,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','完成审核','F',5,'','as:survey:review',NULL,'','1',11010);
-- 评估详情（隐藏路由，从问卷分发列表"查看"进入）
INSERT INTO `sys_menu` VALUES (11030,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'assessment/survey/detail','','1','0','评估详情','C',3,'surveyDetail','as:survey:query',NULL,'','0',11000);
-- 过程监控已合并到首页(Dashboard)，不再单独挂菜单
DELETE FROM `sys_role_menu` WHERE `menu_id` = 11020;
DELETE FROM `sys_menu` WHERE `id` = 11020;

-- ---------- 风险管理 ----------
INSERT INTO `sys_menu` VALUES (13000,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'Warning','0','0','风险管理','M',4,'risk','',NULL,'','1',NULL);
INSERT INTO `sys_menu` VALUES (13010,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'risk/register/index','List','1','0','风险记录','C',1,'register','risk:register:list',NULL,'','1',13000);
INSERT INTO `sys_menu` VALUES (13011,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险查询','F',1,'','risk:register:query',NULL,'','1',13010);
-- 13012「风险新增」已移除（风险记录由评估流程产生，登记页不提供新增）；下方语句清理已运行环境中的残留
DELETE FROM `sys_role_menu` WHERE `menu_id` = 13012;
DELETE FROM `sys_menu` WHERE `id` = 13012;
INSERT INTO `sys_menu` VALUES (13013,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险修改','F',3,'','risk:register:edit',NULL,'','1',13010);
INSERT INTO `sys_menu` VALUES (13014,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险删除','F',4,'','risk:register:remove',NULL,'','1',13010);
-- 风险库（原规则配置内维护，已移至风险管理模块）
INSERT INTO `sys_menu` VALUES (13020,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'risk/library/index','Files','1','0','风险库','C',2,'library','risk:library:list',NULL,'','1',13000);
INSERT INTO `sys_menu` VALUES (13021,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险库查询','F',1,'','risk:library:query',NULL,'','1',13020);
INSERT INTO `sys_menu` VALUES (13022,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险库新增','F',2,'','risk:library:add',NULL,'','1',13020);
INSERT INTO `sys_menu` VALUES (13023,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险库修改','F',3,'','risk:library:edit',NULL,'','1',13020);
INSERT INTO `sys_menu` VALUES (13024,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,NULL,'','1','0','风险库删除','F',4,'','risk:library:remove',NULL,'','1',13020);

-- =====================================================================
-- 普通角色(role_id=2) 授权可见菜单（含列表/查询权限）
-- =====================================================================
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
 (2,10000),(2,10010),(2,10011),(2,10020),
 (2,11000),(2,11010),(2,11011),(2,11013),(2,11015),
 (2,13000),(2,13010),(2,13011),
 (2,13020),(2,13021);

-- =====================================================================
-- 迁移：受访人登录填写改造（升级到登录填写模式后手动执行）
-- 1) as_survey.respondent_user_id 已由 ddl-auto 自动新增；按邮箱回填历史数据：
-- UPDATE as_survey s JOIN sys_user u ON s.respondent_email = u.email
--   SET s.respondent_user_id = u.id WHERE s.respondent_user_id IS NULL;
-- 2) 移除免登残留字段（确认无依赖后执行）：
-- ALTER TABLE as_survey DROP COLUMN fill_token;
-- 3) as_request.sender_type / sender_user_id 已由 ddl-auto 自动新增
-- =====================================================================

-- =====================================================================
-- 迁移：风险登记处理-审核工单（手动执行）
-- 1) as_risk_record 加整改状态列（ddl-auto 自动新增；回填历史为未处理）：
-- ALTER TABLE as_risk_record ADD COLUMN process_status VARCHAR(16) DEFAULT 'UNPROCESSED';
-- UPDATE as_risk_record SET process_status = 'UNPROCESSED' WHERE process_status IS NULL;
-- 2) as_risk_process 处理记录表（ddl-auto 自动建；如需手动）：
-- CREATE TABLE as_risk_process (
--   id BIGINT PRIMARY KEY AUTO_INCREMENT,
--   risk_record_id BIGINT NOT NULL,
--   content TEXT, attachments TEXT, review_content TEXT,
--   review_by VARCHAR(100), review_time DATETIME,
--   create_by VARCHAR(100), create_time DATETIME,
--   update_by VARCHAR(100), update_time DATETIME, remark VARCHAR(1024),
--   INDEX idx_risk_process_record (risk_record_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- =====================================================================

-- =====================================================================
-- 示例：行业模板库（"模板创建"可选）
-- snapshot 为章节+题目结构，createFromLibrary 会据此恢复
-- =====================================================================
INSERT INTO `qm_template_library` (`category`,`template_name`,`snapshot`,`create_by`,`create_time`)
VALUES ('通用','数据合规基础自评问卷',
'{"chapters":[{"chapterName":"一、数据采集","orderNum":1,"visible":"Y","questions":[
  {"questionType":"RADIO","title":"是否建立了数据分类分级制度？","optionsConfig":"{\"options\":[\"是\",\"否\",\"制定中\"]}","required":"Y","orderNum":1},
  {"questionType":"CHECKBOX","title":"采集个人数据时获取同意的方式（多选）？","optionsConfig":"{\"options\":[\"弹窗告知\",\"隐私政策\",\"签字同意\",\"其他\"]}","required":"Y","orderNum":2},
  {"questionType":"TEXTAREA","title":"请简要说明数据采集范围与目的","required":"N","orderNum":3}
]}]}',
'admin','2026-07-01 00:00:00.000000');

-- =====================================================================
-- 邮件配置默认值（sys_config，前端"邮件配置"页面维护）
-- =====================================================================
INSERT INTO `sys_config` (`config_name`,`config_key`,`config_value`,`config_type`,`create_by`,`create_time`) VALUES
 ('邮件-是否启用','mail.enabled','false','Y','admin',NOW()),
 ('邮件-SMTP主机','mail.host','','Y','admin',NOW()),
 ('邮件-SMTP端口','mail.port','465','Y','admin',NOW()),
 ('邮件-账号','mail.username','','Y','admin',NOW()),
 ('邮件-密码/授权码','mail.password','','Y','admin',NOW()),
 ('邮件-是否SSL','mail.ssl','true','Y','admin',NOW()),
 ('邮件-发件人','mail.from','','Y','admin',NOW()),
 ('邮件-发件人名称','mail.fromName','数据合规管理后台','Y','admin',NOW()),
 ('邮件-前端地址','mail.frontUrl','http://localhost:3000','Y','admin',NOW());

-- =====================================================================
-- 邮件配置 菜单（挂于"系统管理" id=1 下）
-- =====================================================================
INSERT INTO `sys_menu` VALUES (12000,'admin','2026-07-01 00:00:00.000000',NULL,NULL,NULL,'system/mail/index','Message','1','0','邮件配置','C',9,'mail','system:mail:config',NULL,'','1',1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2,12000);

