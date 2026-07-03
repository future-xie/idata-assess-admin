/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : base_admin

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 16/06/2026 16:26:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '蓝色 skin-blue、绿色 skin-green', NULL, NULL, 'sys.index.skinName', '主框架页-默认皮肤样式名称', 'Y', 'skin-blue');
INSERT INTO `sys_config` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '初始化密码 123456', NULL, NULL, 'sys.user.initPassword', '用户管理-账号初始密码', 'Y', '123456');
INSERT INTO `sys_config` VALUES (3, 'admin', '2026-06-08 14:05:03.000000', '深色主题theme-dark，浅色主题theme-light', NULL, NULL, 'sys.index.sideTheme', '主框架页-侧边栏主题', 'Y', 'theme-dark');
INSERT INTO `sys_config` VALUES (4, 'admin', '2026-06-08 14:05:03.000000', '是否开启注册用户功能（true开启，false关闭）', 'admin', '2026-06-09 11:39:02.307000', 'sys.account.registerUser', '账号自助-是否开启用户注册功能', 'Y', 'false');
INSERT INTO `sys_config` VALUES (5, 'admin', '2026-06-08 14:05:03.000000', '是否开启验证码功能（true开启，false关闭）', NULL, NULL, 'sys.account.captchaEnabled', '账号自助-验证码开关', 'Y', 'true');
INSERT INTO `sys_config` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '设置登录IP黑名单限制，多个匹配项以;分隔', NULL, NULL, 'sys.login.blackIPList', '用户登录-黑名单列表', 'Y', '');

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKd5ou5hch26i1tk6m8jc4fpirw`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `FKd5ou5hch26i1tk6m8jc4fpirw` FOREIGN KEY (`parent_id`) REFERENCES `sys_dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '儒通物联网', 'admin', '2026-06-09 11:04:42.275000', '儒通物联网', 0, NULL);
INSERT INTO `sys_dept` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '研发部门', NULL, NULL, '研发部门', 1, 1);
INSERT INTO `sys_dept` VALUES (4, 'admin', '2026-06-08 14:05:03.000000', '测试部门', NULL, NULL, '测试部门', 3, 1);
INSERT INTO `sys_dept` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '生产部门', NULL, NULL, '生产部门', 5, 1);
INSERT INTO `sys_dept` VALUES (7, 'admin', '2026-06-09 11:01:57.000000', NULL, 'admin', '2026-06-09 11:02:21.542000', '浩斌信息科技', 2, NULL);
INSERT INTO `sys_dept` VALUES (8, 'admin', '2026-06-09 11:05:11.138000', NULL, NULL, NULL, '销售部门', 5, 1);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `css_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `dict_code` bigint NULL DEFAULT NULL,
  `dict_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `dict_sort` bigint NULL DEFAULT NULL,
  `dict_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `is_default` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `list_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `dict_type_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKe2oxmdurvmj31t8fjlfed6dv5`(`dict_type_id` ASC) USING BTREE,
  CONSTRAINT `FKe2oxmdurvmj31t8fjlfed6dv5` FOREIGN KEY (`dict_type_id`) REFERENCES `sys_dict_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '性别男', NULL, NULL, '', 1, '男', 1, '0', 'Y', '', 1);
INSERT INTO `sys_dict_data` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '性别女', NULL, NULL, '', 2, '女', 2, '1', 'N', 'danger', 1);
INSERT INTO `sys_dict_data` VALUES (3, 'admin', '2026-06-08 14:05:03.000000', '性别未知', NULL, NULL, '', 3, '未知', 3, '2', 'N', 'info', 1);
INSERT INTO `sys_dict_data` VALUES (4, 'admin', '2026-06-08 14:05:03.000000', '显示菜单', NULL, NULL, '', 4, '显示', 1, '0', 'Y', 'primary', 2);
INSERT INTO `sys_dict_data` VALUES (5, 'admin', '2026-06-08 14:05:03.000000', '隐藏菜单', NULL, NULL, '', 5, '隐藏', 2, '1', 'N', 'danger', 2);
INSERT INTO `sys_dict_data` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '正常状态', NULL, NULL, '', 6, '正常', 1, '1', 'Y', 'primary', 3);
INSERT INTO `sys_dict_data` VALUES (7, 'admin', '2026-06-08 14:05:03.000000', '停用状态', NULL, NULL, '', 7, '停用', 2, '0', 'N', 'danger', 3);
INSERT INTO `sys_dict_data` VALUES (10, 'admin', '2026-06-08 14:05:03.000000', '系统是是', NULL, NULL, '', 10, '是', 1, 'Y', 'Y', 'primary', 5);
INSERT INTO `sys_dict_data` VALUES (11, 'admin', '2026-06-08 14:05:03.000000', '系统是否', NULL, NULL, '', 11, '否', 2, 'N', 'N', 'danger', 5);
INSERT INTO `sys_dict_data` VALUES (12, 'admin', '2026-06-08 14:05:03.000000', '通知', NULL, NULL, '', 12, '通知', 1, '1', 'Y', 'primary', 6);
INSERT INTO `sys_dict_data` VALUES (13, 'admin', '2026-06-08 14:05:03.000000', '公告', NULL, NULL, '', 13, '公告', 2, '2', 'N', 'success', 6);
INSERT INTO `sys_dict_data` VALUES (14, 'admin', '2026-06-08 14:05:03.000000', '正常', NULL, NULL, '', 14, '正常', 1, '0', 'Y', 'primary', 7);
INSERT INTO `sys_dict_data` VALUES (15, 'admin', '2026-06-08 14:05:03.000000', '关闭', NULL, NULL, '', 15, '关闭', 2, '1', 'N', 'danger', 7);
INSERT INTO `sys_dict_data` VALUES (16, 'admin', '2026-06-08 14:05:03.000000', '其它操作', NULL, NULL, '', 16, '其它', 1, '0', 'N', 'info', 8);
INSERT INTO `sys_dict_data` VALUES (17, 'admin', '2026-06-08 14:05:03.000000', '新增操作', NULL, NULL, '', 17, '新增', 2, '1', 'N', 'success', 8);
INSERT INTO `sys_dict_data` VALUES (18, 'admin', '2026-06-08 14:05:03.000000', '修改操作', NULL, NULL, '', 18, '修改', 3, '2', 'N', 'primary', 8);
INSERT INTO `sys_dict_data` VALUES (19, 'admin', '2026-06-08 14:05:03.000000', '删除操作', NULL, NULL, '', 19, '删除', 4, '3', 'N', 'danger', 8);
INSERT INTO `sys_dict_data` VALUES (20, 'admin', '2026-06-08 14:05:03.000000', '授权操作', NULL, NULL, '', 20, '授权', 5, '4', 'N', 'primary', 8);
INSERT INTO `sys_dict_data` VALUES (21, 'admin', '2026-06-08 14:05:03.000000', '导出操作', NULL, NULL, '', 21, '导出', 6, '5', 'N', 'warning', 8);
INSERT INTO `sys_dict_data` VALUES (22, 'admin', '2026-06-08 14:05:03.000000', '导入操作', NULL, NULL, '', 22, '导入', 7, '6', 'N', 'warning', 8);
INSERT INTO `sys_dict_data` VALUES (23, 'admin', '2026-06-08 14:05:03.000000', '强退操作', NULL, NULL, '', 23, '强退', 8, '7', 'N', 'danger', 8);
INSERT INTO `sys_dict_data` VALUES (24, 'admin', '2026-06-08 14:05:03.000000', '生成代码操作', NULL, NULL, '', 24, '生成代码', 9, '8', 'N', 'warning', 8);
INSERT INTO `sys_dict_data` VALUES (25, 'admin', '2026-06-08 14:05:03.000000', '清空数据操作', NULL, NULL, '', 25, '清空数据', 10, '9', 'N', 'danger', 8);
INSERT INTO `sys_dict_data` VALUES (26, 'admin', '2026-06-08 14:05:03.000000', '正常状态', 'admin', '2026-06-09 11:33:56.233000', '', 26, '成功', 1, '1', 'Y', 'primary', 9);
INSERT INTO `sys_dict_data` VALUES (27, 'admin', '2026-06-08 14:05:03.000000', '停用状态', 'admin', '2026-06-09 11:33:51.049000', '', 27, '失败', 2, '0', 'N', 'danger', 9);
INSERT INTO `sys_dict_data` VALUES (28, 'admin', '2026-06-08 14:05:03.000000', '全部数据权限', NULL, NULL, '', 28, '全部数据权限', 1, '1', 'Y', '', 10);
INSERT INTO `sys_dict_data` VALUES (29, 'admin', '2026-06-08 14:05:03.000000', '自定义数据权限', NULL, NULL, '', 29, '自定义数据权限', 2, '2', 'N', '', 10);
INSERT INTO `sys_dict_data` VALUES (30, 'admin', '2026-06-08 14:05:03.000000', '本部门数据权限', NULL, NULL, '', 30, '本部门数据权限', 3, '3', 'N', '', 10);
INSERT INTO `sys_dict_data` VALUES (31, 'admin', '2026-06-08 14:05:03.000000', '本部门及以下数据权限', NULL, NULL, '', 31, '本部门及以下权限', 4, '4', 'N', '', 10);
INSERT INTO `sys_dict_data` VALUES (32, 'admin', '2026-06-08 14:05:03.000000', '仅本人数据权限', NULL, NULL, '', 32, '仅本人数据权限', 5, '5', 'N', '', 10);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `dict_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `dict_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', '用户性别列表', NULL, NULL, '用户性别', 'sys_user_sex');
INSERT INTO `sys_dict_type` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '菜单状态列表', NULL, NULL, '菜单状态', 'sys_show_hide');
INSERT INTO `sys_dict_type` VALUES (3, 'admin', '2026-06-08 14:05:03.000000', '系统开关列表', NULL, NULL, '系统开关', 'sys_normal_disable');
INSERT INTO `sys_dict_type` VALUES (5, 'admin', '2026-06-08 14:05:03.000000', '系统是否列表', NULL, NULL, '系统是否', 'sys_yes_no');
INSERT INTO `sys_dict_type` VALUES (6, 'admin', '2026-06-08 14:05:03.000000', '通知类型列表', NULL, NULL, '通知类型', 'sys_notice_type');
INSERT INTO `sys_dict_type` VALUES (7, 'admin', '2026-06-08 14:05:03.000000', '通知状态列表', NULL, NULL, '通知状态', 'sys_notice_status');
INSERT INTO `sys_dict_type` VALUES (8, 'admin', '2026-06-08 14:05:03.000000', '操作类型列表', NULL, NULL, '操作类型', 'sys_oper_type');
INSERT INTO `sys_dict_type` VALUES (9, 'admin', '2026-06-08 14:05:03.000000', '系统操作状态列表', 'admin', '2026-06-09 11:32:00.235000', '系统状态', 'sys_common_status');
INSERT INTO `sys_dict_type` VALUES (10, 'admin', '2026-06-08 14:05:03.000000', '数据范围列表', NULL, NULL, '数据范围', 'sys_data_scope');

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
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
  INDEX `FK2jrf4gb0gjqi8882gxytpxnhe`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `FK2jrf4gb0gjqi8882gxytpxnhe` FOREIGN KEY (`parent_id`) REFERENCES `sys_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9044 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 'admin', '2026-06-08 14:05:03.000000', NULL, 'admin', '2026-06-09 09:59:13.438000', NULL, 'Setting', '0', '0', '系统管理', 'M', 1, 'system', '', NULL, '', '1', NULL);
INSERT INTO `sys_menu` VALUES (100, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/user/index', 'user', '1', '0', '用户管理', 'C', 1, 'user', 'system:user:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (101, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/role/index', 'user-filled', '1', '0', '角色管理', 'C', 2, 'role', 'system:role:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (102, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/menu/index', 'menu', '1', '0', '菜单管理', 'C', 3, 'menu', 'system:menu:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (103, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/dept/index', 'office-building', '1', '0', '部门管理', 'C', 4, 'dept', 'system:dept:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (104, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/dict/index', 'collection', '1', '0', '字典管理', 'C', 5, 'dict', 'system:dict:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (105, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/config/index', 'setting', '1', '0', '参数设置', 'C', 6, 'config', 'system:config:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (106, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, 'system/operlog/index', 'document', '1', '0', '操作日志', 'C', 7, 'operlog', 'system:operlog:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (107, 'admin', '2026-06-08 14:05:03.000000', NULL, 'admin', '2026-06-09 10:08:34.544000', 'system/logininfor/index', 'list', '1', '0', '登录日志', 'C', 8, 'logininfor', 'system:logininfor:list', NULL, '', '1', 1);
INSERT INTO `sys_menu` VALUES (1000, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '用户查询', 'F', 1, '', 'system:user:query', NULL, '', '1', 100);
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
INSERT INTO `sys_menu` VALUES (1017, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '字典查询', 'F', 1, '', 'system:dict:query', NULL, '', '1', 104);
INSERT INTO `sys_menu` VALUES (1018, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '字典新增', 'F', 2, '', 'system:dict:add', NULL, '', '1', 104);
INSERT INTO `sys_menu` VALUES (1019, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '字典修改', 'F', 3, '', 'system:dict:edit', NULL, '', '1', 104);
INSERT INTO `sys_menu` VALUES (1020, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '字典删除', 'F', 4, '', 'system:dict:remove', NULL, '', '1', 104);
INSERT INTO `sys_menu` VALUES (1021, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数查询', 'F', 1, '', 'system:config:query', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1022, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数新增', 'F', 2, '', 'system:config:add', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1023, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数修改', 'F', 3, '', 'system:config:edit', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1024, 'admin', '2026-06-08 14:05:03.000000', NULL, NULL, NULL, NULL, '', '1', '0', '参数删除', 'F', 4, '', 'system:config:remove', NULL, '', '1', 105);
INSERT INTO `sys_menu` VALUES (1025, 'admin', '2026-06-09 10:09:08.473000', NULL, NULL, NULL, NULL, NULL, '1', '0', '删除', 'F', 1, NULL, NULL, NULL, NULL, '1', 107);
INSERT INTO `sys_menu` VALUES (1027, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '登录查询', 'F', 1, '', 'system:logininfor:query', NULL, '', '1', 107);
INSERT INTO `sys_menu` VALUES (1028, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '登录删除', 'F', 2, '', 'system:logininfor:remove', NULL, '', '1', 107);
INSERT INTO `sys_menu` VALUES (1029, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '操作查询', 'F', 1, '', 'system:operlog:query', NULL, '', '1', 106);
INSERT INTO `sys_menu` VALUES (1030, 'admin', '2026-06-09 16:46:15.000000', NULL, NULL, NULL, NULL, '', '0', '1', '操作删除', 'F', 2, '', 'system:operlog:remove', NULL, '', '1', 106);

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
  `error_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_role` VALUES (2, 'admin', '2026-06-08 14:05:03.000000', '普通角色', 'admin', '2026-06-09 09:44:41.186000', '2', 'common', '普通角色', 2);

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
INSERT INTO `sys_role_dept` VALUES (2, 4);

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
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);

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
INSERT INTO `sys_user` VALUES (3, 'admin', '2026-06-08 17:43:36.000000', '测试', 'admin', '2026-06-09 15:54:03.668000', NULL, '1122@qq.com', '小明', '$2a$10$cJ58SY29vNvlDMMJFSEOtus5dYbOM4BzRjNalWl0w3Z4TznZeM5w6', '1102222', '1', 'xiaoming', 2);

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
