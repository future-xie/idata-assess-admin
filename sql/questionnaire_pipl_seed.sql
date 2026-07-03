-- =====================================================================
-- 《个人信息保护法》合规自评问卷  --  数据种子
-- 适配 quick-build-admin（qm_template / qm_chapter / qm_question / qm_question_option）
-- 题型依据 com.rutong.business.questionnaire.constant.QuestionConstants
--   RADIO / CHECKBOX / SELECT / TEXT / DATE / BOOLEAN / UPLOAD
-- 5 章节、24 题，覆盖全部 7 种题型
--   RADIO×9 / CHECKBOX×4 / BOOLEAN×3 / TEXT×4 / DATE×2 / SELECT×1 / UPLOAD×1
-- 用法：source sql/questionnaire_pipl_seed.sql
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1) 模板
INSERT INTO `qm_template`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_name`, `category`, `source_type`, `status`, `description`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   '《个人信息保护法》合规自评问卷（2026）', '数据合规', 'SYSTEM', 'PUBLISHED',
   '依据《中华人民共和国个人信息保护法》及配套规范编制，用于组织内部个人信息保护合规自评。共 5 章节 24 题，覆盖 8 种题型。');

SET @tpl_id = LAST_INSERT_ID();

-- 2) 章节
INSERT INTO `qm_chapter`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_name`, `order_num`, `visible`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL, @tpl_id, '第一章  个人信息处理的基本规则与原则', 1, 'Y'),
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL, @tpl_id, '第二章  个人信息告知与个人同意',       2, 'Y'),
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL, @tpl_id, '第三章  敏感个人信息与跨境、自动化决策', 3, 'Y'),
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL, @tpl_id, '第四章  个人信息主体权利保障',         4, 'Y'),
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL, @tpl_id, '第五章  组织义务与安全事件应急',       5, 'Y');

SET @ch1_id = (SELECT id FROM qm_chapter WHERE template_id = @tpl_id AND order_num = 1);
SET @ch2_id = (SELECT id FROM qm_chapter WHERE template_id = @tpl_id AND order_num = 2);
SET @ch3_id = (SELECT id FROM qm_chapter WHERE template_id = @tpl_id AND order_num = 3);
SET @ch4_id = (SELECT id FROM qm_chapter WHERE template_id = @tpl_id AND order_num = 4);
SET @ch5_id = (SELECT id FROM qm_chapter WHERE template_id = @tpl_id AND order_num = 5);

-- =====================================================================
-- 第一章：5 题  --  RADIO×2 / CHECKBOX×1 / BOOLEAN×1 / TEXT×1
-- =====================================================================

-- Q1
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch1_id, 'RADIO',
   '1. 您所在的组织是否已建立个人信息处理内部管理制度与操作规程？', 'Y', 1);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已建立并执行','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','部分建立','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','尚未建立','C',3);

-- Q2
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch1_id, 'RADIO',
   '2. 组织处理个人信息所依据的合法性基础主要为以下哪一类？', 'Y', 2);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','取得个人同意','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','订立/履行合同必需','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','法定义务或人力资源管理','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','突发公共卫生事件/新闻报道/合法公开范围','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','其他合法基础','E',5);

-- Q3 CHECKBOX
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch1_id, 'CHECKBOX',
   '3. 组织目前处理的个人信息类型包括哪些？（多选）', 'Y', 3);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','姓名/手机号/地址等基本信息','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','身份证/护照/证件号码','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','生物识别（人脸/指纹/声纹）','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','位置/行踪轨迹','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','财产/金融账户信息','E',5),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','14 周岁以下未成年人信息','F',6);

-- Q4 BOOLEAN
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch1_id, 'BOOLEAN',
   '4. 组织是否在产品/服务的各项功能中均遵循“最小必要”原则（不存在明显过度收集）？', 'Y', 4);

-- Q5 TEXT
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `min_len`, `max_len`, `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch1_id, 'TEXT',
   '5. 请简要说明组织处理个人信息的主要目的、范围与必要性（不少于 50 字）。', 'Y', 5,
   50, 1000, '请简述处理目的、涉及字段及必要性…');

-- =====================================================================
-- 第二章：5 题  --  CHECKBOX×1 / RADIO×2 / BOOLEAN×1 / TEXT×1
-- =====================================================================

-- Q6 CHECKBOX
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch2_id, 'CHECKBOX',
   '6. 组织在收集个人信息前向个人告知的方式包括哪些？（多选）', 'Y', 1);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','弹窗/页面单独告知','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','隐私政策/个人信息处理规则','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','短信/邮件单独通知','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','客服/销售人员口头告知','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未实质告知','E',5);

-- Q7 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch2_id, 'RADIO',
   '7. 组织主要通过何种方式取得个人的同意？', 'Y', 2);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','勾选框主动勾选','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','签署书面/电子协议','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','默认勾选（不推荐）','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未取得同意','D',4);

-- Q8 BOOLEAN
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch2_id, 'BOOLEAN',
   '8. 是否提供便捷的“撤回同意”机制，且撤回不影响撤回前已进行的处理？', 'Y', 3);

-- Q9 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch2_id, 'RADIO',
   '9. 对于需取得“单独同意”的场景（敏感个人信息、跨境、公开等），组织如何落实？', 'Y', 4);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已逐项单独弹窗确认','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','合并在隐私政策中','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未区分','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','不涉及单独同意场景','D',4);

-- Q10 TEXT
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `min_len`, `max_len`, `regex`, `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch2_id, 'TEXT',
   '10. 请填写贵组织的全称（将与《个人信息处理规则》签署主体一致）。', 'Y', 5,
   2, 100, '^[\u4e00-\u9fa5A-Za-z0-9()（）·.\-]{2,100}$', '如：某某科技有限公司');

-- =====================================================================
-- 第三章：5 题  --  RADIO×2 / CHECKBOX×1 / DATE×1 / TEXT×1
-- =====================================================================

-- Q11 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch3_id, 'RADIO',
   '11. 组织是否处理敏感个人信息？', 'Y', 1);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','是','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','否','B',2);

-- Q12 CHECKBOX
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch3_id, 'CHECKBOX',
   '12. 若处理敏感个人信息，涉及的类型有？（多选；未涉及请勾选“不涉及”）', 'Y', 2);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','生物识别信息','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','宗教信仰/特定身份','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','医疗健康信息','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','金融账户/行踪轨迹','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','14 周岁以下未成年人信息','E',5),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','不涉及','F',6);

-- Q13 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch3_id, 'RADIO',
   '13. 若涉及跨境传输，是否已通过安全评估/标准合同/保护认证之一？', 'Y', 3);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','国家网信部门安全评估','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','标准合同备案','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','个人信息保护认证','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未开展','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','不涉及','E',5);

-- Q14 DATE
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch3_id, 'DATE',
   '14. 请选择完成最近一次跨境/敏感个人信息合规评估的日期（如未开展请留空）。', 'N', 4,
   '请选择日期');

-- Q15 TEXT
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `min_len`, `max_len`, `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch3_id, 'TEXT',
   '15. 自动化决策（如用户画像、个性化推荐）已采取哪些透明度与可解释性措施？', 'Y', 5,
   30, 1000, '如：决策说明、便捷拒绝机制、替代方案…');

-- =====================================================================
-- 第四章：4 题  --  RADIO×2 / CHECKBOX×1 / TEXT×1
-- =====================================================================

-- Q16 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch4_id, 'RADIO',
   '16. 是否向个人提供便捷的查阅、复制其个人信息的途径？', 'Y', 1);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已提供（线上/线下）','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','部分提供','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未提供','C',3);

-- Q17 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch4_id, 'RADIO',
   '17. 是否在处理敏感个人信息/自动化决策/对外提供等场景开展过个人信息保护影响评估（PIA）？', 'Y', 2);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已开展并留档','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','部分开展','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未开展','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','不涉及','D',4);

-- Q18 CHECKBOX
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch4_id, 'CHECKBOX',
   '18. 已建立的个人信息主体权利响应机制包括哪些？（多选）', 'Y', 3);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','15 日内响应时限','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','专门处理流程与责任人','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','多渠道受理（电话/在线/邮件）','C',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','提供书面/电子化回复','D',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','撤回同意便捷机制','E',5);

-- Q19 TEXT
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `min_len`, `max_len`, `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch4_id, 'TEXT',
   '19. 接到个人投诉或权利请求后，组织的处理流程与平均响应时长是？', 'Y', 4,
   30, 1000, '请简述：受理→核实→处理→反馈 各环节…');

-- =====================================================================
-- 第五章：5 题  --  RADIO×2 / BOOLEAN×1 / SELECT×1 / UPLOAD×1 / DATE×1
-- =====================================================================

-- Q20 RADIO
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch5_id, 'RADIO',
   '20. 是否已指定个人信息保护负责人并向监管部门报送/公开？', 'Y', 1);
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已指定并公开','A',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','已指定但未公开','B',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','未指定','C',3);

-- Q21 BOOLEAN
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch5_id, 'BOOLEAN',
   '21. 是否已建立个人信息安全事件应急预案并定期开展演练？', 'Y', 2);

-- Q22 SELECT
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch5_id, 'SELECT',
   '22. 内部人员个人信息保护培训的体系化程度（1=几乎未开展，5=系统化定期开展）', 'Y', 3,
   '请选择成熟度');
SET @q = LAST_INSERT_ID();
INSERT INTO `qm_question_option` (`create_by`,`create_time`,`question_id`,`opt_type`,`opt_label`,`opt_value`,`order_num`) VALUES
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','1（几乎未开展）','1',1),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','2','2',2),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','3','3',3),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','4','4',4),
 ('admin','2026-07-01 00:00:00.000000',@q,'OPTION','5（系统化定期开展）','5',5);

-- Q23 UPLOAD  --  上传合规制度文件
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `max_count`, `max_size`, `accept`, `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch5_id, 'UPLOAD',
   '23. 请上传《个人信息保护管理制度》《隐私政策》等合规制度文件（最多 5 份）。', 'N', 4,
   5, 20971520, '.pdf,.doc,.docx,.zip', '支持 PDF/Word/ZIP，单文件不超过 20MB');

-- Q24 DATE
INSERT INTO `qm_question`
  (`create_by`, `create_time`, `update_by`, `update_time`,
   `template_id`, `chapter_id`, `question_type`, `title`, `required`, `order_num`,
   `placeholder`)
VALUES
  ('admin', '2026-07-01 00:00:00.000000', NULL, NULL,
   @tpl_id, @ch5_id, 'DATE',
   '24. 请选择上一次完成个人信息保护合规自评的日期（如尚未开展请留空）。', 'N', 5,
   '请选择日期');

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- 验证 SQL
--   SELECT c.chapter_name 章节, q.order_num 序号, q.question_type 题型, q.title 题干
--     FROM qm_template t
--     JOIN qm_chapter  c ON c.template_id = t.id
--     JOIN qm_question q ON q.chapter_id  = c.id
--    WHERE t.id = @tpl_id
--    ORDER BY c.order_num, q.order_num;
-- 题型统计
--   SELECT question_type, COUNT(*) FROM qm_question WHERE template_id = @tpl_id GROUP BY question_type;
-- =====================================================================
