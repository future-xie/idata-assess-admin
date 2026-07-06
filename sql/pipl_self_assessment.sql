-- =====================================================================
-- 个人信息保护法（PIPL）合规自评问卷 —— 初始化导入
-- 5 章节 24 题；覆盖全部 8 种题型：DESCRIPTION / RADIO / CHECKBOX / SELECT
--   / TEXT / DATE / BOOLEAN / UPLOAD，每种至少一题。
--
-- 用法：在 assess_admin 库直接执行（MySQL CLI / Navicat 均可）。
-- 幂等：模板按 template_name、章节按 (template_id, chapter_name)、题目按
--       (chapter_id, title) 去重；选项「先删后插」，可重复执行。
-- 导入后即为 PUBLISHED 状态，可直接分发评估。
-- 选项约定：opt_value = opt_label（前端以 label 作为存值，便于风险规则按中文取值）。
-- =====================================================================

-- ---------- 模板 ----------
INSERT INTO qm_template (template_name, category, source_type, status, description, create_by, create_time)
SELECT '个人信息保护法合规自评问卷', '数据合规', 'TEMPLATE', 'PUBLISHED',
       '依据《中华人民共和国个人信息保护法》编制的自评问卷，覆盖基本原则、告知同意、敏感信息、主体权利、处理者义务五大领域；展示问卷全部题型组件。',
       'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_template WHERE template_name = '个人信息保护法合规自评问卷');
SET @tid := (SELECT id FROM qm_template WHERE template_name = '个人信息保护法合规自评问卷' LIMIT 1);


-- ===================================================================
-- 一、基本原则与处理依据（DESCRIPTION + RADIO）
-- ===================================================================
INSERT INTO qm_chapter (template_id, chapter_name, order_num, visible, create_by, create_time)
SELECT @tid, '一、基本原则与处理依据', 1, 'Y', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_chapter WHERE template_id=@tid AND chapter_name='一、基本原则与处理依据');
SET @c1 := (SELECT id FROM qm_chapter WHERE template_id=@tid AND chapter_name='一、基本原则与处理依据' LIMIT 1);

-- 1-1 DESCRIPTION：填写说明（信息块，不参与作答）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c1, 'DESCRIPTION',
       '本问卷依据《中华人民共和国个人信息保护法》编制，用于自查个人信息处理合规情况。<br/>选项中：<b>已落实 / 部分落实 / 未落实</b> 对应贵单位当前落实程度，<b>不适用</b> 用于与业务无关的条款。请据实作答。',
       'N', 1, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c1 AND title LIKE '本问卷依据《中华人民共和国个人信息保护法》编制%');

-- 1-2 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c1, 'RADIO', '处理个人信息是否具备合法事由（同意、订立或履行合同所必需、履行法定职责或义务等），并遵循合法、正当、必要、诚信原则？', 'Y', 2, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c1 AND title='处理个人信息是否具备合法事由（同意、订立或履行合同所必需、履行法定职责或义务等），并遵循合法、正当、必要、诚信原则？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c1 AND title='处理个人信息是否具备合法事由（同意、订立或履行合同所必需、履行法定职责或义务等），并遵循合法、正当、必要、诚信原则？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 1-3 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c1, 'RADIO', '收集个人信息是否遵循“最小必要”原则，未超出处理目的所必需的范围与频次？', 'Y', 3, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c1 AND title='收集个人信息是否遵循“最小必要”原则，未超出处理目的所必需的范围与频次？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c1 AND title='收集个人信息是否遵循“最小必要”原则，未超出处理目的所必需的范围与频次？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 1-4 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c1, 'RADIO', '是否已建立个人信息分类分级机制，准确识别并区分敏感个人信息？', 'Y', 4, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c1 AND title='是否已建立个人信息分类分级机制，准确识别并区分敏感个人信息？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c1 AND title='是否已建立个人信息分类分级机制，准确识别并区分敏感个人信息？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 1-5 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c1, 'RADIO', '是否明确各项个人信息处理活动的目的，并确保处理方式与该目的直接相关？', 'Y', 5, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c1 AND title='是否明确各项个人信息处理活动的目的，并确保处理方式与该目的直接相关？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c1 AND title='是否明确各项个人信息处理活动的目的，并确保处理方式与该目的直接相关？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());


-- ===================================================================
-- 二、告知与同意（RADIO + CHECKBOX + SELECT + BOOLEAN）
-- ===================================================================
INSERT INTO qm_chapter (template_id, chapter_name, order_num, visible, create_by, create_time)
SELECT @tid, '二、告知与同意', 2, 'Y', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_chapter WHERE template_id=@tid AND chapter_name='二、告知与同意');
SET @c2 := (SELECT id FROM qm_chapter WHERE template_id=@tid AND chapter_name='二、告知与同意' LIMIT 1);

-- 2-1 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c2, 'RADIO', '收集个人信息前，是否以显著方式、清晰易懂的语言向个人告知处理者身份、目的、方式、种类、保存期限及行使权利的方式？', 'Y', 1, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c2 AND title='收集个人信息前，是否以显著方式、清晰易懂的语言向个人告知处理者身份、目的、方式、种类、保存期限及行使权利的方式？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c2 AND title='收集个人信息前，是否以显著方式、清晰易懂的语言向个人告知处理者身份、目的、方式、种类、保存期限及行使权利的方式？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 2-2 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c2, 'RADIO', '取得个人同意时，是否确保其在充分知情前提下自愿、明确作出，未以误导、欺诈、胁迫等方式获取？', 'Y', 2, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c2 AND title='取得个人同意时，是否确保其在充分知情前提下自愿、明确作出，未以误导、欺诈、胁迫等方式获取？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c2 AND title='取得个人同意时，是否确保其在充分知情前提下自愿、明确作出，未以误导、欺诈、胁迫等方式获取？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 2-3 CHECKBOX：获取同意采取的方式（多选）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c2, 'CHECKBOX', '获取个人同意时，主要采取了以下哪些方式？（多选）', 'Y', 3, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c2 AND title='获取个人同意时，主要采取了以下哪些方式？（多选）');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c2 AND title='获取个人同意时，主要采取了以下哪些方式？（多选）' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','弹窗告知','弹窗告知',1,'admin',NOW()),(@q,'OPTION','独立同意页','独立同意页',2,'admin',NOW()),(@q,'OPTION','书面签署','书面签署',3,'admin',NOW()),(@q,'OPTION','短信或邮件确认','短信或邮件确认',4,'admin',NOW()),(@q,'OPTION','其他','其他',5,'admin',NOW());

-- 2-4 SELECT：隐私政策公布渠道（下拉单选）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c2, 'SELECT', '贵单位的个人信息处理规则（隐私政策）主要通过哪种渠道向个人公示？', 'Y', 4, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c2 AND title='贵单位的个人信息处理规则（隐私政策）主要通过哪种渠道向个人公示？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c2 AND title='贵单位的个人信息处理规则（隐私政策）主要通过哪种渠道向个人公示？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','官方网站公示','官方网站公示',1,'admin',NOW()),(@q,'OPTION','App 或小程序内嵌','App 或小程序内嵌',2,'admin',NOW()),(@q,'OPTION','首次使用时弹窗','首次使用时弹窗',3,'admin',NOW()),(@q,'OPTION','纸质告知','纸质告知',4,'admin',NOW()),(@q,'OPTION','尚未公示','尚未公示',5,'admin',NOW());

-- 2-5 BOOLEAN：是否提供便捷撤回同意方式（是/否，前端内置选项无需入库）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c2, 'BOOLEAN', '是否为个人提供了便捷的撤回同意方式，且撤回不影响此前基于同意的处理？', 'Y', 5, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c2 AND title='是否为个人提供了便捷的撤回同意方式，且撤回不影响此前基于同意的处理？');


-- ===================================================================
-- 三、敏感个人信息处理（RADIO + CHECKBOX + TEXT）
-- ===================================================================
INSERT INTO qm_chapter (template_id, chapter_name, order_num, visible, create_by, create_time)
SELECT @tid, '三、敏感个人信息处理', 3, 'Y', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_chapter WHERE template_id=@tid AND chapter_name='三、敏感个人信息处理');
SET @c3 := (SELECT id FROM qm_chapter WHERE template_id=@tid AND chapter_name='三、敏感个人信息处理' LIMIT 1);

-- 3-1 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c3, 'RADIO', '处理敏感个人信息（生物识别、宗教信仰、特定身份、医疗健康、金融账户、行踪轨迹，以及不满14周岁未成年人信息等）是否取得了单独同意？', 'Y', 1, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c3 AND title='处理敏感个人信息（生物识别、宗教信仰、特定身份、医疗健康、金融账户、行踪轨迹，以及不满14周岁未成年人信息等）是否取得了单独同意？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c3 AND title='处理敏感个人信息（生物识别、宗教信仰、特定身份、医疗健康、金融账户、行踪轨迹，以及不满14周岁未成年人信息等）是否取得了单独同意？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 3-2 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c3, 'RADIO', '处理敏感个人信息是否具有特定的目的和充分的必要性，并在严格保护措施下进行？', 'Y', 2, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c3 AND title='处理敏感个人信息是否具有特定的目的和充分的必要性，并在严格保护措施下进行？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c3 AND title='处理敏感个人信息是否具有特定的目的和充分的必要性，并在严格保护措施下进行？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 3-3 CHECKBOX：处理的敏感信息类型（多选）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c3, 'CHECKBOX', '贵单位处理哪些类型的敏感个人信息？（多选）', 'Y', 3, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c3 AND title='贵单位处理哪些类型的敏感个人信息？（多选）');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c3 AND title='贵单位处理哪些类型的敏感个人信息？（多选）' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','生物识别信息','生物识别信息',1,'admin',NOW()),(@q,'OPTION','宗教信仰','宗教信仰',2,'admin',NOW()),(@q,'OPTION','特定身份','特定身份',3,'admin',NOW()),(@q,'OPTION','医疗健康','医疗健康',4,'admin',NOW()),(@q,'OPTION','金融账户','金融账户',5,'admin',NOW()),(@q,'OPTION','行踪轨迹','行踪轨迹',6,'admin',NOW()),(@q,'OPTION','不满14周岁未成年人信息','不满14周岁未成年人信息',7,'admin',NOW());

-- 3-4 TEXT：数据出境目的地（单行富文本，placeholder）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, placeholder, required, order_num, create_by, create_time)
SELECT @tid, @c3, 'TEXT', '如存在个人信息出境，请填写目的地国家或地区（无出境请填“无”）。',
       '例如：美国、新加坡、中国香港；无则填“无”', 'Y', 4, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c3 AND title='如存在个人信息出境，请填写目的地国家或地区（无出境请填“无”）。');


-- ===================================================================
-- 四、个人信息主体权利（RADIO + TEXT）
-- ===================================================================
INSERT INTO qm_chapter (template_id, chapter_name, order_num, visible, create_by, create_time)
SELECT @tid, '四、个人信息主体权利', 4, 'Y', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_chapter WHERE template_id=@tid AND chapter_name='四、个人信息主体权利');
SET @c4 := (SELECT id FROM qm_chapter WHERE template_id=@tid AND chapter_name='四、个人信息主体权利' LIMIT 1);

-- 4-1 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c4, 'RADIO', '是否建立了便捷的渠道，供个人查询、复制其个人信息？', 'Y', 1, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c4 AND title='是否建立了便捷的渠道，供个人查询、复制其个人信息？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c4 AND title='是否建立了便捷的渠道，供个人查询、复制其个人信息？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 4-2 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c4, 'RADIO', '个人信息存在错误或不完整时，是否支持个人提出更正、补充请求并及时处理？', 'Y', 2, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c4 AND title='个人信息存在错误或不完整时，是否支持个人提出更正、补充请求并及时处理？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c4 AND title='个人信息存在错误或不完整时，是否支持个人提出更正、补充请求并及时处理？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 4-3 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c4, 'RADIO', '是否支持个人请求删除个人信息（处理目的已实现、约定期限届满、同意已撤回、违规处理等情形）？', 'Y', 3, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c4 AND title='是否支持个人请求删除个人信息（处理目的已实现、约定期限届满、同意已撤回、违规处理等情形）？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c4 AND title='是否支持个人请求删除个人信息（处理目的已实现、约定期限届满、同意已撤回、违规处理等情形）？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 4-4 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c4, 'RADIO', '收到个人行使权利的请求后，是否在15个工作日内予以答复处理？', 'Y', 4, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c4 AND title='收到个人行使权利的请求后，是否在15个工作日内予以答复处理？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c4 AND title='收到个人行使权利的请求后，是否在15个工作日内予以答复处理？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 4-5 TEXT：DPO 联系方式（单行富文本，placeholder）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, placeholder, required, order_num, create_by, create_time)
SELECT @tid, @c4, 'TEXT', '个人信息保护负责人（DPO）的联系方式（电话或邮箱）。',
       '例如：0571-xxxxxxxx / privacy@company.com', 'Y', 5, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c4 AND title='个人信息保护负责人（DPO）的联系方式（电话或邮箱）。');


-- ===================================================================
-- 五、处理者义务与安全保护（CHECKBOX + RADIO + DATE + UPLOAD）
-- ===================================================================
INSERT INTO qm_chapter (template_id, chapter_name, order_num, visible, create_by, create_time)
SELECT @tid, '五、处理者义务与安全保护', 5, 'Y', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_chapter WHERE template_id=@tid AND chapter_name='五、处理者义务与安全保护');
SET @c5 := (SELECT id FROM qm_chapter WHERE template_id=@tid AND chapter_name='五、处理者义务与安全保护' LIMIT 1);

-- 5-1 CHECKBOX：已采取的安全保护措施（多选）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c5, 'CHECKBOX', '贵单位已采取了以下哪些个人信息安全保护措施？（多选）', 'Y', 1, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c5 AND title='贵单位已采取了以下哪些个人信息安全保护措施？（多选）');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c5 AND title='贵单位已采取了以下哪些个人信息安全保护措施？（多选）' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','加密','加密',1,'admin',NOW()),(@q,'OPTION','去标识化','去标识化',2,'admin',NOW()),(@q,'OPTION','访问权限控制','访问权限控制',3,'admin',NOW()),(@q,'OPTION','安全审计','安全审计',4,'admin',NOW()),(@q,'OPTION','员工培训','员工培训',5,'admin',NOW()),(@q,'OPTION','应急演练','应急演练',6,'admin',NOW());

-- 5-2 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c5, 'RADIO', '针对敏感信息处理、自动化决策、对外提供或公开、跨境提供等场景，是否开展了个人信息保护影响评估（PIA）并形成处理情况记录？', 'Y', 2, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c5 AND title='针对敏感信息处理、自动化决策、对外提供或公开、跨境提供等场景，是否开展了个人信息保护影响评估（PIA）并形成处理情况记录？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c5 AND title='针对敏感信息处理、自动化决策、对外提供或公开、跨境提供等场景，是否开展了个人信息保护影响评估（PIA）并形成处理情况记录？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 5-3 RADIO
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c5, 'RADIO', '是否建立个人信息安全事件应急预案，发生或可能发生泄露、篡改、丢失时按规定通知个人并报告监管部门？', 'Y', 3, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c5 AND title='是否建立个人信息安全事件应急预案，发生或可能发生泄露、篡改、丢失时按规定通知个人并报告监管部门？');
SET @q := (SELECT id FROM qm_question WHERE chapter_id=@c5 AND title='是否建立个人信息安全事件应急预案，发生或可能发生泄露、篡改、丢失时按规定通知个人并报告监管部门？' LIMIT 1);
DELETE FROM qm_question_option WHERE question_id=@q;
INSERT INTO qm_question_option (question_id, opt_type, opt_label, opt_value, order_num, create_by, create_time) VALUES
 (@q,'OPTION','已落实','已落实',1,'admin',NOW()),(@q,'OPTION','部分落实','部分落实',2,'admin',NOW()),(@q,'OPTION','未落实','未落实',3,'admin',NOW()),(@q,'OPTION','不适用','不适用',4,'admin',NOW());

-- 5-4 DATE：制度最近修订日期（日期选择，非必填）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, required, order_num, create_by, create_time)
SELECT @tid, @c5, 'DATE', '贵单位个人信息保护制度（或隐私政策）最近一次修订日期。', 'N', 4, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c5 AND title='贵单位个人信息保护制度（或隐私政策）最近一次修订日期。');

-- 5-5 UPLOAD：上传制度/PIA 文件（max_count=5，max_size=10MB）
INSERT INTO qm_question (template_id, chapter_id, question_type, title, max_count, max_size, accept, required, order_num, create_by, create_time)
SELECT @tid, @c5, 'UPLOAD', '请上传个人信息保护制度文件或最新的个人信息保护影响评估（PIA）报告（可选）。',
       5, 10485760, '.pdf,.doc,.docx,.xls,.xlsx,.png,.jpg,.zip', 'N', 5, 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM qm_question WHERE chapter_id=@c5 AND title='请上传个人信息保护制度文件或最新的个人信息保护影响评估（PIA）报告（可选）。');

-- 完成：模板「个人信息保护法合规自评问卷」已就绪（PUBLISHED），5 章 24 题，覆盖全部题型。
