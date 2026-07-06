package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsRiskProcess;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 风险处理记录 业务层
 */
@Service
public class AsRiskProcessService extends MpBaseService<AsRiskProcess> {

    /** 某风险记录的全部处理记录（按时间正序） */
    public List<AsRiskProcess> listByRiskRecord(Long riskRecordId) {
        return lambdaQuery()
                .eq(AsRiskProcess::getRiskRecordId, riskRecordId)
                .orderByAsc(AsRiskProcess::getCreateTime)
                .list();
    }
}
