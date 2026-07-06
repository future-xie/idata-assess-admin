package com.rutong.business.assessment.controller;

import com.rutong.business.assessment.entity.AsComment;
import com.rutong.business.assessment.entity.AsRequest;
import com.rutong.business.assessment.entity.AsSurvey;
import com.rutong.business.assessment.pojo.DistributeBody;
import com.rutong.business.assessment.query.AsSurveyQuery;
import com.rutong.business.assessment.service.AsCommentService;
import com.rutong.business.assessment.service.AsRequestService;
import com.rutong.business.assessment.service.AsRiskRecordService;
import com.rutong.business.assessment.service.AsSurveyService;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 评估/分发 控制器（管理端，需登录）
 */
@RestController
@RequestMapping("/assessment/survey")
public class AsSurveyController {

    @Autowired
    private AsSurveyService surveyService;

    @Autowired
    private AsCommentService commentService;

    @Autowired
    private AsRequestService requestService;

    @Autowired
    private AsRiskRecordService riskRecordService;

    /**
     * 分页查询
     */
    @PreAuthorize("@ss.hasPermi('as:survey:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsSurveyQuery query, PageBean page) {
        return surveyService.listForCurrentUser(page, query,
                List.of(new com.rutong.framework.mybatis.objectquery.SortFilter("id", com.rutong.framework.mybatis.objectquery.SortFilter.DESC)));
    }

    /**
     * 详情（含最新答案）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/getInfo/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        AsSurvey survey = surveyService.findById(id);
        return AjaxResult.success(survey).put("answers", surveyService.latestAnswers(id));
    }

    /**
     * 评估详情页（survey+template+chapters+questions+answers）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/detail/{id}")
    public AjaxResult detail(@PathVariable Long id) {
        return AjaxResult.success(surveyService.adminDetail(id));
    }

    /**
     * 按章节加载题目（含选项+逻辑，供详情页懒加载）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/chapterQuestions/{surveyId}/{chapterId}")
    public AjaxResult chapterQuestions(@PathVariable Long surveyId, @PathVariable Long chapterId) {
        return AjaxResult.success(surveyService.chapterQuestions(surveyId, chapterId));
    }

    /**
     * 某题答案变更历史（活动流）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/answerHistory/{surveyId}/{questionId}")
    public AjaxResult answerHistory(@PathVariable Long surveyId, @PathVariable Long questionId) {
        return AjaxResult.success(surveyService.answerHistory(surveyId, questionId));
    }

    /**
     * 保存答卷（草稿）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "评估保存", businessType = BusinessType.UPDATE)
    @PostMapping("/saveAnswers/{id}")
    public AjaxResult saveAnswers(@PathVariable Long id, @RequestBody List<com.rutong.business.assessment.entity.AsAnswer> answers) {
        return AjaxResult.success(surveyService.saveAnswers(id, answers));
    }

    /**
     * 提交答卷（管理端，按 ID）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "评估提交", businessType = BusinessType.UPDATE)
    @PostMapping("/submitById/{id}")
    public AjaxResult submitById(@PathVariable Long id, @RequestBody List<com.rutong.business.assessment.entity.AsAnswer> answers) {
        return AjaxResult.success(surveyService.submitById(id, answers));
    }

    /**
     * 查询某题注释列表
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/comments/{surveyId}/{questionId}")
    public AjaxResult comments(@PathVariable Long surveyId, @PathVariable Long questionId) {
        return AjaxResult.success(commentService.listByQuestion(surveyId, questionId));
    }

    /**
     * 新增注释
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @PostMapping("/comment")
    public AjaxResult addComment(@RequestBody AsComment comment) {
        return AjaxResult.success(commentService.insert(comment));
    }

    /**
     * 分发（邮件）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:distribute')")
    @OperLog(title = "评估分发", businessType = BusinessType.INSERT)
    @PostMapping("/distribute")
    public AjaxResult distribute(@RequestBody DistributeBody body) {
        return AjaxResult.success(surveyService.distribute(body));
    }

    /**
     * 修改评估基本信息（标题/受访人/评估人/截止日期/章节范围）
     */
    @PreAuthorize("@ss.hasPermi('as:survey:distribute')")
    @OperLog(title = "评估编辑", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public AjaxResult update(@RequestBody AsSurvey body) {
        return AjaxResult.success(surveyService.updateSurvey(body));
    }

    /**
     * 退回重填
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "评估退回", businessType = BusinessType.UPDATE)
    @PostMapping("/returnBack/{id}")
    public AjaxResult returnBack(@PathVariable Long id, @RequestBody(required = false) java.util.Map<String, String> body) {
        String reason = body == null ? null : body.get("reason");
        return AjaxResult.success(surveyService.returnBack(id, reason));
    }

    /**
     * 发回:审核中 → 进行中(允许受访人/评估人继续编辑)
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "评估发回", businessType = BusinessType.UPDATE)
    @PostMapping("/sendBack/{id}")
    public AjaxResult sendBack(@PathVariable Long id) {
        return AjaxResult.success(surveyService.sendBack(id));
    }

    /**
     * 完成审核:审核中 → 审核通过(APPROVED) / 已拒绝(REJECTED)
     * @param body { result: "APPROVED" | "REJECTED", comment: 备注(可选) }
     */
    @PreAuthorize("@ss.hasPermi('as:survey:review')")
    @OperLog(title = "完成审核", businessType = BusinessType.UPDATE)
    @PostMapping("/review/{id}")
    public AjaxResult review(@PathVariable Long id, @RequestBody(required = false) java.util.Map<String, String> body) {
        String result = body == null ? null : body.get("result");
        String comment = body == null ? null : body.get("comment");
        return AjaxResult.success(surveyService.review(id, result, comment));
    }

    /**
     * 过程监控统计
     */
    @PreAuthorize("@ss.hasPermi('as:survey:stat')")
    @GetMapping("/statistics/{templateId}")
    public AjaxResult statistics(@PathVariable Long templateId) {
        return AjaxResult.success(surveyService.statistics(templateId));
    }

    /**
     * 删除
     */
    @PreAuthorize("@ss.hasPermi('as:survey:remove')")
    @OperLog(title = "评估删除", businessType = BusinessType.DELETE)
    @PostMapping("/delete/{ids}")
    public AjaxResult delete(@PathVariable Long[] ids) {
        surveyService.deleteByIds(ids);
        return AjaxResult.success();
    }

    /**
     * 查询某题的所有修改请求(按时间倒序)
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/requests/{surveyId}/{questionId}")
    public AjaxResult listRequests(@PathVariable Long surveyId, @PathVariable Long questionId) {
        return AjaxResult.success(requestService.listByQuestion(surveyId, questionId));
    }

    /**
     * 新增一条题目修改请求
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "创建请求", businessType = BusinessType.INSERT)
    @PostMapping("/request")
    public AjaxResult addRequest(@RequestBody AsRequest body) {
        if (body.getSurveyId() == null || body.getQuestionId() == null) {
            return AjaxResult.error("surveyId / questionId 不能为空");
        }
        if (body.getContent() == null || body.getContent().trim().isEmpty()) {
            return AjaxResult.error("请求内容不能为空");
        }
        return AjaxResult.success(surveyService.createRequest(body.getSurveyId(), body.getQuestionId(), body.getContent().trim()));
    }

    /**
     * 查询某题的所有风险记录(按创建时间倒序)
     */
    @PreAuthorize("@ss.hasPermi('as:survey:query')")
    @GetMapping("/riskRecords/{surveyId}/{questionId}")
    public AjaxResult listRiskRecords(@PathVariable Long surveyId, @PathVariable Long questionId) {
        return AjaxResult.success(riskRecordService.listByQuestion(surveyId, questionId));
    }

    /**
     * 新增一条风险记录(前端"标记风险"弹窗调用)
     */
    @PreAuthorize("@ss.hasPermi('as:survey:return')")
    @OperLog(title = "标记风险", businessType = BusinessType.INSERT)
    @PostMapping("/riskRecord")
    public AjaxResult addRiskRecord(@RequestBody java.util.Map<String, Object> body) {
        Object sid = body.get("surveyId");
        Object qid = body.get("questionId");
        if (sid == null || qid == null) {
            return AjaxResult.error("surveyId / questionId 不能为空");
        }
        if (!surveyService.isReviewer(Long.parseLong(sid.toString()))) {
            return AjaxResult.error("仅审核人可标记风险");
        }
        String level = body.get("level") == null ? null : body.get("level").toString();
        String riskDesc = body.get("riskDesc") == null ? null : body.get("riskDesc").toString();
        String riskName = body.get("riskName") == null ? null : body.get("riskName").toString();
        String treatmentPlan = body.get("treatmentPlan") == null ? null : body.get("treatmentPlan").toString();
        if (level == null || level.trim().isEmpty()) {
            return AjaxResult.error("请选择风险等级");
        }
        if (riskDesc == null || riskDesc.trim().isEmpty()) {
            return AjaxResult.error("请输入风险描述");
        }
        return AjaxResult.success(riskRecordService.create(
                Long.parseLong(sid.toString()),
                Long.parseLong(qid.toString()),
                level.toUpperCase(),
                riskDesc.trim(),
                riskName == null ? null : riskName.trim(),
                treatmentPlan == null ? null : treatmentPlan.trim()));
    }
}
