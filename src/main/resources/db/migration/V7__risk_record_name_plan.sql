-- as_risk_record 增加风险名称、处理计划字段
-- （标记风险时可从风险库带入，或手动填写）
ALTER TABLE `as_risk_record`
  ADD COLUMN `risk_name` varchar(300) NULL DEFAULT NULL COMMENT '风险名称',
  ADD COLUMN `treatment_plan` varchar(1024) NULL DEFAULT NULL COMMENT '处理计划';
