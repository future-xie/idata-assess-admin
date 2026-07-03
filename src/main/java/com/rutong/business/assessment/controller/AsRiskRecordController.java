package com.rutong.business.assessment.controller;

import com.rutong.business.assessment.constant.AssessConstants;
import com.rutong.business.assessment.entity.AsRiskProcess;
import com.rutong.business.assessment.service.AsRiskProcessService;
import com.rutong.framework.security.SecurityUtils;
import java.util.Date;
import java.util.HashMap;
import com.rutong.business.assessment.entity.AsRiskRecord;
import com.rutong.business.assessment.entity.AsSurvey;
import com.rutong.business.assessment.query.AsRiskRecordQuery;
import com.rutong.business.assessment.service.AsRiskRecordService;
import com.rutong.business.assessment.service.AsSurveyService;
import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.service.QmQuestionService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.dao.objectquery.SortFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 风险记录 控制器（风险管理 → 风险记录）。
 * <p>数据源为评估产生的 as_risk_record（由评估提交时风险规则引擎自动生成、或评估详情页手动标记）。
 * 此处提供集中查看 / 更新处理状态·等级·描述 / 删除，不提供新增。
 */
@RestController
@RequestMapping("/risk/register")
public class AsRiskRecordController {

    @Autowired
    private AsRiskRecordService riskRecordService;

    @Autowired
    private AsSurveyService surveyService;

    @Autowired
    private QmQuestionService questionService;

    @Autowired
    private AsRiskProcessService processService;

    /**
     * 分页查询（含关联评估标题/受访者、题目题干）
     */
    @PreAuthorize("@ss.hasPermi('risk:register:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsRiskRecordQuery query, PageBean page) {
        TableDataInfo rsp = riskRecordService.findAllByPage(page, query,
                List.of(new SortFilter("id", SortFilter.DESC)));
        List<?> rows = rsp.getRows();
        if (rows != null && !rows.isEmpty()) {
            List<Map<String, Object>> enriched = new ArrayList<>(rows.size());
            for (Object o : rows) {
                AsRiskRecord r = (AsRiskRecord) o;
                Map<String, Object> m = new LinkedHashMap<>();
                m.put("id", r.getId());
                m.put("surveyId", r.getSurveyId());
                m.put("questionId", r.getQuestionId());
                m.put("riskDesc", r.getRiskDesc());
                m.put("level", r.getLevel());
                m.put("handleStatus", r.getHandleStatus());
                m.put("processStatus", r.getProcessStatus());
                m.put("createTime", r.getCreateTime());
                fillSurvey(m, r.getSurveyId());
                fillQuestion(m, r.getQuestionId());
                enriched.add(m);
            }
            rsp.setRows(enriched);
        }
        return rsp;
    }

    /**
     * 详情
     */
    @PreAuthorize("@ss.hasPermi('risk:register:query')")
    @GetMapping("/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        AsRiskRecord r = riskRecordService.findById(id);
        AjaxResult res = AjaxResult.success(r);
        fillSurvey(res, r.getSurveyId());
        fillQuestion(res, r.getQuestionId());
        return res;
    }

    /**
     * 修改（仅允许变更 level/handleStatus/riskDesc；surveyId/questionId 锁定为原值）
     */
    @PreAuthorize("@ss.hasPermi('risk:register:edit')")
    @OperLog(title = "风险记录", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody AsRiskRecord data) {
        if (data.getId() == null) {
            return AjaxResult.error("id 不能为空");
        }
        AsRiskRecord existing = riskRecordService.findById(data.getId());
        if (existing == null) {
            return AjaxResult.error("风险记录不存在");
        }
        // 仅允许变更 level/riskDesc，其余字段（surveyId/questionId/handleStatus/processStatus 等）保持原值
        existing.setLevel(data.getLevel());
        existing.setRiskDesc(data.getRiskDesc());
        return AjaxResult.success(riskRecordService.update(existing));
    }

    /**
     * 删除
     */
    @PreAuthorize("@ss.hasPermi('risk:register:remove')")
    @OperLog(title = "风险记录", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        riskRecordService.deleteByIds(ids);
        return AjaxResult.success();
    }

    // ===================== 处理-审核工单 =====================

    /**
     * 处理详情：当前用户角色 + 风险记录 + 处理记录时间线
     */
    @PreAuthorize("@ss.hasPermi('risk:register:query')")
    @GetMapping("/processDetail/{id}")
    public AjaxResult processDetail(@PathVariable Long id) {
        AsRiskRecord r = riskRecordService.findById(id);
        if (r == null) return AjaxResult.error("风险记录不存在");
        Map<String, Object> data = new HashMap<>();
        data.put("currentRole", surveyService.currentRole(r.getSurveyId()));
        data.put("riskRecord", r);
        data.put("processes", processService.listByRiskRecord(id));
        return AjaxResult.success(data);
    }

    /**
     * 处理人(受访人)提交处理记录（文字 + 附件）
     */
    @PreAuthorize("@ss.hasPermi('risk:register:edit')")
    @OperLog(title = "风险处理", businessType = BusinessType.INSERT)
    @PostMapping("/process")
    public AjaxResult submitProcess(@RequestBody AsRiskProcess body) {
        if (body.getRiskRecordId() == null) return AjaxResult.error("riskRecordId 不能为空");
        AsRiskRecord r = riskRecordService.findById(body.getRiskRecordId());
        if (r == null) return AjaxResult.error("风险记录不存在");
        if (!AssessConstants.ROLE_RESPONDENT.equals(surveyService.currentRole(r.getSurveyId()))) {
            return AjaxResult.error("仅处理人(受访人)可提交处理记录");
        }
        if (AssessConstants.PROCESS_STATUS_RECTIFIED.equals(r.getProcessStatus())
                || AssessConstants.PROCESS_STATUS_UNRECTIFIED.equals(r.getProcessStatus())) {
            return AjaxResult.error("该风险已结束处理");
        }
        processService.insert(body);
        if (r.getProcessStatus() == null || AssessConstants.PROCESS_STATUS_UNPROCESSED.equals(r.getProcessStatus())) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_PROCESSING);
            riskRecordService.update(r);
        }
        return AjaxResult.success(body);
    }

    /**
     * 审核人对某轮处理记录给反馈
     */
    @PreAuthorize("@ss.hasPermi('risk:register:edit')")
    @OperLog(title = "风险反馈", businessType = BusinessType.UPDATE)
    @PostMapping("/process/review/{processId}")
    public AjaxResult reviewProcess(@PathVariable Long processId, @RequestBody Map<String, String> body) {
        AsRiskProcess p = processService.findById(processId);
        if (p == null) return AjaxResult.error("处理记录不存在");
        AsRiskRecord r = riskRecordService.findById(p.getRiskRecordId());
        if (r == null) return AjaxResult.error("风险记录不存在");
        if (!AssessConstants.ROLE_REVIEWER.equals(surveyService.currentRole(r.getSurveyId()))) {
            return AjaxResult.error("仅审核人可反馈");
        }
        String review = body == null ? null : body.get("reviewContent");
        p.setReviewContent(review == null ? "" : review.trim());
        p.setReviewBy(SecurityUtils.getUsername());
        p.setReviewTime(new Date());
        processService.update(p);
        return AjaxResult.success();
    }

    /**
     * 完成处理（独立按钮）：审核人选 通过(RECTIFIED)/不通过(UNRECTIFIED)
     */
    @PreAuthorize("@ss.hasPermi('risk:register:edit')")
    @OperLog(title = "完成风险处理", businessType = BusinessType.UPDATE)
    @PostMapping("/finishProcessing/{id}")
    public AjaxResult finishProcessing(@PathVariable Long id, @RequestBody Map<String, String> body) {
        AsRiskRecord r = riskRecordService.findById(id);
        if (r == null) return AjaxResult.error("风险记录不存在");
        if (!AssessConstants.ROLE_REVIEWER.equals(surveyService.currentRole(r.getSurveyId()))) {
            return AjaxResult.error("仅审核人可完成处理");
        }
        String result = body == null ? null : body.get("result");
        if ("PASS".equalsIgnoreCase(result)) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_RECTIFIED);
        } else if ("FAIL".equalsIgnoreCase(result)) {
            r.setProcessStatus(AssessConstants.PROCESS_STATUS_UNRECTIFIED);
        } else {
            return AjaxResult.error("result 应为 PASS 或 FAIL");
        }
        if (body != null && body.get("comment") != null && !body.get("comment").trim().isEmpty()) {
            r.setRemark(body.get("comment").trim());
        }
        riskRecordService.update(r);
        return AjaxResult.success();
    }

    private void fillSurvey(Map<String, Object> target, Long surveyId) {
        if (surveyId == null) return;
        AsSurvey s = surveyService.findById(surveyId);
        if (s == null) return;
        target.put("surveyTitle", s.getTitle());
        target.put("respondentName", s.getRespondentName());
    }

    private void fillQuestion(Map<String, Object> target, Long questionId) {
        if (questionId == null) return;
        QmQuestion q = questionService.findById(questionId);
        if (q == null) return;
        target.put("questionTitle", q.getTitle());
    }
}
