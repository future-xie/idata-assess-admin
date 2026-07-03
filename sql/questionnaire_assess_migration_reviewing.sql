-- 迁移脚本:将历史状态 SUBMITTED 统一改为 REVIEWING(审核中)
-- 原因: 评估提交后的业务语义由"已提交"调整为"审核中"
-- 执行时机: 部署新版本前一次性迁移,迁移完成后应用代码将只使用 REVIEWING
-- 影响范围: as_survey.status

UPDATE as_survey SET status = 'REVIEWING' WHERE status = 'SUBMITTED';
