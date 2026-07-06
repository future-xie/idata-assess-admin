-- 精简 qm_risk_lib：移除前端不再使用的字段
-- （类别 / 威胁 / 漏洞 / 固有·目标·剩余风险的影响·概率·评分）
ALTER TABLE `qm_risk_lib`
  DROP COLUMN `category`,
  DROP COLUMN `threat`,
  DROP COLUMN `vulnerability`,
  DROP COLUMN `inherent_impact`,
  DROP COLUMN `inherent_probability`,
  DROP COLUMN `inherent_score`,
  DROP COLUMN `target_impact`,
  DROP COLUMN `target_probability`,
  DROP COLUMN `target_score`,
  DROP COLUMN `residual_impact`,
  DROP COLUMN `residual_probability`,
  DROP COLUMN `residual_score`;
