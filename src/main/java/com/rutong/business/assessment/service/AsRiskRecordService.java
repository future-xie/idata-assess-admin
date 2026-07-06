package com.rutong.business.assessment.service;

import com.rutong.business.assessment.constant.AssessConstants;
import com.rutong.business.assessment.entity.AsRiskProcess;
import com.rutong.business.assessment.entity.AsRiskRecord;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.service.MpBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 风险记录 业务层(评估题目维度)
 */
@Service
public class AsRiskRecordService extends MpBaseService<AsRiskRecord> {

    @Autowired
    private AsRiskProcessService processService;

    /** @Lazy 打破与 AsSurveyService 的循环依赖（AsSurveyService 注入了本类） */
    @Lazy
    @Autowired
    private AsSurveyService surveyService;

    /**
     * 查询某评估实例下某题的所有风险记录(按创建时间倒序)
     */
    public List<AsRiskRecord> listByQuestion(Long surveyId, Long questionId) {
        return lambdaQuery()
                .eq(AsRiskRecord::getSurveyId, surveyId)
                .eq(AsRiskRecord::getQuestionId, questionId)
                .orderByDesc(AsRiskRecord::getCreateTime)
                .list();
    }

    /** 统计某评估实例下每题的风险记录数(返回 qid -> count) */
    public Map<Long, Long> countByQuestion(Long surveyId) {
        List<AsRiskRecord> all = lambdaQuery().eq(AsRiskRecord::getSurveyId, surveyId).list();
        Map<Long, Long> result = new HashMap<>();
        for (AsRiskRecord r : all) {
            if (r.getQuestionId() == null) continue;
            result.merge(r.getQuestionId(), 1L, Long::sum);
        }
        return result;
    }

    /**
     * 创建一条风险记录(由前端"标记风险"弹窗调用)
     * @param surveyId 评估实例 ID
     * @param questionId 题目 ID
     * @param level 风险等级 HIGH/MID/LOW
     * @param riskDesc 风险描述
     */
    public AsRiskRecord create(Long surveyId, Long questionId, String level, String riskDesc,
                               String riskName, String treatmentPlan) {
        AsRiskRecord r = new AsRiskRecord();
        r.setSurveyId(surveyId);
        r.setQuestionId(questionId);
        r.setRiskName(riskName);
        r.setLevel(level);
        r.setRiskDesc(riskDesc);
        r.setTreatmentPlan(treatmentPlan);
        r.setHandleStatus("PENDING");
        insert(r);
        return r;
    }

    /**
     * 处理人(受访人)提交处理记录（文字+附件）。写操作置于同一事务，保证
     * 处理记录插入与状态更新的原子性。
     */
    @Transactional(rollbackFor = Exception.class)
    public AsRiskProcess submitProcess(AsRiskProcess body) {
        if (body.getRiskRecordId() == null) {
            throw new ServiceException("riskRecordId 不能为空");
        }
        AsRiskRecord r = findById(body.getRiskRecordId());
        if (r == null) {
            throw new ServiceException("风险记录不存在");
        }
        if (!surveyService.isRespondent(r.getSurveyId())) {
            throw new ServiceException("仅受访人可提交处理记录");
        }
        if (AssessConstants.PROCESS_STATUS_RECTIFIED.equals(r.getProcessStatus())
                || AssessConstants.PROCESS_STATUS_UNRECTIFIED.equals(r.getProcessStatus())) {
            throw new ServiceException("该风险已结束处理");
        }
        processService.insert(body);
        if (r.getProcessStatus() == null || AssessConstants.PROCESS_STATUS_UNPROCESSED.equals(r.getProcessStatus())) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_PROCESSING);
            update(r);
        }
        return body;
    }

    /**
     * 审核人对某轮处理记录给反馈。
     */
    @Transactional(rollbackFor = Exception.class)
    public void reviewProcess(Long processId, String reviewContent) {
        AsRiskProcess p = processService.findById(processId);
        if (p == null) {
            throw new ServiceException("处理记录不存在");
        }
        AsRiskRecord r = findById(p.getRiskRecordId());
        if (r == null) {
            throw new ServiceException("风险记录不存在");
        }
        if (!surveyService.isReviewer(r.getSurveyId())) {
            throw new ServiceException("仅审核人可反馈");
        }
        p.setReviewContent(reviewContent == null ? "" : reviewContent.trim());
        p.setReviewBy(SecurityUtils.getUsername());
        p.setReviewTime(new Date());
        processService.update(p);
    }

    /**
     * 完成处理：审核人选择通过(RECTIFIED)/不通过(UNRECTIFIED)。
     */
    @Transactional(rollbackFor = Exception.class)
    public void finishProcessing(Long id, String result, String comment) {
        AsRiskRecord r = findById(id);
        if (r == null) {
            throw new ServiceException("风险记录不存在");
        }
        if (!surveyService.isReviewer(r.getSurveyId())) {
            throw new ServiceException("仅审核人可完成处理");
        }
        if ("PASS".equalsIgnoreCase(result)) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_RECTIFIED);
        } else if ("FAIL".equalsIgnoreCase(result)) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_UNRECTIFIED);
        } else {
            throw new ServiceException("result 应为 PASS 或 FAIL");
        }
        if (comment != null && !comment.trim().isEmpty()) {
            r.setRemark(comment.trim());
        }
        update(r);
    }
}
