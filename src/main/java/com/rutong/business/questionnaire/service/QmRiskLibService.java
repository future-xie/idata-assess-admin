package com.rutong.business.questionnaire.service;

import com.rutong.business.questionnaire.entity.QmRiskLib;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;

/**
 * 风险库 业务层。仅保留：风险名称 / 等级 / 描述 / 处理计划。
 * 等级由前端直接选择提交，不再由评分推导。
 */
@Service
public class QmRiskLibService extends MpBaseService<QmRiskLib> {
}
