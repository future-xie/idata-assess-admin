/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : assess_admin

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 06/07/2026 14:54:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for as_answer
-- ----------------------------
DROP TABLE IF EXISTS `as_answer`;
CREATE TABLE `as_answer`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `survey_id` bigint NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `answer_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `risk_flag` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `version` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_survey_ver`(`survey_id` ASC, `version` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_answer
-- ----------------------------
INSERT INTO `as_answer` VALUES (1, 'admin', '2026-07-03 16:07:20.237000', '', 'admin', '2026-07-03 16:07:20.237000', 1, 18, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (2, 'admin', '2026-07-03 16:09:53.929000', '', 'admin', '2026-07-03 16:09:53.929000', 1, 2, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (3, 'admin', '2026-07-03 16:09:54.663000', '', 'admin', '2026-07-03 16:09:54.663000', 1, 3, '部分落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (4, 'admin', '2026-07-03 16:09:56.053000', '', 'admin', '2026-07-03 16:09:56.053000', 1, 4, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (5, 'admin', '2026-07-03 16:09:57.315000', '', 'admin', '2026-07-03 16:09:57.315000', 1, 5, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (6, 'admin', '2026-07-03 16:10:00.341000', '', 'admin', '2026-07-03 16:10:00.341000', 1, 6, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (7, 'admin', '2026-07-03 16:10:00.904000', '', 'admin', '2026-07-03 16:10:00.904000', 1, 7, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (8, 'admin', '2026-07-03 16:10:01.857000', '', 'admin', '2026-07-03 16:10:01.857000', 1, 8, '[\"书面签署\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (9, 'admin', '2026-07-03 16:10:03.983000', '', 'admin', '2026-07-03 16:10:03.983000', 1, 9, '官方网站公示', 'N', NULL);
INSERT INTO `as_answer` VALUES (10, 'admin', '2026-07-03 16:10:05.339000', '', 'admin', '2026-07-03 16:10:05.339000', 1, 10, 'N', 'N', NULL);
INSERT INTO `as_answer` VALUES (11, 'admin', '2026-07-03 16:10:07.605000', '', 'admin', '2026-07-03 16:10:07.605000', 1, 11, '已落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (12, 'admin', '2026-07-03 16:10:09.319000', '', 'admin', '2026-07-03 16:10:09.319000', 1, 12, '部分落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (13, 'admin', '2026-07-03 16:10:10.637000', '', 'admin', '2026-07-03 16:10:10.637000', 1, 13, '[\"宗教信仰\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (14, 'admin', '2026-07-03 16:10:14.157000', '', 'admin', '2026-07-03 16:10:14.157000', 1, 14, '无', 'N', NULL);
INSERT INTO `as_answer` VALUES (15, 'admin', '2026-07-03 16:10:17.451000', '', 'admin', '2026-07-03 16:10:17.451000', 1, 15, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (16, 'admin', '2026-07-03 16:10:18.099000', '', 'admin', '2026-07-03 16:10:18.099000', 1, 16, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (17, 'admin', '2026-07-03 16:10:18.866000', '', 'admin', '2026-07-03 16:10:18.866000', 1, 17, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (18, 'admin', '2026-07-03 16:10:22.196000', '', 'admin', '2026-07-03 16:10:22.196000', 1, 19, '111', 'N', NULL);
INSERT INTO `as_answer` VALUES (19, 'admin', '2026-07-03 16:10:23.986000', '', 'admin', '2026-07-03 16:10:23.986000', 1, 20, '[\"访问权限控制\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (20, 'admin', '2026-07-03 16:10:25.240000', '', 'admin', '2026-07-03 16:10:25.240000', 1, 21, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (21, 'admin', '2026-07-03 16:10:26.709000', '', 'admin', '2026-07-03 16:10:26.709000', 1, 22, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (22, 'xiaoming', '2026-07-06 14:44:58.911000', '', 'xiaoming', '2026-07-06 14:44:58.911000', 2, 2, '部分落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (23, 'xiaoming', '2026-07-06 14:44:59.939000', '', 'xiaoming', '2026-07-06 14:44:59.939000', 2, 3, '部分落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (24, 'xiaoming', '2026-07-06 14:45:02.119000', '', 'xiaoming', '2026-07-06 14:45:02.119000', 2, 4, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (25, 'xiaoming', '2026-07-06 14:45:02.630000', '', 'xiaoming', '2026-07-06 14:45:02.630000', 2, 5, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (26, 'xiaoming', '2026-07-06 14:45:05.197000', '', 'xiaoming', '2026-07-06 14:45:05.197000', 2, 6, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (27, 'xiaoming', '2026-07-06 14:45:06.324000', '', 'xiaoming', '2026-07-06 14:45:06.324000', 2, 7, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (28, 'xiaoming', '2026-07-06 14:45:06.819000', '', 'xiaoming', '2026-07-06 14:45:06.819000', 2, 8, '[\"书面签署\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (29, 'xiaoming', '2026-07-06 14:45:08.792000', '', 'xiaoming', '2026-07-06 14:45:08.792000', 2, 9, '纸质告知', 'N', NULL);
INSERT INTO `as_answer` VALUES (30, 'xiaoming', '2026-07-06 14:45:10.668000', '', 'xiaoming', '2026-07-06 14:45:10.668000', 2, 10, 'N', 'N', NULL);
INSERT INTO `as_answer` VALUES (31, 'xiaoming', '2026-07-06 14:45:13.393000', '', 'xiaoming', '2026-07-06 14:45:13.393000', 2, 11, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (32, 'xiaoming', '2026-07-06 14:45:14.087000', '', 'xiaoming', '2026-07-06 14:45:14.087000', 2, 12, '未落实', 'N', NULL);
INSERT INTO `as_answer` VALUES (33, 'xiaoming', '2026-07-06 14:45:15.176000', '', 'xiaoming', '2026-07-06 14:45:15.176000', 2, 13, '[\"宗教信仰\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (34, 'xiaoming', '2026-07-06 14:45:15.993000', '', 'xiaoming', '2026-07-06 14:45:15.993000', 2, 14, '12', 'N', NULL);
INSERT INTO `as_answer` VALUES (35, 'xiaoming', '2026-07-06 14:45:20.611000', '', 'xiaoming', '2026-07-06 14:45:20.611000', 2, 15, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (36, 'xiaoming', '2026-07-06 14:45:21.530000', '', 'xiaoming', '2026-07-06 14:45:21.530000', 2, 16, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (37, 'xiaoming', '2026-07-06 14:45:22.103000', '', 'xiaoming', '2026-07-06 14:45:22.103000', 2, 17, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (38, 'xiaoming', '2026-07-06 14:45:23.549000', '', 'xiaoming', '2026-07-06 14:45:23.549000', 2, 18, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (39, 'xiaoming', '2026-07-06 14:45:27.085000', '', 'xiaoming', '2026-07-06 14:45:27.085000', 2, 19, '11', 'N', NULL);
INSERT INTO `as_answer` VALUES (40, 'xiaoming', '2026-07-06 14:45:28.754000', '', 'xiaoming', '2026-07-06 14:45:28.754000', 2, 20, '[\"员工培训\"]', 'N', NULL);
INSERT INTO `as_answer` VALUES (41, 'xiaoming', '2026-07-06 14:45:29.898000', '', 'xiaoming', '2026-07-06 14:45:29.898000', 2, 21, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (42, 'xiaoming', '2026-07-06 14:45:30.548000', '', 'xiaoming', '2026-07-06 14:45:30.548000', 2, 22, '不适用', 'N', NULL);
INSERT INTO `as_answer` VALUES (43, 'xiaoming', '2026-07-06 14:45:32.665000', '', 'xiaoming', '2026-07-06 14:45:32.665000', 2, 23, '2026-07-24', 'N', NULL);

-- ----------------------------
-- Table structure for as_answer_history
-- ----------------------------
DROP TABLE IF EXISTS `as_answer_history`;
CREATE TABLE `as_answer_history`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `survey_id` bigint NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `old_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `new_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_survey_question`(`survey_id` ASC, `question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_answer_history
-- ----------------------------
INSERT INTO `as_answer_history` VALUES (1, 'admin', '2026-07-03 16:07:20.240000', NULL, 'admin', '2026-07-03 16:07:20.240000', 1, 18, '', '不适用');
INSERT INTO `as_answer_history` VALUES (2, 'admin', '2026-07-03 16:07:26.559000', NULL, 'admin', '2026-07-03 16:07:26.559000', 1, 18, '不适用', '未落实');
INSERT INTO `as_answer_history` VALUES (3, 'admin', '2026-07-03 16:09:53.931000', NULL, 'admin', '2026-07-03 16:09:53.931000', 1, 2, '', '部分落实');
INSERT INTO `as_answer_history` VALUES (4, 'admin', '2026-07-03 16:09:54.664000', NULL, 'admin', '2026-07-03 16:09:54.664000', 1, 3, '', '部分落实');
INSERT INTO `as_answer_history` VALUES (5, 'admin', '2026-07-03 16:09:56.056000', NULL, 'admin', '2026-07-03 16:09:56.056000', 1, 4, '', '未落实');
INSERT INTO `as_answer_history` VALUES (6, 'admin', '2026-07-03 16:09:57.316000', NULL, 'admin', '2026-07-03 16:09:57.316000', 1, 5, '', '未落实');
INSERT INTO `as_answer_history` VALUES (7, 'admin', '2026-07-03 16:10:00.343000', NULL, 'admin', '2026-07-03 16:10:00.343000', 1, 6, '', '未落实');
INSERT INTO `as_answer_history` VALUES (8, 'admin', '2026-07-03 16:10:00.905000', NULL, 'admin', '2026-07-03 16:10:00.905000', 1, 7, '', '未落实');
INSERT INTO `as_answer_history` VALUES (9, 'admin', '2026-07-03 16:10:01.859000', NULL, 'admin', '2026-07-03 16:10:01.859000', 1, 8, '', '[\"书面签署\"]');
INSERT INTO `as_answer_history` VALUES (10, 'admin', '2026-07-03 16:10:03.985000', NULL, 'admin', '2026-07-03 16:10:03.985000', 1, 9, '', '官方网站公示');
INSERT INTO `as_answer_history` VALUES (11, 'admin', '2026-07-03 16:10:05.340000', NULL, 'admin', '2026-07-03 16:10:05.340000', 1, 10, '', 'N');
INSERT INTO `as_answer_history` VALUES (12, 'admin', '2026-07-03 16:10:07.607000', NULL, 'admin', '2026-07-03 16:10:07.607000', 1, 11, '', '已落实');
INSERT INTO `as_answer_history` VALUES (13, 'admin', '2026-07-03 16:10:09.321000', NULL, 'admin', '2026-07-03 16:10:09.321000', 1, 12, '', '部分落实');
INSERT INTO `as_answer_history` VALUES (14, 'admin', '2026-07-03 16:10:10.638000', NULL, 'admin', '2026-07-03 16:10:10.638000', 1, 13, '', '[\"宗教信仰\"]');
INSERT INTO `as_answer_history` VALUES (15, 'admin', '2026-07-03 16:10:14.159000', NULL, 'admin', '2026-07-03 16:10:14.159000', 1, 14, '', '无');
INSERT INTO `as_answer_history` VALUES (16, 'admin', '2026-07-03 16:10:17.453000', NULL, 'admin', '2026-07-03 16:10:17.453000', 1, 15, '', '未落实');
INSERT INTO `as_answer_history` VALUES (17, 'admin', '2026-07-03 16:10:18.101000', NULL, 'admin', '2026-07-03 16:10:18.101000', 1, 16, '', '未落实');
INSERT INTO `as_answer_history` VALUES (18, 'admin', '2026-07-03 16:10:18.869000', NULL, 'admin', '2026-07-03 16:10:18.869000', 1, 17, '', '未落实');
INSERT INTO `as_answer_history` VALUES (19, 'admin', '2026-07-03 16:10:22.198000', NULL, 'admin', '2026-07-03 16:10:22.198000', 1, 19, '', '111');
INSERT INTO `as_answer_history` VALUES (20, 'admin', '2026-07-03 16:10:23.988000', NULL, 'admin', '2026-07-03 16:10:23.988000', 1, 20, '', '[\"访问权限控制\"]');
INSERT INTO `as_answer_history` VALUES (21, 'admin', '2026-07-03 16:10:25.242000', NULL, 'admin', '2026-07-03 16:10:25.242000', 1, 21, '', '未落实');
INSERT INTO `as_answer_history` VALUES (22, 'admin', '2026-07-03 16:10:26.711000', NULL, 'admin', '2026-07-03 16:10:26.711000', 1, 22, '', '未落实');
INSERT INTO `as_answer_history` VALUES (23, 'admin', '2026-07-06 11:15:15.354000', NULL, 'admin', '2026-07-06 11:15:15.354000', 1, 2, '部分落实', '未落实');
INSERT INTO `as_answer_history` VALUES (24, 'xiaoming', '2026-07-06 14:44:58.915000', NULL, 'xiaoming', '2026-07-06 14:44:58.915000', 2, 2, '', '部分落实');
INSERT INTO `as_answer_history` VALUES (25, 'xiaoming', '2026-07-06 14:44:59.941000', NULL, 'xiaoming', '2026-07-06 14:44:59.941000', 2, 3, '', '部分落实');
INSERT INTO `as_answer_history` VALUES (26, 'xiaoming', '2026-07-06 14:45:02.121000', NULL, 'xiaoming', '2026-07-06 14:45:02.121000', 2, 4, '', '未落实');
INSERT INTO `as_answer_history` VALUES (27, 'xiaoming', '2026-07-06 14:45:02.631000', NULL, 'xiaoming', '2026-07-06 14:45:02.631000', 2, 5, '', '未落实');
INSERT INTO `as_answer_history` VALUES (28, 'xiaoming', '2026-07-06 14:45:05.199000', NULL, 'xiaoming', '2026-07-06 14:45:05.199000', 2, 6, '', '未落实');
INSERT INTO `as_answer_history` VALUES (29, 'xiaoming', '2026-07-06 14:45:06.331000', NULL, 'xiaoming', '2026-07-06 14:45:06.331000', 2, 7, '', '未落实');
INSERT INTO `as_answer_history` VALUES (30, 'xiaoming', '2026-07-06 14:45:06.820000', NULL, 'xiaoming', '2026-07-06 14:45:06.820000', 2, 8, '', '[\"书面签署\"]');
INSERT INTO `as_answer_history` VALUES (31, 'xiaoming', '2026-07-06 14:45:08.793000', NULL, 'xiaoming', '2026-07-06 14:45:08.793000', 2, 9, '', '纸质告知');
INSERT INTO `as_answer_history` VALUES (32, 'xiaoming', '2026-07-06 14:45:10.670000', NULL, 'xiaoming', '2026-07-06 14:45:10.670000', 2, 10, '', 'N');
INSERT INTO `as_answer_history` VALUES (33, 'xiaoming', '2026-07-06 14:45:13.396000', NULL, 'xiaoming', '2026-07-06 14:45:13.396000', 2, 11, '', '未落实');
INSERT INTO `as_answer_history` VALUES (34, 'xiaoming', '2026-07-06 14:45:14.089000', NULL, 'xiaoming', '2026-07-06 14:45:14.089000', 2, 12, '', '未落实');
INSERT INTO `as_answer_history` VALUES (35, 'xiaoming', '2026-07-06 14:45:15.178000', NULL, 'xiaoming', '2026-07-06 14:45:15.178000', 2, 13, '', '[\"宗教信仰\"]');
INSERT INTO `as_answer_history` VALUES (36, 'xiaoming', '2026-07-06 14:45:15.994000', NULL, 'xiaoming', '2026-07-06 14:45:15.994000', 2, 14, '', '12');
INSERT INTO `as_answer_history` VALUES (37, 'xiaoming', '2026-07-06 14:45:20.611000', NULL, 'xiaoming', '2026-07-06 14:45:20.611000', 2, 15, '', '不适用');
INSERT INTO `as_answer_history` VALUES (38, 'xiaoming', '2026-07-06 14:45:21.532000', NULL, 'xiaoming', '2026-07-06 14:45:21.532000', 2, 16, '', '不适用');
INSERT INTO `as_answer_history` VALUES (39, 'xiaoming', '2026-07-06 14:45:22.106000', NULL, 'xiaoming', '2026-07-06 14:45:22.106000', 2, 17, '', '不适用');
INSERT INTO `as_answer_history` VALUES (40, 'xiaoming', '2026-07-06 14:45:23.549000', NULL, 'xiaoming', '2026-07-06 14:45:23.549000', 2, 18, '', '不适用');
INSERT INTO `as_answer_history` VALUES (41, 'xiaoming', '2026-07-06 14:45:27.087000', NULL, 'xiaoming', '2026-07-06 14:45:27.087000', 2, 19, '', '11');
INSERT INTO `as_answer_history` VALUES (42, 'xiaoming', '2026-07-06 14:45:28.756000', NULL, 'xiaoming', '2026-07-06 14:45:28.756000', 2, 20, '', '[\"员工培训\"]');
INSERT INTO `as_answer_history` VALUES (43, 'xiaoming', '2026-07-06 14:45:29.913000', NULL, 'xiaoming', '2026-07-06 14:45:29.913000', 2, 21, '', '不适用');
INSERT INTO `as_answer_history` VALUES (44, 'xiaoming', '2026-07-06 14:45:30.549000', NULL, 'xiaoming', '2026-07-06 14:45:30.549000', 2, 22, '', '不适用');
INSERT INTO `as_answer_history` VALUES (45, 'xiaoming', '2026-07-06 14:45:32.665000', NULL, 'xiaoming', '2026-07-06 14:45:32.665000', 2, 23, '', '2026-07-24');

-- ----------------------------
-- Table structure for as_comment
-- ----------------------------
DROP TABLE IF EXISTS `as_comment`;
CREATE TABLE `as_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `survey_id` bigint NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_as_comment_survey_question`(`survey_id` ASC, `question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_comment
-- ----------------------------

-- ----------------------------
-- Table structure for as_request
-- ----------------------------
DROP TABLE IF EXISTS `as_request`;
CREATE TABLE `as_request`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `survey_id` bigint NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sender_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sender_user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_as_request_survey_question`(`survey_id` ASC, `question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_request
-- ----------------------------
INSERT INTO `as_request` VALUES (1, 'admin', '2026-07-06 11:14:49.230000', NULL, 'admin', '2026-07-06 11:14:49.230000', 1, 2, '请补充附件', 'RESPONDENT', 1);

-- ----------------------------
-- Table structure for as_risk_process
-- ----------------------------
DROP TABLE IF EXISTS `as_risk_process`;
CREATE TABLE `as_risk_process`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `risk_record_id` bigint NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `review_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `review_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `review_time` datetime(6) NULL DEFAULT NULL,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_risk_process_record`(`risk_record_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_risk_process
-- ----------------------------

-- ----------------------------
-- Table structure for as_risk_record
-- ----------------------------
DROP TABLE IF EXISTS `as_risk_record`;
CREATE TABLE `as_risk_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `survey_id` bigint NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `risk_desc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `handle_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `process_status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'UNPROCESSED',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_survey`(`survey_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_risk_record
-- ----------------------------
INSERT INTO `as_risk_record` VALUES (1, 'admin', '2026-07-06 14:47:33.457000', NULL, 'admin', '2026-07-06 14:47:33.457000', 2, 2, '必须整改措施', 'HIGH', 'PENDING', 'UNPROCESSED');

-- ----------------------------
-- Table structure for as_survey
-- ----------------------------
DROP TABLE IF EXISTS `as_survey`;
CREATE TABLE `as_survey`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `template_id` bigint NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `respondent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `respondent_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `fill_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `assessor_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `due_date` datetime(6) NULL DEFAULT NULL,
  `chapter_scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `distribute_time` datetime(6) NULL DEFAULT NULL,
  `submit_time` datetime(6) NULL DEFAULT NULL,
  `oper_user_id` bigint NULL DEFAULT NULL,
  `respondent_user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_token`(`fill_token` ASC) USING BTREE,
  INDEX `idx_template_status`(`template_id` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of as_survey
-- ----------------------------
INSERT INTO `as_survey` VALUES (1, 'admin', '2026-07-03 16:04:54.822000', NULL, 'admin', '2026-07-03 16:04:54.822000', 1, '个人信息保护法合规自评问卷', '超级管理员', 'admin@rutong.com', NULL, 'APPROVED', '1', NULL, NULL, '2026-07-03 16:04:54.821000', '2026-07-06 11:15:16.371000', 1, 1);
INSERT INTO `as_survey` VALUES (2, 'admin', '2026-07-06 13:23:15.325000', NULL, 'admin', '2026-07-06 13:23:15.325000', 1, '个人信息保护法合规自评问卷', '小明', '1122@qq.com', NULL, 'REVIEWING', '1', '2026-07-31 00:00:00.000000', NULL, '2026-07-06 13:23:15.320000', '2026-07-06 14:45:37.554000', 1, 3);

-- ----------------------------
-- Table structure for qm_chapter
-- ----------------------------
DROP TABLE IF EXISTS `qm_chapter`;
CREATE TABLE `qm_chapter`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `template_id` bigint NULL DEFAULT NULL,
  `chapter_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  `visible` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template`(`template_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_chapter
-- ----------------------------
INSERT INTO `qm_chapter` VALUES (1, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, '一、基本原则与处理依据', 1, 'Y');
INSERT INTO `qm_chapter` VALUES (2, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, '二、告知与同意', 2, 'Y');
INSERT INTO `qm_chapter` VALUES (3, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, '三、敏感个人信息处理', 3, 'Y');
INSERT INTO `qm_chapter` VALUES (4, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, '四、个人信息主体权利', 4, 'Y');
INSERT INTO `qm_chapter` VALUES (5, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, '五、处理者义务与安全保护', 5, 'Y');
INSERT INTO `qm_chapter` VALUES (6, 'admin', '2026-07-06 14:49:36.317000', NULL, 'admin', '2026-07-06 14:49:36.317000', 2, '一、基本原则与处理依据', 1, 'Y');
INSERT INTO `qm_chapter` VALUES (7, 'admin', '2026-07-06 14:49:36.318000', NULL, 'admin', '2026-07-06 14:49:36.318000', 2, '二、告知与同意', 2, 'Y');
INSERT INTO `qm_chapter` VALUES (8, 'admin', '2026-07-06 14:49:36.319000', NULL, 'admin', '2026-07-06 14:49:36.319000', 2, '三、敏感个人信息处理', 3, 'Y');
INSERT INTO `qm_chapter` VALUES (9, 'admin', '2026-07-06 14:49:36.320000', NULL, 'admin', '2026-07-06 14:49:36.320000', 2, '四、个人信息主体权利', 4, 'Y');
INSERT INTO `qm_chapter` VALUES (10, 'admin', '2026-07-06 14:49:36.321000', NULL, 'admin', '2026-07-06 14:49:36.321000', 2, '五、处理者义务与安全保护', 5, 'Y');

-- ----------------------------
-- Table structure for qm_personal_question
-- ----------------------------
DROP TABLE IF EXISTS `qm_personal_question`;
CREATE TABLE `qm_personal_question`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `question_snapshot` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_personal_question
-- ----------------------------

-- ----------------------------
-- Table structure for qm_question
-- ----------------------------
DROP TABLE IF EXISTS `qm_question`;
CREATE TABLE `qm_question`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `template_id` bigint NULL DEFAULT NULL,
  `chapter_id` bigint NULL DEFAULT NULL,
  `question_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `required` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  `min_len` int NULL DEFAULT NULL,
  `max_len` int NULL DEFAULT NULL,
  `regex` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `max_count` int NULL DEFAULT NULL,
  `max_size` bigint NULL DEFAULT NULL,
  `accept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template_chapter`(`template_id` ASC, `chapter_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_question
-- ----------------------------
INSERT INTO `qm_question` VALUES (1, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 1, 'DESCRIPTION', '本问卷依据《中华人民共和国个人信息保护法》编制，用于自查个人信息处理合规情况。<br/>选项中：<b>已落实 / 部分落实 / 未落实</b> 对应贵单位当前落实程度，<b>不适用</b> 用于与业务无关的条款。请据实作答。', 'N', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (2, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 1, 'RADIO', '处理个人信息是否具备合法事由（同意、订立或履行合同所必需、履行法定职责或义务等），并遵循合法、正当、必要、诚信原则？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (3, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 1, 'RADIO', '收集个人信息是否遵循“最小必要”原则，未超出处理目的所必需的范围与频次？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (4, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 1, 'RADIO', '是否已建立个人信息分类分级机制，准确识别并区分敏感个人信息？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (5, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 1, 'RADIO', '是否明确各项个人信息处理活动的目的，并确保处理方式与该目的直接相关？', 'Y', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (6, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 2, 'RADIO', '收集个人信息前，是否以显著方式、清晰易懂的语言向个人告知处理者身份、目的、方式、种类、保存期限及行使权利的方式？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (7, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 2, 'RADIO', '取得个人同意时，是否确保其在充分知情前提下自愿、明确作出，未以误导、欺诈、胁迫等方式获取？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (8, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 2, 'CHECKBOX', '获取个人同意时，主要采取了以下哪些方式？（多选）', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (9, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 2, 'SELECT', '贵单位的个人信息处理规则（隐私政策）主要通过哪种渠道向个人公示？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (10, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 2, 'BOOLEAN', '是否为个人提供了便捷的撤回同意方式，且撤回不影响此前基于同意的处理？', 'Y', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (11, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 3, 'RADIO', '处理敏感个人信息（生物识别、宗教信仰、特定身份、医疗健康、金融账户、行踪轨迹，以及不满14周岁未成年人信息等）是否取得了单独同意？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (12, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 3, 'RADIO', '处理敏感个人信息是否具有特定的目的和充分的必要性，并在严格保护措施下进行？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (13, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 3, 'CHECKBOX', '贵单位处理哪些类型的敏感个人信息？（多选）', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (14, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 3, 'TEXT', '如存在个人信息出境，请填写目的地国家或地区（无出境请填“无”）。', 'Y', 4, NULL, NULL, NULL, '例如：美国、新加坡、中国香港；无则填“无”', NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (15, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 1, 4, 'RADIO', '是否建立了便捷的渠道，供个人查询、复制其个人信息？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (16, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 4, 'RADIO', '个人信息存在错误或不完整时，是否支持个人提出更正、补充请求并及时处理？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (17, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 4, 'RADIO', '是否支持个人请求删除个人信息（处理目的已实现、约定期限届满、同意已撤回、违规处理等情形）？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (18, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 4, 'RADIO', '收到个人行使权利的请求后，是否在15个工作日内予以答复处理？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (19, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 4, 'TEXT', '个人信息保护负责人（DPO）的联系方式（电话或邮箱）。', 'Y', 5, NULL, NULL, NULL, '例如：0571-xxxxxxxx / privacy@company.com', NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (20, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 5, 'CHECKBOX', '贵单位已采取了以下哪些个人信息安全保护措施？（多选）', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (21, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 5, 'RADIO', '针对敏感信息处理、自动化决策、对外提供或公开、跨境提供等场景，是否开展了个人信息保护影响评估（PIA）并形成处理情况记录？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (22, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 5, 'RADIO', '是否建立个人信息安全事件应急预案，发生或可能发生泄露、篡改、丢失时按规定通知个人并报告监管部门？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (23, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 5, 'DATE', '贵单位个人信息保护制度（或隐私政策）最近一次修订日期。', 'N', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (24, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 1, 5, 'UPLOAD', '请上传个人信息保护制度文件或最新的个人信息保护影响评估（PIA）报告（可选）。', 'N', 5, NULL, NULL, NULL, NULL, 5, 10485760, '.pdf,.doc,.docx,.xls,.xlsx,.png,.jpg,.zip');
INSERT INTO `qm_question` VALUES (25, 'admin', '2026-07-06 14:49:36.352000', NULL, 'admin', '2026-07-06 14:49:36.352000', 2, 6, 'DESCRIPTION', '本问卷依据《中华人民共和国个人信息保护法》编制，用于自查个人信息处理合规情况。<br/>选项中：<b>已落实 / 部分落实 / 未落实</b> 对应贵单位当前落实程度，<b>不适用</b> 用于与业务无关的条款。请据实作答。', 'N', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (26, 'admin', '2026-07-06 14:49:36.357000', NULL, 'admin', '2026-07-06 14:49:36.357000', 2, 7, 'RADIO', '收集个人信息前，是否以显著方式、清晰易懂的语言向个人告知处理者身份、目的、方式、种类、保存期限及行使权利的方式？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (27, 'admin', '2026-07-06 14:49:36.374000', NULL, 'admin', '2026-07-06 14:49:36.374000', 2, 8, 'RADIO', '处理敏感个人信息（生物识别、宗教信仰、特定身份、医疗健康、金融账户、行踪轨迹，以及不满14周岁未成年人信息等）是否取得了单独同意？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (28, 'admin', '2026-07-06 14:49:36.381000', NULL, 'admin', '2026-07-06 14:49:36.381000', 2, 9, 'RADIO', '是否建立了便捷的渠道，供个人查询、复制其个人信息？', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (29, 'admin', '2026-07-06 14:49:36.388000', NULL, 'admin', '2026-07-06 14:49:36.388000', 2, 10, 'CHECKBOX', '贵单位已采取了以下哪些个人信息安全保护措施？（多选）', 'Y', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (30, 'admin', '2026-07-06 14:49:36.395000', NULL, 'admin', '2026-07-06 14:49:36.395000', 2, 6, 'RADIO', '处理个人信息是否具备合法事由（同意、订立或履行合同所必需、履行法定职责或义务等），并遵循合法、正当、必要、诚信原则？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (31, 'admin', '2026-07-06 14:49:36.402000', NULL, 'admin', '2026-07-06 14:49:36.402000', 2, 7, 'RADIO', '取得个人同意时，是否确保其在充分知情前提下自愿、明确作出，未以误导、欺诈、胁迫等方式获取？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (32, 'admin', '2026-07-06 14:49:36.410000', NULL, 'admin', '2026-07-06 14:49:36.410000', 2, 8, 'RADIO', '处理敏感个人信息是否具有特定的目的和充分的必要性，并在严格保护措施下进行？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (33, 'admin', '2026-07-06 14:49:36.419000', NULL, 'admin', '2026-07-06 14:49:36.419000', 2, 9, 'RADIO', '个人信息存在错误或不完整时，是否支持个人提出更正、补充请求并及时处理？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (34, 'admin', '2026-07-06 14:49:36.426000', NULL, 'admin', '2026-07-06 14:49:36.426000', 2, 10, 'RADIO', '针对敏感信息处理、自动化决策、对外提供或公开、跨境提供等场景，是否开展了个人信息保护影响评估（PIA）并形成处理情况记录？', 'Y', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (35, 'admin', '2026-07-06 14:49:36.433000', NULL, 'admin', '2026-07-06 14:49:36.433000', 2, 6, 'RADIO', '收集个人信息是否遵循“最小必要”原则，未超出处理目的所必需的范围与频次？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (36, 'admin', '2026-07-06 14:49:36.442000', NULL, 'admin', '2026-07-06 14:49:36.442000', 2, 7, 'CHECKBOX', '获取个人同意时，主要采取了以下哪些方式？（多选）', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (37, 'admin', '2026-07-06 14:49:36.448000', NULL, 'admin', '2026-07-06 14:49:36.448000', 2, 8, 'CHECKBOX', '贵单位处理哪些类型的敏感个人信息？（多选）', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (38, 'admin', '2026-07-06 14:49:36.459000', NULL, 'admin', '2026-07-06 14:49:36.459000', 2, 9, 'RADIO', '是否支持个人请求删除个人信息（处理目的已实现、约定期限届满、同意已撤回、违规处理等情形）？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (39, 'admin', '2026-07-06 14:49:36.466000', NULL, 'admin', '2026-07-06 14:49:36.466000', 2, 10, 'RADIO', '是否建立个人信息安全事件应急预案，发生或可能发生泄露、篡改、丢失时按规定通知个人并报告监管部门？', 'Y', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (40, 'admin', '2026-07-06 14:49:36.475000', NULL, 'admin', '2026-07-06 14:49:36.475000', 2, 6, 'RADIO', '是否已建立个人信息分类分级机制，准确识别并区分敏感个人信息？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (41, 'admin', '2026-07-06 14:49:36.489000', NULL, 'admin', '2026-07-06 14:49:36.489000', 2, 7, 'SELECT', '贵单位的个人信息处理规则（隐私政策）主要通过哪种渠道向个人公示？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (42, 'admin', '2026-07-06 14:49:36.500000', NULL, 'admin', '2026-07-06 14:49:36.500000', 2, 8, 'TEXT', '如存在个人信息出境，请填写目的地国家或地区（无出境请填“无”）。', 'Y', 4, NULL, NULL, NULL, '例如：美国、新加坡、中国香港；无则填“无”', NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (43, 'admin', '2026-07-06 14:49:36.503000', NULL, 'admin', '2026-07-06 14:49:36.503000', 2, 9, 'RADIO', '收到个人行使权利的请求后，是否在15个工作日内予以答复处理？', 'Y', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (44, 'admin', '2026-07-06 14:49:36.512000', NULL, 'admin', '2026-07-06 14:49:36.512000', 2, 10, 'DATE', '贵单位个人信息保护制度（或隐私政策）最近一次修订日期。', 'N', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (45, 'admin', '2026-07-06 14:49:36.516000', NULL, 'admin', '2026-07-06 14:49:36.516000', 2, 6, 'RADIO', '是否明确各项个人信息处理活动的目的，并确保处理方式与该目的直接相关？', 'Y', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (46, 'admin', '2026-07-06 14:49:36.523000', NULL, 'admin', '2026-07-06 14:49:36.523000', 2, 7, 'BOOLEAN', '是否为个人提供了便捷的撤回同意方式，且撤回不影响此前基于同意的处理？', 'Y', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (47, 'admin', '2026-07-06 14:49:36.528000', NULL, 'admin', '2026-07-06 14:49:36.528000', 2, 9, 'TEXT', '个人信息保护负责人（DPO）的联系方式（电话或邮箱）。', 'Y', 5, NULL, NULL, NULL, '例如：0571-xxxxxxxx / privacy@company.com', NULL, NULL, NULL);
INSERT INTO `qm_question` VALUES (48, 'admin', '2026-07-06 14:49:36.534000', NULL, 'admin', '2026-07-06 14:49:36.534000', 2, 10, 'UPLOAD', '请上传个人信息保护制度文件或最新的个人信息保护影响评估（PIA）报告（可选）。', 'N', 5, NULL, NULL, NULL, NULL, 5, 10485760, '.pdf,.doc,.docx,.xls,.xlsx,.png,.jpg,.zip');

-- ----------------------------
-- Table structure for qm_question_logic
-- ----------------------------
DROP TABLE IF EXISTS `qm_question_logic`;
CREATE TABLE `qm_question_logic`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `cond_question_id` bigint NULL DEFAULT NULL,
  `op` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cond_value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_question`(`question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_question_logic
-- ----------------------------

-- ----------------------------
-- Table structure for qm_question_option
-- ----------------------------
DROP TABLE IF EXISTS `qm_question_option`;
CREATE TABLE `qm_question_option`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `question_id` bigint NULL DEFAULT NULL,
  `opt_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `opt_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `opt_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_question`(`question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_question_option
-- ----------------------------
INSERT INTO `qm_question_option` VALUES (1, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 2, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (2, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 2, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (3, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 2, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (4, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 2, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (5, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 3, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (6, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 3, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (7, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 3, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (8, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 3, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (9, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 4, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (10, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 4, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (11, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 4, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (12, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 4, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (13, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 5, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (14, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 5, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (15, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 5, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (16, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 5, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (17, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 6, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (18, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 6, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (19, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 6, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (20, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 6, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (21, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 7, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (22, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 7, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (23, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 7, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (24, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 7, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (25, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 8, 'OPTION', '弹窗告知', '弹窗告知', 1);
INSERT INTO `qm_question_option` VALUES (26, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 8, 'OPTION', '独立同意页', '独立同意页', 2);
INSERT INTO `qm_question_option` VALUES (27, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 8, 'OPTION', '书面签署', '书面签署', 3);
INSERT INTO `qm_question_option` VALUES (28, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 8, 'OPTION', '短信或邮件确认', '短信或邮件确认', 4);
INSERT INTO `qm_question_option` VALUES (29, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 8, 'OPTION', '其他', '其他', 5);
INSERT INTO `qm_question_option` VALUES (30, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 9, 'OPTION', '官方网站公示', '官方网站公示', 1);
INSERT INTO `qm_question_option` VALUES (31, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 9, 'OPTION', 'App 或小程序内嵌', 'App 或小程序内嵌', 2);
INSERT INTO `qm_question_option` VALUES (32, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 9, 'OPTION', '首次使用时弹窗', '首次使用时弹窗', 3);
INSERT INTO `qm_question_option` VALUES (33, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 9, 'OPTION', '纸质告知', '纸质告知', 4);
INSERT INTO `qm_question_option` VALUES (34, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 9, 'OPTION', '尚未公示', '尚未公示', 5);
INSERT INTO `qm_question_option` VALUES (35, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 11, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (36, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 11, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (37, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 11, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (38, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 11, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (39, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 12, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (40, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 12, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (41, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 12, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (42, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 12, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (43, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '生物识别信息', '生物识别信息', 1);
INSERT INTO `qm_question_option` VALUES (44, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '宗教信仰', '宗教信仰', 2);
INSERT INTO `qm_question_option` VALUES (45, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '特定身份', '特定身份', 3);
INSERT INTO `qm_question_option` VALUES (46, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '医疗健康', '医疗健康', 4);
INSERT INTO `qm_question_option` VALUES (47, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '金融账户', '金融账户', 5);
INSERT INTO `qm_question_option` VALUES (48, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '行踪轨迹', '行踪轨迹', 6);
INSERT INTO `qm_question_option` VALUES (49, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 13, 'OPTION', '不满14周岁未成年人信息', '不满14周岁未成年人信息', 7);
INSERT INTO `qm_question_option` VALUES (50, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 15, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (51, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 15, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (52, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 15, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (53, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, 15, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (54, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 16, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (55, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 16, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (56, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 16, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (57, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 16, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (58, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 17, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (59, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 17, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (60, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 17, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (61, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 17, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (62, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 18, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (63, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 18, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (64, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 18, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (65, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 18, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (66, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '加密', '加密', 1);
INSERT INTO `qm_question_option` VALUES (67, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '去标识化', '去标识化', 2);
INSERT INTO `qm_question_option` VALUES (68, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '访问权限控制', '访问权限控制', 3);
INSERT INTO `qm_question_option` VALUES (69, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '安全审计', '安全审计', 4);
INSERT INTO `qm_question_option` VALUES (70, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '员工培训', '员工培训', 5);
INSERT INTO `qm_question_option` VALUES (71, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 20, 'OPTION', '应急演练', '应急演练', 6);
INSERT INTO `qm_question_option` VALUES (72, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 21, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (73, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 21, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (74, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 21, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (75, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 21, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (76, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 22, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (77, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 22, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (78, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 22, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (79, 'admin', '2026-07-03 16:03:21.000000', NULL, NULL, NULL, 22, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (80, 'admin', '2026-07-06 14:49:36.365000', NULL, 'admin', '2026-07-06 14:49:36.365000', 26, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (81, 'admin', '2026-07-06 14:49:36.366000', NULL, 'admin', '2026-07-06 14:49:36.366000', 26, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (82, 'admin', '2026-07-06 14:49:36.367000', NULL, 'admin', '2026-07-06 14:49:36.367000', 26, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (83, 'admin', '2026-07-06 14:49:36.367000', NULL, 'admin', '2026-07-06 14:49:36.367000', 26, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (84, 'admin', '2026-07-06 14:49:36.378000', NULL, 'admin', '2026-07-06 14:49:36.378000', 27, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (85, 'admin', '2026-07-06 14:49:36.378000', NULL, 'admin', '2026-07-06 14:49:36.378000', 27, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (86, 'admin', '2026-07-06 14:49:36.379000', NULL, 'admin', '2026-07-06 14:49:36.379000', 27, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (87, 'admin', '2026-07-06 14:49:36.379000', NULL, 'admin', '2026-07-06 14:49:36.379000', 27, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (88, 'admin', '2026-07-06 14:49:36.383000', NULL, 'admin', '2026-07-06 14:49:36.383000', 28, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (89, 'admin', '2026-07-06 14:49:36.384000', NULL, 'admin', '2026-07-06 14:49:36.384000', 28, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (90, 'admin', '2026-07-06 14:49:36.384000', NULL, 'admin', '2026-07-06 14:49:36.384000', 28, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (91, 'admin', '2026-07-06 14:49:36.384000', NULL, 'admin', '2026-07-06 14:49:36.384000', 28, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (92, 'admin', '2026-07-06 14:49:36.391000', NULL, 'admin', '2026-07-06 14:49:36.391000', 29, 'OPTION', '加密', '加密', 1);
INSERT INTO `qm_question_option` VALUES (93, 'admin', '2026-07-06 14:49:36.391000', NULL, 'admin', '2026-07-06 14:49:36.391000', 29, 'OPTION', '去标识化', '去标识化', 2);
INSERT INTO `qm_question_option` VALUES (94, 'admin', '2026-07-06 14:49:36.391000', NULL, 'admin', '2026-07-06 14:49:36.391000', 29, 'OPTION', '访问权限控制', '访问权限控制', 3);
INSERT INTO `qm_question_option` VALUES (95, 'admin', '2026-07-06 14:49:36.392000', NULL, 'admin', '2026-07-06 14:49:36.392000', 29, 'OPTION', '安全审计', '安全审计', 4);
INSERT INTO `qm_question_option` VALUES (96, 'admin', '2026-07-06 14:49:36.392000', NULL, 'admin', '2026-07-06 14:49:36.392000', 29, 'OPTION', '员工培训', '员工培训', 5);
INSERT INTO `qm_question_option` VALUES (97, 'admin', '2026-07-06 14:49:36.393000', NULL, 'admin', '2026-07-06 14:49:36.393000', 29, 'OPTION', '应急演练', '应急演练', 6);
INSERT INTO `qm_question_option` VALUES (98, 'admin', '2026-07-06 14:49:36.399000', NULL, 'admin', '2026-07-06 14:49:36.399000', 30, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (99, 'admin', '2026-07-06 14:49:36.399000', NULL, 'admin', '2026-07-06 14:49:36.399000', 30, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (100, 'admin', '2026-07-06 14:49:36.399000', NULL, 'admin', '2026-07-06 14:49:36.399000', 30, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (101, 'admin', '2026-07-06 14:49:36.400000', NULL, 'admin', '2026-07-06 14:49:36.400000', 30, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (102, 'admin', '2026-07-06 14:49:36.407000', NULL, 'admin', '2026-07-06 14:49:36.407000', 31, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (103, 'admin', '2026-07-06 14:49:36.407000', NULL, 'admin', '2026-07-06 14:49:36.407000', 31, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (104, 'admin', '2026-07-06 14:49:36.407000', NULL, 'admin', '2026-07-06 14:49:36.407000', 31, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (105, 'admin', '2026-07-06 14:49:36.408000', NULL, 'admin', '2026-07-06 14:49:36.408000', 31, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (106, 'admin', '2026-07-06 14:49:36.415000', NULL, 'admin', '2026-07-06 14:49:36.415000', 32, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (107, 'admin', '2026-07-06 14:49:36.415000', NULL, 'admin', '2026-07-06 14:49:36.415000', 32, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (108, 'admin', '2026-07-06 14:49:36.415000', NULL, 'admin', '2026-07-06 14:49:36.415000', 32, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (109, 'admin', '2026-07-06 14:49:36.415000', NULL, 'admin', '2026-07-06 14:49:36.415000', 32, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (110, 'admin', '2026-07-06 14:49:36.424000', NULL, 'admin', '2026-07-06 14:49:36.424000', 33, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (111, 'admin', '2026-07-06 14:49:36.424000', NULL, 'admin', '2026-07-06 14:49:36.424000', 33, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (112, 'admin', '2026-07-06 14:49:36.424000', NULL, 'admin', '2026-07-06 14:49:36.424000', 33, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (113, 'admin', '2026-07-06 14:49:36.424000', NULL, 'admin', '2026-07-06 14:49:36.424000', 33, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (114, 'admin', '2026-07-06 14:49:36.430000', NULL, 'admin', '2026-07-06 14:49:36.430000', 34, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (115, 'admin', '2026-07-06 14:49:36.430000', NULL, 'admin', '2026-07-06 14:49:36.430000', 34, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (116, 'admin', '2026-07-06 14:49:36.431000', NULL, 'admin', '2026-07-06 14:49:36.431000', 34, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (117, 'admin', '2026-07-06 14:49:36.431000', NULL, 'admin', '2026-07-06 14:49:36.431000', 34, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (118, 'admin', '2026-07-06 14:49:36.436000', NULL, 'admin', '2026-07-06 14:49:36.436000', 35, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (119, 'admin', '2026-07-06 14:49:36.437000', NULL, 'admin', '2026-07-06 14:49:36.437000', 35, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (120, 'admin', '2026-07-06 14:49:36.437000', NULL, 'admin', '2026-07-06 14:49:36.437000', 35, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (121, 'admin', '2026-07-06 14:49:36.437000', NULL, 'admin', '2026-07-06 14:49:36.437000', 35, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (122, 'admin', '2026-07-06 14:49:36.445000', NULL, 'admin', '2026-07-06 14:49:36.445000', 36, 'OPTION', '弹窗告知', '弹窗告知', 1);
INSERT INTO `qm_question_option` VALUES (123, 'admin', '2026-07-06 14:49:36.445000', NULL, 'admin', '2026-07-06 14:49:36.445000', 36, 'OPTION', '独立同意页', '独立同意页', 2);
INSERT INTO `qm_question_option` VALUES (124, 'admin', '2026-07-06 14:49:36.445000', NULL, 'admin', '2026-07-06 14:49:36.445000', 36, 'OPTION', '书面签署', '书面签署', 3);
INSERT INTO `qm_question_option` VALUES (125, 'admin', '2026-07-06 14:49:36.446000', NULL, 'admin', '2026-07-06 14:49:36.446000', 36, 'OPTION', '短信或邮件确认', '短信或邮件确认', 4);
INSERT INTO `qm_question_option` VALUES (126, 'admin', '2026-07-06 14:49:36.446000', NULL, 'admin', '2026-07-06 14:49:36.446000', 36, 'OPTION', '其他', '其他', 5);
INSERT INTO `qm_question_option` VALUES (127, 'admin', '2026-07-06 14:49:36.452000', NULL, 'admin', '2026-07-06 14:49:36.452000', 37, 'OPTION', '生物识别信息', '生物识别信息', 1);
INSERT INTO `qm_question_option` VALUES (128, 'admin', '2026-07-06 14:49:36.453000', NULL, 'admin', '2026-07-06 14:49:36.453000', 37, 'OPTION', '宗教信仰', '宗教信仰', 2);
INSERT INTO `qm_question_option` VALUES (129, 'admin', '2026-07-06 14:49:36.453000', NULL, 'admin', '2026-07-06 14:49:36.453000', 37, 'OPTION', '特定身份', '特定身份', 3);
INSERT INTO `qm_question_option` VALUES (130, 'admin', '2026-07-06 14:49:36.453000', NULL, 'admin', '2026-07-06 14:49:36.453000', 37, 'OPTION', '医疗健康', '医疗健康', 4);
INSERT INTO `qm_question_option` VALUES (131, 'admin', '2026-07-06 14:49:36.453000', NULL, 'admin', '2026-07-06 14:49:36.453000', 37, 'OPTION', '金融账户', '金融账户', 5);
INSERT INTO `qm_question_option` VALUES (132, 'admin', '2026-07-06 14:49:36.453000', NULL, 'admin', '2026-07-06 14:49:36.453000', 37, 'OPTION', '行踪轨迹', '行踪轨迹', 6);
INSERT INTO `qm_question_option` VALUES (133, 'admin', '2026-07-06 14:49:36.454000', NULL, 'admin', '2026-07-06 14:49:36.454000', 37, 'OPTION', '不满14周岁未成年人信息', '不满14周岁未成年人信息', 7);
INSERT INTO `qm_question_option` VALUES (134, 'admin', '2026-07-06 14:49:36.463000', NULL, 'admin', '2026-07-06 14:49:36.463000', 38, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (135, 'admin', '2026-07-06 14:49:36.463000', NULL, 'admin', '2026-07-06 14:49:36.463000', 38, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (136, 'admin', '2026-07-06 14:49:36.463000', NULL, 'admin', '2026-07-06 14:49:36.463000', 38, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (137, 'admin', '2026-07-06 14:49:36.464000', NULL, 'admin', '2026-07-06 14:49:36.464000', 38, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (138, 'admin', '2026-07-06 14:49:36.470000', NULL, 'admin', '2026-07-06 14:49:36.470000', 39, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (139, 'admin', '2026-07-06 14:49:36.470000', NULL, 'admin', '2026-07-06 14:49:36.470000', 39, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (140, 'admin', '2026-07-06 14:49:36.471000', NULL, 'admin', '2026-07-06 14:49:36.471000', 39, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (141, 'admin', '2026-07-06 14:49:36.471000', NULL, 'admin', '2026-07-06 14:49:36.471000', 39, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (142, 'admin', '2026-07-06 14:49:36.484000', NULL, 'admin', '2026-07-06 14:49:36.484000', 40, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (143, 'admin', '2026-07-06 14:49:36.484000', NULL, 'admin', '2026-07-06 14:49:36.484000', 40, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (144, 'admin', '2026-07-06 14:49:36.484000', NULL, 'admin', '2026-07-06 14:49:36.484000', 40, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (145, 'admin', '2026-07-06 14:49:36.484000', NULL, 'admin', '2026-07-06 14:49:36.484000', 40, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (146, 'admin', '2026-07-06 14:49:36.495000', NULL, 'admin', '2026-07-06 14:49:36.495000', 41, 'OPTION', '官方网站公示', '官方网站公示', 1);
INSERT INTO `qm_question_option` VALUES (147, 'admin', '2026-07-06 14:49:36.496000', NULL, 'admin', '2026-07-06 14:49:36.496000', 41, 'OPTION', 'App 或小程序内嵌', 'App 或小程序内嵌', 2);
INSERT INTO `qm_question_option` VALUES (148, 'admin', '2026-07-06 14:49:36.496000', NULL, 'admin', '2026-07-06 14:49:36.496000', 41, 'OPTION', '首次使用时弹窗', '首次使用时弹窗', 3);
INSERT INTO `qm_question_option` VALUES (149, 'admin', '2026-07-06 14:49:36.496000', NULL, 'admin', '2026-07-06 14:49:36.496000', 41, 'OPTION', '纸质告知', '纸质告知', 4);
INSERT INTO `qm_question_option` VALUES (150, 'admin', '2026-07-06 14:49:36.496000', NULL, 'admin', '2026-07-06 14:49:36.496000', 41, 'OPTION', '尚未公示', '尚未公示', 5);
INSERT INTO `qm_question_option` VALUES (151, 'admin', '2026-07-06 14:49:36.507000', NULL, 'admin', '2026-07-06 14:49:36.507000', 43, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (152, 'admin', '2026-07-06 14:49:36.507000', NULL, 'admin', '2026-07-06 14:49:36.507000', 43, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (153, 'admin', '2026-07-06 14:49:36.508000', NULL, 'admin', '2026-07-06 14:49:36.508000', 43, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (154, 'admin', '2026-07-06 14:49:36.508000', NULL, 'admin', '2026-07-06 14:49:36.508000', 43, 'OPTION', '不适用', '不适用', 4);
INSERT INTO `qm_question_option` VALUES (155, 'admin', '2026-07-06 14:49:36.519000', NULL, 'admin', '2026-07-06 14:49:36.519000', 45, 'OPTION', '已落实', '已落实', 1);
INSERT INTO `qm_question_option` VALUES (156, 'admin', '2026-07-06 14:49:36.519000', NULL, 'admin', '2026-07-06 14:49:36.519000', 45, 'OPTION', '部分落实', '部分落实', 2);
INSERT INTO `qm_question_option` VALUES (157, 'admin', '2026-07-06 14:49:36.519000', NULL, 'admin', '2026-07-06 14:49:36.519000', 45, 'OPTION', '未落实', '未落实', 3);
INSERT INTO `qm_question_option` VALUES (158, 'admin', '2026-07-06 14:49:36.519000', NULL, 'admin', '2026-07-06 14:49:36.519000', 45, 'OPTION', '不适用', '不适用', 4);

-- ----------------------------
-- Table structure for qm_risk_lib
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_lib`;
CREATE TABLE `qm_risk_lib`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `risk_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `risk_desc` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `threat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `vulnerability` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `treatment_plan` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `inherent_impact` int NULL DEFAULT NULL,
  `inherent_probability` int NULL DEFAULT NULL,
  `inherent_score` int NULL DEFAULT NULL,
  `target_impact` int NULL DEFAULT NULL,
  `target_probability` int NULL DEFAULT NULL,
  `target_score` int NULL DEFAULT NULL,
  `residual_impact` int NULL DEFAULT NULL,
  `residual_probability` int NULL DEFAULT NULL,
  `residual_score` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_risk_lib
-- ----------------------------
INSERT INTO `qm_risk_lib` VALUES (1, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, '未建立数据分类分级制度', 'HIGH', '尚未对数据进行分类分级，敏感数据存在暴露风险', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_risk_lib` VALUES (2, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, '缺少个人数据获取同意', 'MID', '采集个人数据时未获取有效同意', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qm_risk_lib` VALUES (3, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, '未做数据加密传输', 'HIGH', '敏感数据明文传输，存在窃听风险', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for qm_risk_rule
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_rule`;
CREATE TABLE `qm_risk_rule`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `template_id` bigint NULL DEFAULT NULL,
  `rule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `risk_lib_id` bigint NULL DEFAULT NULL,
  `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template`(`template_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_risk_rule
-- ----------------------------

-- ----------------------------
-- Table structure for qm_risk_rule_cond
-- ----------------------------
DROP TABLE IF EXISTS `qm_risk_rule_cond`;
CREATE TABLE `qm_risk_rule_cond`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `rule_id` bigint NULL DEFAULT NULL,
  `cond_question_id` bigint NULL DEFAULT NULL,
  `op` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cond_value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_rule`(`rule_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_risk_rule_cond
-- ----------------------------

-- ----------------------------
-- Table structure for qm_template
-- ----------------------------
DROP TABLE IF EXISTS `qm_template`;
CREATE TABLE `qm_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `source_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `style_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_template
-- ----------------------------
INSERT INTO `qm_template` VALUES (1, 'admin', '2026-07-03 16:03:20.000000', NULL, NULL, NULL, '个人信息保护法合规自评问卷', '数据合规', 'TEMPLATE', 'PUBLISHED', NULL, '依据《中华人民共和国个人信息保护法》编制的自评问卷，覆盖基本原则、告知同意、敏感信息、主体权利、处理者义务五大领域；展示问卷全部题型组件。');
INSERT INTO `qm_template` VALUES (2, 'admin', '2026-07-06 14:49:36.312000', NULL, 'admin', '2026-07-06 14:49:36.312000', '个人信息保护法合规自评问卷_副本', '数据合规', 'COPY', 'DRAFT', NULL, '依据《中华人民共和国个人信息保护法》编制的自评问卷，覆盖基本原则、告知同意、敏感信息、主体权利、处理者义务五大领域；展示问卷全部题型组件。');

-- ----------------------------
-- Table structure for qm_template_library
-- ----------------------------
DROP TABLE IF EXISTS `qm_template_library`;
CREATE TABLE `qm_template_library`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `snapshot` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qm_template_library
-- ----------------------------
INSERT INTO `qm_template_library` VALUES (1, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, '通用', '数据合规基础自评问卷', '{\"chapters\":[{\"chapterName\":\"一、数据采集\",\"orderNum\":1,\"visible\":\"Y\",\"questions\":[\n  {\"questionType\":\"RADIO\",\"title\":\"是否建立了数据分类分级制度？\",\"optionsConfig\":\"{\"options\":[\"是\",\"否\",\"制定中\"]}\",\"required\":\"Y\",\"orderNum\":1},\n  {\"questionType\":\"CHECKBOX\",\"title\":\"采集个人数据时获取同意的方式（多选）？\",\"optionsConfig\":\"{\"options\":[\"弹窗告知\",\"隐私政策\",\"签字同意\",\"其他\"]}\",\"required\":\"Y\",\"orderNum\":2},\n  {\"questionType\":\"TEXTAREA\",\"title\":\"请简要说明数据采集范围与目的\",\"required\":\"N\",\"orderNum\":3}\n]}]}');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `config_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `config_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `config_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `config_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '蓝色 skin-blue、绿色 skin-green', NULL, NULL, 'sys.index.skinName', '主框架页-默认皮肤样式名称', 'Y', 'skin-blue');
INSERT INTO `sys_config` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '初始化密码 123456', NULL, NULL, 'sys.user.initPassword', '用户管理-账号初始密码', 'Y', '123456');
INSERT INTO `sys_config` VALUES (3, 'admin', '2026-06-08 14:05:03.000000', '深色主题theme-dark，浅色主题theme-light', NULL, NULL, 'sys.index.sideTheme', '主框架页-侧边栏主题', 'Y', 'theme-dark');
INSERT INTO `sys_config` VALUES (4, 'admin', '2026-06-08 14:05:03.000000', '是否开启注册用户功能（true开启，false关闭）', 'admin', '2026-06-09 11:39:02.307000', 'sys.account.registerUser', '账号自助-是否开启用户注册功能', 'Y', 'false');
INSERT INTO `sys_config` VALUES (5, 'admin', '2026-06-08 14:05:03.000000', '是否开启验证码功能（true开启，false关闭）', NULL, NULL, 'sys.account.captchaEnabled', '账号自助-验证码开关', 'Y', 'true');
INSERT INTO `sys_config` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '设置登录IP黑名单限制，多个匹配项以;分隔', NULL, NULL, 'sys.login.blackIPList', '用户登录-黑名单列表', 'Y', '');
INSERT INTO `sys_config` VALUES (7, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.enabled', '邮件-是否启用', 'Y', 'false');
INSERT INTO `sys_config` VALUES (8, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.host', '邮件-SMTP主机', 'Y', '');
INSERT INTO `sys_config` VALUES (9, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.port', '邮件-SMTP端口', 'Y', '465');
INSERT INTO `sys_config` VALUES (10, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.username', '邮件-账号', 'Y', '');
INSERT INTO `sys_config` VALUES (11, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.password', '邮件-密码/授权码', 'Y', '');
INSERT INTO `sys_config` VALUES (12, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.ssl', '邮件-是否SSL', 'Y', 'true');
INSERT INTO `sys_config` VALUES (13, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.from', '邮件-发件人', 'Y', '');
INSERT INTO `sys_config` VALUES (14, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.fromName', '邮件-发件人名称', 'Y', '数据合规管理后台');
INSERT INTO `sys_config` VALUES (15, 'admin', '2026-07-03 14:55:54.000000', NULL, NULL, NULL, 'mail.frontUrl', '邮件-前端地址', 'Y', 'http://localhost:3000');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL,
  `ancestors` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKd5ou5hch26i1tk6m8jc4fpirw`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '儒通物联网', 'admin', '2026-06-09 11:04:42.000000', '儒通物联网', 0, 0, '0');
INSERT INTO `sys_dept` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '研发部门', 'admin', '2026-07-06 14:02:09.000000', '研发部门', 1, 7, '0,7');
INSERT INTO `sys_dept` VALUES (4, 'admin', '2026-06-08 14:05:03.000000', '测试部门', 'admin', '2026-07-06 14:02:17.000000', '测试部门', 3, 1, '0,1');
INSERT INTO `sys_dept` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '生产部门', 'admin', '2026-07-06 14:02:22.000000', '生产部门', 5, 1, '0,1');
INSERT INTO `sys_dept` VALUES (7, 'admin', '2026-06-09 11:01:57.000000', NULL, 'admin', '2026-06-09 11:02:21.000000', '浩斌信息科技', 2, 0, '0');
INSERT INTO `sys_dept` VALUES (8, 'admin', '2026-06-09 11:05:11.000000', NULL, 'admin', '2026-07-06 14:11:15.000000', '销售部门', 5, 1, '0,1');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `file_md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `file_size` decimal(38, 2) NULL DEFAULT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------

-- ----------------------------
-- Table structure for sys_login_infor
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_infor`;
CREATE TABLE `sys_login_infor`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ipaddr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `login_time` datetime(6) NULL DEFAULT NULL,
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_login_infor
-- ----------------------------
INSERT INTO `sys_login_infor` VALUES (1, NULL, '2026-06-08 14:29:13.635000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, 'org.hibernate.query.ParameterLabelException: Ordinal parameter labels start from \'?0\' (ordinal parameters must be labelled from \'?1\')', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (2, NULL, '2026-06-08 14:36:57.476000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (3, NULL, '2026-06-08 14:44:30.944000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (4, NULL, '2026-06-08 14:50:04.422000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (5, NULL, '2026-06-08 14:51:08.411000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (6, NULL, '2026-06-08 15:13:51.469000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (7, NULL, '2026-06-08 15:30:27.888000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (8, NULL, '2026-06-08 15:42:53.020000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (9, NULL, '2026-06-08 16:09:00.689000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (10, NULL, '2026-06-08 16:10:05.782000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (11, NULL, '2026-06-08 16:13:12.689000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (12, NULL, '2026-06-08 16:14:01.816000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (13, NULL, '2026-06-08 16:44:07.577000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (14, NULL, '2026-06-08 16:54:00.020000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (15, NULL, '2026-06-08 17:01:47.429000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (16, NULL, '2026-06-08 17:09:16.420000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (17, NULL, '2026-06-08 17:18:55.834000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (18, NULL, '2026-06-08 17:23:14.244000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (19, NULL, '2026-06-08 17:27:58.888000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (20, NULL, '2026-06-08 17:32:24.867000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (21, NULL, '2026-06-08 17:38:18.676000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (22, NULL, '2026-06-08 18:02:14.610000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (23, NULL, '2026-06-09 08:48:02.486000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (24, NULL, '2026-06-09 09:03:15.148000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (25, NULL, '2026-06-09 09:23:48.104000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (26, NULL, '2026-06-09 09:38:18.545000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (27, NULL, '2026-06-09 09:40:29.617000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (28, NULL, '2026-06-09 09:44:24.805000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (29, NULL, '2026-06-09 09:59:01.018000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (30, NULL, '2026-06-09 10:02:32.053000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (31, NULL, '2026-06-09 10:08:20.261000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (32, NULL, '2026-06-09 10:12:11.409000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (33, NULL, '2026-06-09 10:13:54.489000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (34, NULL, '2026-06-09 10:18:26.708000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (35, NULL, '2026-06-09 10:20:26.745000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (36, NULL, '2026-06-09 10:30:51.302000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (37, NULL, '2026-06-09 10:31:23.739000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (38, NULL, '2026-06-09 10:34:12.223000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (39, NULL, '2026-06-09 10:38:50.974000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (40, NULL, '2026-06-09 10:39:46.582000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (41, NULL, '2026-06-09 10:47:10.136000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (42, NULL, '2026-06-09 10:54:35.126000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (43, NULL, '2026-06-09 11:01:43.906000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (44, NULL, '2026-06-09 11:21:23.665000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (45, NULL, '2026-06-09 11:27:18.242000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (46, NULL, '2026-06-09 11:31:48.426000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (47, NULL, '2026-06-09 11:33:09.942000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (48, NULL, '2026-06-09 11:38:19.779000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (49, NULL, '2026-06-09 13:51:19.360000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (50, NULL, '2026-06-09 13:55:28.064000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (51, NULL, '2026-06-09 14:02:06.046000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (52, NULL, '2026-06-09 14:05:51.559000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '用户名或密码不正确', 'Windows 10', '0', 'admin');
INSERT INTO `sys_login_infor` VALUES (53, NULL, '2026-06-09 14:05:59.369000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (54, NULL, '2026-06-09 14:06:24.094000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (55, NULL, '2026-06-09 14:16:56.179000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (56, NULL, '2026-06-09 14:22:18.410000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (57, NULL, '2026-06-09 14:26:44.781000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (58, NULL, '2026-06-09 14:29:03.283000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (59, NULL, '2026-06-09 14:30:08.653000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (60, NULL, '2026-06-09 14:32:20.313000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (61, NULL, '2026-06-09 14:44:51.136000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (62, NULL, '2026-06-09 14:46:46.461000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (63, NULL, '2026-06-09 14:48:26.169000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (64, NULL, '2026-06-09 15:52:52.351000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (65, NULL, '2026-06-09 15:57:09.541000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (66, NULL, '2026-06-09 15:58:02.896000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (67, NULL, '2026-06-09 15:58:12.582000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '用户名或密码不正确', 'Windows 10', '0', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (68, NULL, '2026-06-09 15:58:23.429000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (69, NULL, '2026-06-09 15:58:24.009000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (70, NULL, '2026-06-09 16:00:36.282000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (71, NULL, '2026-06-09 16:00:36.791000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (72, NULL, '2026-06-09 16:04:30.974000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (73, NULL, '2026-06-09 16:04:31.279000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (74, NULL, '2026-06-09 16:04:53.612000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (75, NULL, '2026-06-09 16:04:53.705000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (76, NULL, '2026-06-09 16:10:06.836000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (77, NULL, '2026-06-09 16:37:37.224000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (78, NULL, '2026-06-09 16:38:14.664000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (79, NULL, '2026-06-09 16:46:49.274000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (80, NULL, '2026-06-09 16:47:21.563000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (81, NULL, '2026-06-09 16:47:30.673000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (82, NULL, '2026-06-09 17:07:58.922000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (83, NULL, '2026-06-09 17:08:11.268000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (84, NULL, '2026-06-09 17:08:15.400000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (85, NULL, '2026-06-13 12:50:58.931000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (86, NULL, '2026-06-13 13:36:26.883000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (87, NULL, '2026-06-13 13:55:01.797000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (88, NULL, '2026-06-13 14:23:19.442000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (89, NULL, '2026-06-13 14:35:14.567000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (90, NULL, '2026-06-13 14:56:38.826000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (91, NULL, '2026-06-13 15:13:27.406000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (92, NULL, '2026-06-13 15:39:25.632000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (93, NULL, '2026-06-13 16:11:45.556000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (94, NULL, '2026-06-13 16:35:45.082000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (95, NULL, '2026-06-15 11:25:06.296000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (96, NULL, '2026-06-15 13:01:28.682000', NULL, NULL, NULL, 'Chrome 14', '127.0.0.1', '内网IP', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (97, NULL, '2026-07-03 14:56:59.386000', NULL, NULL, '2026-07-03 14:56:59.386000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (98, NULL, '2026-07-03 16:26:49.265000', NULL, NULL, '2026-07-03 16:26:49.265000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (99, NULL, '2026-07-03 16:35:35.452000', NULL, NULL, '2026-07-03 16:35:35.452000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (100, NULL, '2026-07-03 16:40:15.193000', NULL, NULL, '2026-07-03 16:40:15.193000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (101, NULL, '2026-07-03 16:41:20.820000', NULL, NULL, '2026-07-03 16:41:20.820000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (102, NULL, '2026-07-06 10:23:28.917000', NULL, NULL, '2026-07-06 10:23:28.917000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (103, NULL, '2026-07-06 11:12:29.003000', NULL, NULL, '2026-07-06 11:12:29.003000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (104, NULL, '2026-07-06 11:21:28.815000', NULL, NULL, '2026-07-06 11:21:28.815000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (105, NULL, '2026-07-06 13:22:38.989000', NULL, NULL, '2026-07-06 13:22:38.989000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (106, NULL, '2026-07-06 13:23:27.912000', NULL, NULL, '2026-07-06 13:23:27.912000', 'Chrome 14', '127.0.0.1', '', NULL, '退出成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (107, NULL, '2026-07-06 13:23:34.928000', NULL, NULL, '2026-07-06 13:23:34.928000', 'Chrome 14', '127.0.0.1', '', NULL, '用户名或密码不正确', 'Windows 10', '0', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (108, NULL, '2026-07-06 13:23:44.092000', NULL, NULL, '2026-07-06 13:23:44.092000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (109, NULL, '2026-07-06 13:24:29.944000', NULL, NULL, '2026-07-06 13:24:29.944000', 'Chrome 14', '127.0.0.1', '', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (110, NULL, '2026-07-06 13:24:42.716000', NULL, NULL, '2026-07-06 13:24:42.716000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (111, NULL, '2026-07-06 13:36:45.692000', NULL, NULL, '2026-07-06 13:36:45.692000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (112, NULL, '2026-07-06 14:00:40.061000', NULL, NULL, '2026-07-06 14:00:40.061000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (113, NULL, '2026-07-06 14:10:23.048000', NULL, NULL, '2026-07-06 14:10:23.048000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (114, NULL, '2026-07-06 14:33:54.810000', NULL, NULL, '2026-07-06 14:33:54.810000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (115, NULL, '2026-07-06 14:41:48.104000', NULL, NULL, '2026-07-06 14:41:48.104000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (116, NULL, '2026-07-06 14:44:29.001000', NULL, NULL, '2026-07-06 14:44:29.001000', 'Chrome 14', '127.0.0.1', '', NULL, '退出成功', 'Windows 10', '1', 'admin');
INSERT INTO `sys_login_infor` VALUES (117, NULL, '2026-07-06 14:44:38.525000', NULL, NULL, '2026-07-06 14:44:38.525000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (118, NULL, '2026-07-06 14:46:56.132000', NULL, NULL, '2026-07-06 14:46:56.132000', 'Chrome 14', '127.0.0.1', '', NULL, '退出成功', 'Windows 10', '1', 'xiaoming');
INSERT INTO `sys_login_infor` VALUES (119, NULL, '2026-07-06 14:47:05.560000', NULL, NULL, '2026-07-06 14:47:05.560000', 'Chrome 14', '127.0.0.1', '', NULL, '登录成功', 'Windows 10', '1', 'admin');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `is_cache` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `is_frame` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `menu_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `perms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK2jrf4gb0gjqi8882gxytpxnhe`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', NULL, 'admin', '2026-06-09 09:59:13.438000', NULL, 'Setting', '0', '0', '系统管理', 'M', 1, 'system', '', NULL, '', '1', 0);
INSERT INTO `sys_menu` VALUES (100, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/user/index', 'user', '1', '0', '用户管理', 'C', 1, 'user', 'system:user:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (101, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/role/index', 'user-filled', '1', '0', '角色管理', 'C', 2, 'role', 'system:role:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (102, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/menu/index', 'menu', '1', '0', '菜单管理', 'C', 3, 'menu', 'system:menu:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (103, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/dept/index', 'office-building', '1', '0', '部门管理', 'C', 4, 'dept', 'system:dept:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (105, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/config/index', 'setting', '1', '0', '参数设置', 'C', 6, 'config', 'system:config:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (106, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/operlog/index', 'document', '1', '0', '操作日志', 'C', 7, 'operlog', 'system:operlog:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (107, 'admin', '2026-06-08 14:05:03.000000', NULL, 'admin', '2026-06-09 10:08:34.544000', 'system/logininfor/index', 'list', '1', '0', '登录日志', 'C', 8, 'logininfor', 'system:logininfor:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (1000, 'admin', '2026-06-08 14:05:03.000000', NULL, 'admin', '2026-07-06 14:43:23.000000', NULL, '', '1', '0', '用户查询', 'F', 1, '', 'system:user:query', NULL, '', '1', 100);
INSERT INTO `sys_menu` VALUES (1001, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '用户新增', 'F', 2, '', 'system:user:add', NULL, '', '1', 100);
INSERT INTO `sys_menu` VALUES (1002, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '用户修改', 'F', 3, '', 'system:user:edit', NULL, '', '1', 100);
INSERT INTO `sys_menu` VALUES (1003, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '用户删除', 'F', 4, '', 'system:user:remove', NULL, '', '1', 100);
INSERT INTO `sys_menu` VALUES (1004, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '重置密码', 'F', 5, '', 'system:user:resetPwd', NULL, '', '1', 100);
INSERT INTO `sys_menu` VALUES (1005, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '角色查询', 'F', 1, '', 'system:role:query', NULL, '', '1', 101);
INSERT INTO `sys_menu` VALUES (1006, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '角色新增', 'F', 2, '', 'system:role:add', NULL, '', '1', 101);
INSERT INTO `sys_menu` VALUES (1007, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '角色修改', 'F', 3, '', 'system:role:edit', NULL, '', '1', 101);
INSERT INTO `sys_menu` VALUES (1008, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '角色删除', 'F', 4, '', 'system:role:remove', NULL, '', '1', 101);
INSERT INTO `sys_menu` VALUES (1009, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '菜单查询', 'F', 1, '', 'system:menu:query', NULL, '', '1', 102);
INSERT INTO `sys_menu` VALUES (1010, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '菜单新增', 'F', 2, '', 'system:menu:add', NULL, '', '1', 102);
INSERT INTO `sys_menu` VALUES (1011, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '菜单修改', 'F', 3, '', 'system:menu:edit', NULL, '', '1', 102);
INSERT INTO `sys_menu` VALUES (1012, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '菜单删除', 'F', 4, '', 'system:menu:remove', NULL, '', '1', 102);
INSERT INTO `sys_menu` VALUES (1013, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '部门查询', 'F', 1, '', 'system:dept:query', NULL, '', '1', 103);
INSERT INTO `sys_menu` VALUES (1014, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '部门新增', 'F', 2, '', 'system:dept:add', NULL, '', '1', 103);
INSERT INTO `sys_menu` VALUES (1015, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '部门修改', 'F', 3, '', 'system:dept:edit', NULL, '', '1', 103);
INSERT INTO `sys_menu` VALUES (1016, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '部门删除', 'F', 4, '', 'system:dept:remove', NULL, '', '1', 103);
INSERT INTO `sys_menu` VALUES (1021, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数查询', 'F', 1, '', 'system:config:query', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1022, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数新增', 'F', 2, '', 'system:config:add', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1023, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数修改', 'F', 3, '', 'system:config:edit', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1024, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数删除', 'F', 4, '', 'system:config:remove', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1025, 'admin', '2026-06-09 10:09:08.473000', NULL, NULL, NULL, NULL, NULL, '1', '0', '删除', 'F', 1, NULL, NULL, NULL, NULL, '1', 107);
INSERT INTO `sys_menu` VALUES (1027, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '登录查询', 'F', 1, '', 'system:logininfor:query', NULL, '', '1', 107);
INSERT INTO `sys_menu` VALUES (1028, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '登录删除', 'F', 2, '', 'system:logininfor:remove', NULL, '', '1', 107);
INSERT INTO `sys_menu` VALUES (1029, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '操作查询', 'F', 1, '', 'system:operlog:query', NULL, '', '1', 106);
INSERT INTO `sys_menu` VALUES (1030, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '操作删除', 'F', 2, '', 'system:operlog:remove', NULL, '', '1', 106);
INSERT INTO `sys_menu` VALUES (10000, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, 'Document', '0', '0', '问卷管理', 'M', 2, 'questionnaire', '', NULL, '', '1', 0);
INSERT INTO `sys_menu` VALUES (10010, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'questionnaire/template/index', 'EditPen', '1', '0', '问卷模板', 'C', 1, 'template', 'qm:template:list', NULL, '', '1', 10000);
INSERT INTO `sys_menu` VALUES (10011, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '模板查询', 'F', 1, '', 'qm:template:query', NULL, '', '1', 10010);
INSERT INTO `sys_menu` VALUES (10012, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '模板新增', 'F', 2, '', 'qm:template:add', NULL, '', '1', 10010);
INSERT INTO `sys_menu` VALUES (10013, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '模板修改', 'F', 3, '', 'qm:template:edit', NULL, '', '1', 10010);
INSERT INTO `sys_menu` VALUES (10014, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '模板删除', 'F', 4, '', 'qm:template:remove', NULL, '', '1', 10010);
INSERT INTO `sys_menu` VALUES (10015, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '模板导入', 'F', 5, '', 'qm:template:import', NULL, '', '1', 10010);
INSERT INTO `sys_menu` VALUES (10020, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'questionnaire/designer/index', '', '1', '0', '问卷设计器', 'C', 2, 'designer', 'qm:template:query', NULL, '', '0', 10000);
INSERT INTO `sys_menu` VALUES (11000, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, 'DataAnalysis', '0', '0', '评估管理', 'M', 3, 'assessment', '', NULL, '', '1', 0);
INSERT INTO `sys_menu` VALUES (11010, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'assessment/survey/index', 'Promotion', '1', '0', '问卷分发', 'C', 1, 'survey', 'as:survey:list', NULL, '', '1', 11000);
INSERT INTO `sys_menu` VALUES (11011, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '分发查询', 'F', 1, '', 'as:survey:query', NULL, '', '1', 11010);
INSERT INTO `sys_menu` VALUES (11012, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '问卷分发', 'F', 2, '', 'as:survey:distribute', NULL, '', '1', 11010);
INSERT INTO `sys_menu` VALUES (11013, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '答卷退回', 'F', 3, '', 'as:survey:return', NULL, '', '1', 11010);
INSERT INTO `sys_menu` VALUES (11014, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '分发删除', 'F', 4, '', 'as:survey:remove', NULL, '', '1', 11010);
INSERT INTO `sys_menu` VALUES (11015, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '完成审核', 'F', 5, '', 'as:survey:review', NULL, '', '1', 11010);
INSERT INTO `sys_menu` VALUES (11030, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'assessment/survey/detail', '', '1', '0', '评估详情', 'C', 3, 'surveyDetail', 'as:survey:query', NULL, '', '0', 11000);
INSERT INTO `sys_menu` VALUES (12000, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'system/mail/index', 'Message', '1', '0', '邮件配置', 'C', 9, 'mail', 'system:mail:config', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (13000, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, 'Warning', '0', '0', '风险管理', 'M', 4, 'risk', '', NULL, '', '1', 0);
INSERT INTO `sys_menu` VALUES (13010, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'risk/register/index', 'List', '1', '0', '风险记录', 'C', 1, 'register', 'risk:register:list', NULL, '', '1', 13000);
INSERT INTO `sys_menu` VALUES (13011, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险查询', 'F', 1, '', 'risk:register:query', NULL, '', '1', 13010);
INSERT INTO `sys_menu` VALUES (13013, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险修改', 'F', 3, '', 'risk:register:edit', NULL, '', '1', 13010);
INSERT INTO `sys_menu` VALUES (13014, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险删除', 'F', 4, '', 'risk:register:remove', NULL, '', '1', 13010);
INSERT INTO `sys_menu` VALUES (13020, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, 'risk/library/index', 'Files', '1', '0', '风险库', 'C', 2, 'library', 'risk:library:list', NULL, '', '1', 13000);
INSERT INTO `sys_menu` VALUES (13021, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险库查询', 'F', 1, '', 'risk:library:query', NULL, '', '1', 13020);
INSERT INTO `sys_menu` VALUES (13022, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险库新增', 'F', 2, '', 'risk:library:add', NULL, '', '1', 13020);
INSERT INTO `sys_menu` VALUES (13023, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险库修改', 'F', 3, '', 'risk:library:edit', NULL, '', '1', 13020);
INSERT INTO `sys_menu` VALUES (13024, 'admin', '2026-07-01 00:00:00.000000', NULL, NULL, NULL, NULL, '', '1', '0', '风险库删除', 'F', 4, '', 'risk:library:remove', NULL, '', '1', 13020);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `business_type` int NULL DEFAULT NULL,
  `cost_time` bigint NULL DEFAULT NULL,
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `json_result` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `oper_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `oper_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `oper_param` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `oper_time` datetime(6) NULL DEFAULT NULL,
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 2, 50, '若同科技', NULL, '{\"code\":200,\"msg\":\"操作成功\"}', 'SysUserController.editData()', '127.0.0.1', '内网IP', 'admin', '{}', '2026-06-08 14:05:03.000000', '/system/user/update', 'POST', 0, '用户管理');
INSERT INTO `sys_oper_log` VALUES (2, NULL, '2026-06-09 15:54:03.906000', NULL, NULL, NULL, 2, 238, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.editData()', '127.0.0.1', '内网IP', 'admin', '{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-06-08 17:43:36\",\"dept\":{\"id\":2},\"email\":\"1122@qq.com\",\"id\":3,\"nickName\":\"小明\",\"phonenumber\":\"1102222\",\"remark\":\"测试\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 15:54:03\",\"userName\":\"xiaoming\"}', NULL, '/system/user/update', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (3, NULL, '2026-06-09 15:55:29.799000', NULL, NULL, NULL, 3, 31, '儒通物联网', 'org.hibernate.query.sqm.UnknownEntityException: Could not resolve root entity \'SysUserRole\'', NULL, 'com.rutong.business.system.controller.SysUserController.delData()', '127.0.0.1', '内网IP', 'admin', '[2]', NULL, '/system/user/delete/2', 'POST', 0, '用户管理');
INSERT INTO `sys_oper_log` VALUES (4, NULL, '2026-06-09 15:57:16.281000', NULL, NULL, NULL, 3, 71, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.delData()', '127.0.0.1', '内网IP', 'admin', '[2]', NULL, '/system/user/delete/2', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (5, NULL, '2026-06-13 12:51:44.049000', NULL, NULL, NULL, 3, 541, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.delDataById()', '127.0.0.1', '内网IP', 'admin', '1026', NULL, '/system/menu/deleteById/1026', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (6, NULL, '2026-06-13 12:54:17.504000', NULL, NULL, NULL, 2, 73, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '内网IP', 'admin', '{\"component\":\"iot/gateway/index\",\"createBy\":\"admin\",\"createTime\":\"2026-06-13 12:50:21\",\"icon\":\"Cellphone\",\"id\":9001,\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"网关管理\",\"menuType\":\"C\",\"orderNum\":1,\"path\":\"gateway\",\"perms\":\"iot:gateway:list\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-13 12:54:17\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (7, NULL, '2026-06-13 14:03:07.825000', NULL, NULL, NULL, 2, 273, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '内网IP', 'admin', '{\"component\":\"iot/device/index\",\"createBy\":\"admin\",\"createTime\":\"2026-06-13 14:02:11\",\"icon\":\"Food\",\"id\":9004,\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"设备管理\",\"menuType\":\"C\",\"orderNum\":4,\"path\":\"device\",\"perms\":\"iot:device:list\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-13 14:03:07\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (8, NULL, '2026-06-13 15:47:00.266000', NULL, NULL, NULL, 2, 92, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '内网IP', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-13 12:50:21\",\"icon\":\"monitor\",\"id\":9000,\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"昆仑智联\",\"menuType\":\"M\",\"orderNum\":5,\"path\":\"/iot\",\"perms\":\"\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-13 15:47:00\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (9, NULL, '2026-06-13 16:39:01.525000', NULL, NULL, NULL, 2, 85, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '内网IP', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-13 12:50:21\",\"icon\":\"monitor\",\"id\":9000,\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"物联采集\",\"menuType\":\"M\",\"orderNum\":5,\"path\":\"/iot\",\"perms\":\"\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-13 16:39:01\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (10, NULL, '2026-07-03 15:02:53.460000', NULL, NULL, '2026-07-03 15:02:53.460000', 4, 421, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200}', 'com.rutong.business.system.controller.SysRoleController.authMenu()', '127.0.0.1', '', 'admin', '{\"roleId\":2,\"menuIds\":[1,102,100,103,105,12000,101,10000,10020,10010,11000,11030,11010,13000,13020,13010]}', NULL, '/system/role/authMenu', 'POST', 1, '角色管理');
INSERT INTO `sys_oper_log` VALUES (11, NULL, '2026-07-03 16:04:54.954000', NULL, NULL, '2026-07-03 16:04:54.954000', 1, 132, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"DISTRIBUTED\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}]}', 'com.rutong.business.assessment.controller.AsSurveyController.distribute()', '127.0.0.1', '', 'admin', '{\"assessorIds\":[1],\"assignments\":[{\"chapterIds\":[],\"userId\":1}],\"templateId\":1,\"title\":\"\"}', NULL, '/assessment/survey/distribute', 'POST', 1, '评估分发');
INSERT INTO `sys_oper_log` VALUES (12, NULL, '2026-07-03 16:07:20.340000', NULL, NULL, '2026-07-03 16:07:20.340000', 2, 121, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"不适用\",\"questionId\":18,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (13, NULL, '2026-07-03 16:07:26.609000', NULL, NULL, '2026-07-03 16:07:26.609000', 2, 66, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":18,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (14, NULL, '2026-07-03 16:09:53.985000', NULL, NULL, '2026-07-03 16:09:53.985000', 2, 53, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"部分落实\",\"questionId\":2,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (15, NULL, '2026-07-03 16:09:54.710000', NULL, NULL, '2026-07-03 16:09:54.710000', 2, 49, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"部分落实\",\"questionId\":3,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (16, NULL, '2026-07-03 16:09:56.108000', NULL, NULL, '2026-07-03 16:09:56.108000', 2, 65, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":4,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (17, NULL, '2026-07-03 16:09:57.363000', NULL, NULL, '2026-07-03 16:09:57.363000', 2, 65, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":5,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (18, NULL, '2026-07-03 16:10:00.384000', NULL, NULL, '2026-07-03 16:10:00.384000', 2, 54, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":6,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (19, NULL, '2026-07-03 16:10:00.982000', NULL, NULL, '2026-07-03 16:10:00.982000', 2, 97, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":7,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (20, NULL, '2026-07-03 16:10:01.926000', NULL, NULL, '2026-07-03 16:10:01.926000', 2, 90, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"[\\\"书面签署\\\"]\",\"questionId\":8,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (21, NULL, '2026-07-03 16:10:04.021000', NULL, NULL, '2026-07-03 16:10:04.021000', 2, 46, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"官方网站公示\",\"questionId\":9,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (22, NULL, '2026-07-03 16:10:05.380000', NULL, NULL, '2026-07-03 16:10:05.380000', 2, 36, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"N\",\"questionId\":10,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (23, NULL, '2026-07-03 16:10:07.647000', NULL, NULL, '2026-07-03 16:10:07.647000', 2, 51, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"已落实\",\"questionId\":11,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (24, NULL, '2026-07-03 16:10:09.386000', NULL, NULL, '2026-07-03 16:10:09.386000', 2, 67, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"部分落实\",\"questionId\":12,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (25, NULL, '2026-07-03 16:10:10.697000', NULL, NULL, '2026-07-03 16:10:10.697000', 2, 62, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"[\\\"宗教信仰\\\"]\",\"questionId\":13,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (26, NULL, '2026-07-03 16:10:14.209000', NULL, NULL, '2026-07-03 16:10:14.209000', 2, 62, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"无\",\"questionId\":14,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (27, NULL, '2026-07-03 16:10:17.505000', NULL, NULL, '2026-07-03 16:10:17.505000', 2, 61, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":15,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (28, NULL, '2026-07-03 16:10:18.315000', NULL, NULL, '2026-07-03 16:10:18.315000', 2, 226, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":16,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (29, NULL, '2026-07-03 16:10:18.916000', NULL, NULL, '2026-07-03 16:10:18.916000', 2, 61, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":17,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (30, NULL, '2026-07-03 16:10:22.253000', NULL, NULL, '2026-07-03 16:10:22.253000', 2, 49, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"111\",\"questionId\":19,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (31, NULL, '2026-07-03 16:10:24.040000', NULL, NULL, '2026-07-03 16:10:24.040000', 2, 46, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"[\\\"访问权限控制\\\"]\",\"questionId\":20,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (32, NULL, '2026-07-03 16:10:25.299000', NULL, NULL, '2026-07-03 16:10:25.299000', 2, 56, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":21,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (33, NULL, '2026-07-03 16:10:26.781000', NULL, NULL, '2026-07-03 16:10:26.781000', 2, 72, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":22,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (34, NULL, '2026-07-03 16:41:32.603000', NULL, NULL, '2026-07-03 16:41:32.603000', 2, 162, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200}', 'com.rutong.business.system.controller.SysRoleController.editData()', '127.0.0.1', '', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"dataScope\":\"2\",\"depts\":[{\"id\":4},{\"id\":6},{\"id\":2}],\"id\":2,\"remark\":\"普通角色\",\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 09:44:41\"}', NULL, '/system/role/update', 'POST', 1, '角色管理');
INSERT INTO `sys_oper_log` VALUES (35, NULL, '2026-07-06 11:14:49.378000', NULL, NULL, '2026-07-06 11:14:49.378000', 1, 139, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"content\":\"请补充附件\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 11:14:49\",\"id\":1,\"questionId\":2,\"senderType\":\"RESPONDENT\",\"senderUserId\":1,\"surveyId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 11:14:49\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.addRequest()', '127.0.0.1', '', 'admin', '{\"content\":\"请补充附件\",\"questionId\":2,\"surveyId\":1}', NULL, '/assessment/survey/request', 'POST', 1, '创建请求');
INSERT INTO `sys_oper_log` VALUES (36, NULL, '2026-07-06 11:14:54.870000', NULL, NULL, '2026-07-06 11:14:54.870000', 2, 99, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"submitTime\":\"2026-07-03 16:10:33\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.sendBack()', '127.0.0.1', '', 'admin', '1', NULL, '/assessment/survey/sendBack/1', 'POST', 1, '评估发回');
INSERT INTO `sys_oper_log` VALUES (37, NULL, '2026-07-06 11:15:15.467000', NULL, NULL, '2026-07-06 11:15:15.467000', 2, 115, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"FILLING\",\"submitTime\":\"2026-07-03 16:10:33\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'admin', '1 [{\"answerValue\":\"未落实\",\"questionId\":2,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/1', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (38, NULL, '2026-07-06 11:15:30.813000', NULL, NULL, '2026-07-06 11:15:30.813000', 2, 73, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-03 16:04:54\",\"distributeTime\":\"2026-07-03 16:04:54\",\"id\":1,\"operUserId\":1,\"respondentEmail\":\"admin@rutong.com\",\"respondentName\":\"超级管理员\",\"respondentUserId\":1,\"status\":\"APPROVED\",\"submitTime\":\"2026-07-06 11:15:16\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-03 16:04:54\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.review()', '127.0.0.1', '', 'admin', '1 {\"result\":\"APPROVED\",\"comment\":\"\"}', NULL, '/assessment/survey/review/1', 'POST', 1, '完成审核');
INSERT INTO `sys_oper_log` VALUES (39, NULL, '2026-07-06 13:23:15.413000', NULL, NULL, '2026-07-06 13:23:15.413000', 1, 84, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"DISTRIBUTED\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}]}', 'com.rutong.business.assessment.controller.AsSurveyController.distribute()', '127.0.0.1', '', 'admin', '{\"assessorIds\":[1],\"assignments\":[{\"chapterIds\":[],\"userId\":3}],\"dueDate\":\"2026-07-31\",\"templateId\":1,\"title\":\"\"}', NULL, '/assessment/survey/distribute', 'POST', 1, '评估分发');
INSERT INTO `sys_oper_log` VALUES (40, NULL, '2026-07-06 13:43:28.750000', NULL, NULL, '2026-07-06 13:43:28.750000', 2, 131, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.editData()', '127.0.0.1', '', 'admin', '{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-06-08 17:43:36\",\"deptId\":2,\"email\":\"1122@qq.com\",\"id\":3,\"nickName\":\"小明\",\"phonenumber\":\"1102222\",\"remark\":\"测试\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 15:54:03\",\"userName\":\"xiaoming\"}', NULL, '/system/user/update', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (41, NULL, '2026-07-06 13:43:38.729000', NULL, NULL, '2026-07-06 13:43:38.729000', 2, 15, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.editData()', '127.0.0.1', '', 'admin', '{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-06-08 17:43:36\",\"deptId\":2,\"email\":\"1122@qq.com\",\"id\":3,\"nickName\":\"小明\",\"phonenumber\":\"1102222\",\"remark\":\"测试\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 15:54:03\",\"userName\":\"xiaoming\"}', NULL, '/system/user/update', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (42, NULL, '2026-07-06 14:02:06.788000', NULL, NULL, '2026-07-06 14:02:06.788000', 2, 83, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"儒通物联网\",\"id\":1,\"orderNum\":0,\"remark\":\"儒通物联网\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 11:04:42\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (43, NULL, '2026-07-06 14:02:09.798000', NULL, NULL, '2026-07-06 14:02:09.798000', 2, 46, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (44, NULL, '2026-07-06 14:02:17.593000', NULL, NULL, '2026-07-06 14:02:17.593000', 2, 50, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"测试部门\",\"id\":4,\"orderNum\":3,\"remark\":\"测试部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:17\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (45, NULL, '2026-07-06 14:02:22.410000', NULL, NULL, '2026-07-06 14:02:22.410000', 2, 85, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"生产部门\",\"id\":6,\"orderNum\":5,\"remark\":\"生产部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:22\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (46, NULL, '2026-07-06 14:10:34.520000', NULL, NULL, '2026-07-06 14:10:34.520000', 2, 70, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (47, NULL, '2026-07-06 14:10:44.391000', NULL, NULL, '2026-07-06 14:10:44.391000', 2, 53, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"测试部门\",\"id\":4,\"orderNum\":3,\"remark\":\"测试部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:17\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (48, NULL, '2026-07-06 14:10:47.930000', NULL, NULL, '2026-07-06 14:10:47.930000', 2, 34, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"生产部门\",\"id\":6,\"orderNum\":5,\"remark\":\"生产部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:22\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (49, NULL, '2026-07-06 14:10:54.627000', NULL, NULL, '2026-07-06 14:10:54.627000', 2, 44, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"儒通物联网\",\"id\":1,\"orderNum\":0,\"remark\":\"儒通物联网\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 11:04:42\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (50, NULL, '2026-07-06 14:11:01.835000', NULL, NULL, '2026-07-06 14:11:01.835000', 2, 27, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (51, NULL, '2026-07-06 14:11:11.585000', NULL, NULL, '2026-07-06 14:11:11.585000', 2, 23, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"测试部门\",\"id\":4,\"orderNum\":3,\"remark\":\"测试部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:17\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (52, NULL, '2026-07-06 14:11:13.766000', NULL, NULL, '2026-07-06 14:11:13.766000', 2, 24, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"生产部门\",\"id\":6,\"orderNum\":5,\"remark\":\"生产部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:22\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (53, NULL, '2026-07-06 14:11:15.774000', NULL, NULL, '2026-07-06 14:11:15.774000', 2, 44, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-09 11:05:11\",\"deptName\":\"销售部门\",\"id\":8,\"orderNum\":5,\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:11:15\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (54, NULL, '2026-07-06 14:11:17.671000', NULL, NULL, '2026-07-06 14:11:17.671000', 2, 29, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-09 11:01:57\",\"deptName\":\"浩斌信息科技\",\"id\":7,\"orderNum\":2,\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 11:02:21\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (55, NULL, '2026-07-06 14:34:08.948000', NULL, NULL, '2026-07-06 14:34:08.948000', 2, 48, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"儒通物联网\",\"id\":1,\"orderNum\":0,\"parentId\":0,\"remark\":\"儒通物联网\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 11:04:42\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (56, NULL, '2026-07-06 14:34:11.694000', NULL, NULL, '2026-07-06 14:34:11.694000', 2, 70, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"parentId\":0,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (57, NULL, '2026-07-06 14:34:33.336000', NULL, NULL, '2026-07-06 14:34:33.336000', 2, 105, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"parentId\":0,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (58, NULL, '2026-07-06 14:38:18.713000', NULL, NULL, '2026-07-06 14:38:18.713000', 2, 83, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0,7\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"研发部门\",\"id\":2,\"orderNum\":1,\"parentId\":7,\"remark\":\"研发部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:09\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (59, NULL, '2026-07-06 14:38:32.950000', NULL, NULL, '2026-07-06 14:38:32.950000', 2, 120, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0,1\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"测试部门\",\"id\":4,\"orderNum\":3,\"parentId\":1,\"remark\":\"测试部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:17\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (60, NULL, '2026-07-06 14:38:35.100000', NULL, NULL, '2026-07-06 14:38:35.100000', 2, 89, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0,1\",\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"deptName\":\"生产部门\",\"id\":6,\"orderNum\":5,\"parentId\":1,\"remark\":\"生产部门\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:02:22\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (61, NULL, '2026-07-06 14:38:37.331000', NULL, NULL, '2026-07-06 14:38:37.331000', 2, 99, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0,1\",\"createBy\":\"admin\",\"createTime\":\"2026-06-09 11:05:11\",\"deptName\":\"销售部门\",\"id\":8,\"orderNum\":5,\"parentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:11:15\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (62, NULL, '2026-07-06 14:38:39.746000', NULL, NULL, '2026-07-06 14:38:39.746000', 2, 26, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysDeptController.editData()', '127.0.0.1', '', 'admin', '{\"ancestors\":\"0\",\"createBy\":\"admin\",\"createTime\":\"2026-06-09 11:01:57\",\"deptName\":\"浩斌信息科技\",\"id\":7,\"orderNum\":2,\"parentId\":0,\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 11:02:21\"}', NULL, '/system/dept/update', 'POST', 1, '部门管理');
INSERT INTO `sys_oper_log` VALUES (63, NULL, '2026-07-06 14:42:13.323000', NULL, NULL, '2026-07-06 14:42:13.323000', 2, 165, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.editData()', '127.0.0.1', '', 'admin', '{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-06-08 17:43:36\",\"deptId\":2,\"email\":\"1122@qq.com\",\"id\":3,\"nickName\":\"小明\",\"phonenumber\":\"1102222\",\"remark\":\"测试\",\"roleIds\":[2,1],\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 15:54:03\",\"userName\":\"xiaoming\"}', NULL, '/system/user/update', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (64, NULL, '2026-07-06 14:42:17.862000', NULL, NULL, '2026-07-06 14:42:17.862000', 2, 65, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysUserController.editData()', '127.0.0.1', '', 'admin', '{\"admin\":false,\"createBy\":\"admin\",\"createTime\":\"2026-06-08 17:43:36\",\"deptId\":2,\"email\":\"1122@qq.com\",\"id\":3,\"nickName\":\"小明\",\"phonenumber\":\"1102222\",\"remark\":\"测试\",\"roleIds\":[2],\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2026-06-09 15:54:03\",\"userName\":\"xiaoming\"}', NULL, '/system/user/update', 'POST', 1, '用户管理');
INSERT INTO `sys_oper_log` VALUES (65, NULL, '2026-07-06 14:42:40.210000', NULL, NULL, '2026-07-06 14:42:40.210000', 4, 116, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200}', 'com.rutong.business.system.controller.SysRoleController.authMenu()', '127.0.0.1', '', 'admin', '{\"roleId\":2,\"menuIds\":[1,100,1000,1001,1002,1003,1004,101,1005,1006,1007,1008,102,1009,1010,1011,1012,103,1013,1014,1015,1016,105,1021,1022,1023,1024,106,1029,1030,107,1025,1027,1028,12000,10000,10010,10011,10012,10013,10014,10015,10020,11000,11010,11011,11012,11013,11014,11015,11030,13000,13010,13011,13013,13014,13020,13021,13022,13023,13024]}', NULL, '/system/role/authMenu', 'POST', 1, '角色管理');
INSERT INTO `sys_oper_log` VALUES (66, NULL, '2026-07-06 14:42:53.015000', NULL, NULL, '2026-07-06 14:42:53.015000', 4, 56, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200}', 'com.rutong.business.system.controller.SysRoleController.authMenu()', '127.0.0.1', '', 'admin', '{\"roleId\":2,\"menuIds\":[10000,10010,10011,10012,10013,10014,10015,10020,11000,11010,11011,11012,11013,11014,11015,11030,13000,13010,13011,13013,13014,13020,13021,13022,13023,13024]}', NULL, '/system/role/authMenu', 'POST', 1, '角色管理');
INSERT INTO `sys_oper_log` VALUES (67, NULL, '2026-07-06 14:43:24.014000', NULL, NULL, '2026-07-06 14:43:24.014000', 2, 78, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '', 'admin', '{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"icon\":\"\",\"id\":1000,\"isCache\":\"1\",\"isFrame\":\"0\",\"menuName\":\"用户查询\",\"menuType\":\"F\",\"orderNum\":1,\"parentId\":1,\"path\":\"\",\"perms\":\"system:user:query\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:43:23\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (68, NULL, '2026-07-06 14:43:40.850000', NULL, NULL, '2026-07-06 14:43:40.850000', 2, 121, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.editData()', '127.0.0.1', '', 'admin', '{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2026-06-08 14:05:03\",\"icon\":\"\",\"id\":1000,\"isCache\":\"1\",\"isFrame\":\"0\",\"menuName\":\"用户查询\",\"menuType\":\"F\",\"orderNum\":1,\"parentId\":100,\"path\":\"\",\"perms\":\"system:user:query\",\"routeName\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:43:23\",\"visible\":\"1\"}', NULL, '/system/menu/update', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (69, NULL, '2026-07-06 14:44:07.710000', NULL, NULL, '2026-07-06 14:44:07.710000', 1, 74, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.addData()', '127.0.0.1', '', 'admin', '{\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2026-07-06 14:44:07\",\"id\":13025,\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"测试\",\"menuType\":\"M\",\"orderNum\":0,\"parentId\":100,\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:44:07\",\"visible\":\"1\"}', NULL, '/system/menu/save', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (70, NULL, '2026-07-06 14:44:11.323000', NULL, NULL, '2026-07-06 14:44:11.323000', 3, 55, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 'com.rutong.business.system.controller.SysMenuController.delDataById()', '127.0.0.1', '', 'admin', '13025', NULL, '/system/menu/deleteById/13025', 'POST', 1, '菜单管理');
INSERT INTO `sys_oper_log` VALUES (71, NULL, '2026-07-06 14:44:58.978000', NULL, NULL, '2026-07-06 14:44:58.978000', 2, 66, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"部分落实\",\"questionId\":2,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (72, NULL, '2026-07-06 14:44:59.993000', NULL, NULL, '2026-07-06 14:44:59.993000', 2, 66, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"部分落实\",\"questionId\":3,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (73, NULL, '2026-07-06 14:45:02.174000', NULL, NULL, '2026-07-06 14:45:02.174000', 2, 147, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":4,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (74, NULL, '2026-07-06 14:45:02.689000', NULL, NULL, '2026-07-06 14:45:02.689000', 2, 84, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":5,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (75, NULL, '2026-07-06 14:45:05.246000', NULL, NULL, '2026-07-06 14:45:05.246000', 2, 64, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":6,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (76, NULL, '2026-07-06 14:45:06.402000', NULL, NULL, '2026-07-06 14:45:06.402000', 2, 97, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":7,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (77, NULL, '2026-07-06 14:45:06.876000', NULL, NULL, '2026-07-06 14:45:06.876000', 2, 87, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"[\\\"书面签署\\\"]\",\"questionId\":8,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (78, NULL, '2026-07-06 14:45:08.852000', NULL, NULL, '2026-07-06 14:45:08.852000', 2, 72, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"纸质告知\",\"questionId\":9,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (79, NULL, '2026-07-06 14:45:10.725000', NULL, NULL, '2026-07-06 14:45:10.725000', 2, 142, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"N\",\"questionId\":10,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (80, NULL, '2026-07-06 14:45:13.456000', NULL, NULL, '2026-07-06 14:45:13.456000', 2, 65, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":11,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (81, NULL, '2026-07-06 14:45:14.360000', NULL, NULL, '2026-07-06 14:45:14.360000', 2, 279, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"未落实\",\"questionId\":12,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (82, NULL, '2026-07-06 14:45:15.235000', NULL, NULL, '2026-07-06 14:45:15.235000', 2, 63, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"[\\\"宗教信仰\\\"]\",\"questionId\":13,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (83, NULL, '2026-07-06 14:45:16.045000', NULL, NULL, '2026-07-06 14:45:16.045000', 2, 53, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"12\",\"questionId\":14,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (84, NULL, '2026-07-06 14:45:20.663000', NULL, NULL, '2026-07-06 14:45:20.663000', 2, 71, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":15,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (85, NULL, '2026-07-06 14:45:21.613000', NULL, NULL, '2026-07-06 14:45:21.613000', 2, 79, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":16,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (86, NULL, '2026-07-06 14:45:22.160000', NULL, NULL, '2026-07-06 14:45:22.160000', 2, 134, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":17,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (87, NULL, '2026-07-06 14:45:23.597000', NULL, NULL, '2026-07-06 14:45:23.597000', 2, 120, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":18,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (88, NULL, '2026-07-06 14:45:27.151000', NULL, NULL, '2026-07-06 14:45:27.151000', 2, 74, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"11\",\"questionId\":19,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (89, NULL, '2026-07-06 14:45:28.806000', NULL, NULL, '2026-07-06 14:45:28.806000', 2, 58, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"[\\\"员工培训\\\"]\",\"questionId\":20,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (90, NULL, '2026-07-06 14:45:29.976000', NULL, NULL, '2026-07-06 14:45:29.976000', 2, 162, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":21,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (91, NULL, '2026-07-06 14:45:30.612000', NULL, NULL, '2026-07-06 14:45:30.612000', 2, 55, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"不适用\",\"questionId\":22,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (92, NULL, '2026-07-06 14:45:32.743000', NULL, NULL, '2026-07-06 14:45:32.743000', 2, 83, '研发部门', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"assessorIds\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 13:23:15\",\"distributeTime\":\"2026-07-06 13:23:15\",\"dueDate\":\"2026-07-31\",\"id\":2,\"operUserId\":1,\"respondentEmail\":\"1122@qq.com\",\"respondentName\":\"小明\",\"respondentUserId\":3,\"status\":\"FILLING\",\"templateId\":1,\"title\":\"个人信息保护法合规自评问卷\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 13:23:15\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.saveAnswers()', '127.0.0.1', '', 'xiaoming', '2 [{\"answerValue\":\"2026-07-24\",\"questionId\":23,\"remark\":\"\",\"riskFlag\":\"N\"}]', NULL, '/assessment/survey/saveAnswers/2', 'POST', 1, '评估保存');
INSERT INTO `sys_oper_log` VALUES (93, NULL, '2026-07-06 14:47:33.518000', NULL, NULL, '2026-07-06 14:47:33.518000', 1, 51, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createBy\":\"admin\",\"createTime\":\"2026-07-06 14:47:33\",\"handleStatus\":\"PENDING\",\"id\":1,\"level\":\"HIGH\",\"questionId\":2,\"riskDesc\":\"必须整改措施\",\"surveyId\":2,\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:47:33\"}}', 'com.rutong.business.assessment.controller.AsSurveyController.addRiskRecord()', '127.0.0.1', '', 'admin', '{\"surveyId\":2,\"questionId\":2,\"level\":\"HIGH\",\"riskDesc\":\"必须整改措施\"}', NULL, '/assessment/survey/riskRecord', 'POST', 1, '标记风险');
INSERT INTO `sys_oper_log` VALUES (94, NULL, '2026-07-06 14:49:36.601000', NULL, NULL, '2026-07-06 14:49:36.601000', 1, 275, '儒通物联网', NULL, '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"category\":\"数据合规\",\"createBy\":\"admin\",\"createTime\":\"2026-07-06 14:49:36\",\"description\":\"依据《中华人民共和国个人信息保护法》编制的自评问卷，覆盖基本原则、告知同意、敏感信息、主体权利、处理者义务五大领域；展示问卷全部题型组件。\",\"id\":2,\"sourceType\":\"COPY\",\"status\":\"DRAFT\",\"templateName\":\"个人信息保护法合规自评问卷_副本\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-06 14:49:36\"}}', 'com.rutong.business.questionnaire.controller.QmTemplateController.copyFrom()', '127.0.0.1', '', 'admin', '1', NULL, '/questionnaire/template/copyFrom/1', 'POST', 1, '问卷模板');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `data_scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `role_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `role_sort` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '超级管理员', 'admin', '2026-06-09 09:40:56.826000', '1', 'admin', '超级管理员', 1);
INSERT INTO `sys_role` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '普通角色', 'admin', '2026-06-09 09:44:41.000000', '2', 'common', '普通角色', 2);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL,
  `dept_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE,
  INDEX `FKp8ajq80m63s361m1pq3isls5t`(`dept_id` ASC) USING BTREE,
  CONSTRAINT `FKmdoybh4v5t2ooi48m3307n7fx` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKp8ajq80m63s361m1pq3isls5t` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 2);
INSERT INTO `sys_role_dept` VALUES (2, 4);
INSERT INTO `sys_role_dept` VALUES (2, 6);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  INDEX `FKf3mud4qoc7ayew8nml4plkevo`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `FKf3mud4qoc7ayew8nml4plkevo` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKkeitxsgxwayackgqllio4ohn5` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 10000);
INSERT INTO `sys_role_menu` VALUES (2, 10010);
INSERT INTO `sys_role_menu` VALUES (2, 10011);
INSERT INTO `sys_role_menu` VALUES (2, 10012);
INSERT INTO `sys_role_menu` VALUES (2, 10013);
INSERT INTO `sys_role_menu` VALUES (2, 10014);
INSERT INTO `sys_role_menu` VALUES (2, 10015);
INSERT INTO `sys_role_menu` VALUES (2, 10020);
INSERT INTO `sys_role_menu` VALUES (2, 11000);
INSERT INTO `sys_role_menu` VALUES (2, 11010);
INSERT INTO `sys_role_menu` VALUES (2, 11011);
INSERT INTO `sys_role_menu` VALUES (2, 11012);
INSERT INTO `sys_role_menu` VALUES (2, 11013);
INSERT INTO `sys_role_menu` VALUES (2, 11014);
INSERT INTO `sys_role_menu` VALUES (2, 11015);
INSERT INTO `sys_role_menu` VALUES (2, 11030);
INSERT INTO `sys_role_menu` VALUES (2, 13000);
INSERT INTO `sys_role_menu` VALUES (2, 13010);
INSERT INTO `sys_role_menu` VALUES (2, 13011);
INSERT INTO `sys_role_menu` VALUES (2, 13013);
INSERT INTO `sys_role_menu` VALUES (2, 13014);
INSERT INTO `sys_role_menu` VALUES (2, 13020);
INSERT INTO `sys_role_menu` VALUES (2, 13021);
INSERT INTO `sys_role_menu` VALUES (2, 13022);
INSERT INTO `sys_role_menu` VALUES (2, 13023);
INSERT INTO `sys_role_menu` VALUES (2, 13024);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phonenumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `dept_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKb3pkx0wbo6o8i8lj0gxr37v1n`(`dept_id` ASC) USING BTREE,
  CONSTRAINT `FKb3pkx0wbo6o8i8lj0gxr37v1n` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '超级管理员', NULL, NULL, '/profile/avatar/2026/06/09/test_20260609144919A002.jpg', 'admin@rutong.com', '超级管理员', '$2a$10$yIRr6m4sh3ptk3TrL4ZoqOBRKXU/m8MerR.vUV70sg8830s/RrDHu', '15888888888', '1', 'admin', 1);
INSERT INTO `sys_user` VALUES (3, 'admin', '2026-06-08 17:43:36.000000', '测试', 'admin', '2026-06-09 15:54:03.000000', NULL, '1122@qq.com', '小明', '$2a$10$cJ58SY29vNvlDMMJFSEOtus5dYbOM4BzRjNalWl0w3Z4TznZeM5w6', '1102222', '1', 'xiaoming', 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `FKhh52n8vd4ny9ff4x9fb8v65qx`(`role_id` ASC) USING BTREE,
  CONSTRAINT `FKb40xxfch70f5qnyfw8yme1n1s` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKhh52n8vd4ny9ff4x9fb8v65qx` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (3, 2);

SET FOREIGN_KEY_CHECKS = 1;
