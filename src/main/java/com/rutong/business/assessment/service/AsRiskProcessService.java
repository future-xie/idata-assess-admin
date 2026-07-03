package com.rutong.business.assessment.service;

import com.rutong.business.assessment.entity.AsRiskProcess;
import com.rutong.business.common.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 风险处理记录 业务层
 */
@Service
public class AsRiskProcessService extends BaseService<AsRiskProcess> {

    /** 某风险记录的全部处理记录（按时间正序） */
    public List<AsRiskProcess> listByRiskRecord(Long riskRecordId) {
        String hql = "from AsRiskProcess where riskRecordId = ?1 order by createTime asc";
        return dao.executeHqlQuery(AsRiskProcess.class, hql, riskRecordId);
    }
}
