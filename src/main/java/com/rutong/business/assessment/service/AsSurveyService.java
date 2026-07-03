package com.rutong.business.assessment.service;

import com.rutong.business.assessment.constant.AssessConstants;
import com.rutong.business.assessment.entity.AsAnswer;
import com.rutong.business.assessment.entity.AsAnswerHistory;
import com.rutong.business.assessment.entity.AsRequest;
import com.rutong.business.assessment.entity.AsRiskRecord;
import com.rutong.business.assessment.entity.AsSurvey;
import com.rutong.business.assessment.pojo.AssignItem;
import com.rutong.business.assessment.pojo.DistributeBody;
import com.rutong.business.assessment.pojo.StatisticsVo;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmChapter;
import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.entity.QmRiskRuleCond;
import com.rutong.business.questionnaire.entity.QmTemplate;
import com.rutong.business.system.entity.SysUser;
import com.rutong.business.questionnaire.pojo.QuestionVo;
import com.rutong.business.questionnaire.pojo.RiskRuleVo;
import com.rutong.business.questionnaire.service.QmChapterService;
import com.rutong.business.questionnaire.service.QmQuestionService;
import com.rutong.business.questionnaire.service.QmRiskRuleService;
import com.rutong.business.assessment.query.AsSurveyQuery;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.mail.MailService;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * 评估/分发 业务层
 */
@Service
public class AsSurveyService extends BaseService<AsSurvey> {

    private static final Logger log = LoggerFactory.getLogger(AsSurveyService.class);

    @Autowired
    private AsAnswerHistoryService answerHistoryService;

    @Autowired
    private AsRequestService requestService;

    @Autowired
    private AsRiskRecordService riskRecordService;

    @Autowired
    private QmQuestionService questionService;

    @Autowired
    private QmRiskRuleService riskRuleService;

    @Autowired
    private QmChapterService chapterService;

    @Autowired
    private MailService mailService;

    /**
     * 分发：按邮箱逐人生成填写实例与令牌，异步发送通知邮件
     *
     * @return 生成的实例列表（含 fillToken）
     */
    @Transactional
    public List<AsSurvey> distribute(DistributeBody body) {
        if (body.getTemplateId() == null) {
            throw new ServiceException("评估模板不能为空");
        }
        if (body.getAssignments() == null || body.getAssignments().isEmpty()) {
            throw new ServiceException("受访人不能为空");
        }
        QmTemplate template = dao.findById(QmTemplate.class, body.getTemplateId());
        if (template == null) {
            throw new ServiceException("模板不存在");
        }
        String title = StringUtils.isEmpty(body.getTitle()) ? template.getTemplateName() : body.getTitle();
        Long operUserId = SecurityUtils.getUserId();
        String assessorIds = joinIds(body.getAssessorIds());

        List<AsSurvey> created = new ArrayList<>();
        for (AssignItem a : body.getAssignments()) {
            if (a == null || a.getUserId() == null) {
                continue;
            }
            SysUser user = dao.findById(SysUser.class, a.getUserId());
            if (user == null) {
                continue;
            }
            AsSurvey s = new AsSurvey();
            s.setTemplateId(body.getTemplateId());
            s.setTitle(title);
            s.setRespondentName(user.getNickName());
            s.setRespondentEmail(user.getEmail());
            s.setRespondentUserId(a.getUserId());
            s.setStatus(AssessConstants.STATUS_DISTRIBUTED);
            s.setDistributeTime(new Date());
            s.setOperUserId(operUserId);
            s.setAssessorIds(assessorIds);
            s.setDueDate(body.getDueDate());
            s.setChapterScope(joinIds(a.getChapterIds()));
            insert(s); // 写 createBy，便于数据权限过滤
            created.add(s);
            sendDistributionMail(s);
        }
        return created;
    }

    /**
     * 修改评估基本信息（标题/受访人/评估人/截止日期/章节范围）。
     * 仅分发人或管理员可改；受访人变更时反查 SysUser 同步姓名/邮箱。
     */
    @Transactional
    public AsSurvey updateSurvey(AsSurvey body) {
        AsSurvey survey = findById(body.getId());
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        Long uid = SecurityUtils.getUserId();
        if (!SecurityUtils.isAdmin(uid) && !SecurityUtils.getUsername().equals(survey.getCreateBy())) {
            throw new ServiceException("无权修改该评估");
        }
        if (body.getRespondentUserId() != null) {
            SysUser user = dao.findById(SysUser.class, body.getRespondentUserId());
            if (user == null) {
                throw new ServiceException("受访人不存在");
            }
            survey.setRespondentUserId(body.getRespondentUserId());
            survey.setRespondentName(user.getNickName());
            survey.setRespondentEmail(user.getEmail());
        }
        survey.setTitle(body.getTitle());
        survey.setAssessorIds(body.getAssessorIds());
        survey.setDueDate(body.getDueDate());
        survey.setChapterScope(body.getChapterScope());
        update(survey);
        return survey;
    }

    /** 逗号拼接 ID 列表，空返回 null */
    private String joinIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (Long id : ids) {
            if (id == null) {
                continue;
            }
            if (sb.length() > 0) {
                sb.append(",");
            }
            sb.append(id);
        }
        return sb.length() == 0 ? null : sb.toString();
    }

    /**
     * 提交答卷（按 ID）
     */
    @Transactional
    public AsSurvey submitById(Long surveyId, List<AsAnswer> answers) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        ensureRespondent(surveyId);
        return doSubmit(survey, answers);
    }

    private AsSurvey doSubmit(AsSurvey survey, List<AsAnswer> inputAnswers) {
        // 校验
        validateAnswers(survey, inputAnswers);

        // 原地更新答案（有变化时记录历史）
        upsertAnswers(survey.getId(), inputAnswers);

        // 单题风险记录
        List<AsAnswer> answers = inputAnswers == null ? new ArrayList<>() : inputAnswers;
        for (AsAnswer a : answers) {
            if (AssessConstants.YES.equalsIgnoreCase(a.getRiskFlag())) {
                AsRiskRecord risk = new AsRiskRecord();
                risk.setSurveyId(survey.getId());
                risk.setQuestionId(a.getQuestionId());
                risk.setRiskDesc(StringUtils.isEmpty(a.getRemark()) ? "答题标记风险" : a.getRemark());
                risk.setLevel(AssessConstants.LEVEL_MID);
                risk.setHandleStatus(AssessConstants.HANDLE_PENDING);
                risk.setProcessStatus(AssessConstants.PROCESS_STATUS_UNPROCESSED);
                dao.save(risk);
            }
        }

        // 命中风险规则则自动生成风险记录
        evaluateRiskRules(survey.getTemplateId(), survey.getId(), answers);

        // 提交后进入"审核中"状态
        survey.setStatus(AssessConstants.STATUS_REVIEWING);
        survey.setSubmitTime(new Date());
        update(survey);
        return survey;
    }

    /**
     * 保存答卷（草稿，不校验必填、不提交、不触发风险）：原地更新答案，状态置为填写中。
     * 已"审核中"或"已退回"的实例不再切换为填写中(前者等待审核结果,后者需显式重填)。
     */
    @Transactional
    public AsSurvey saveAnswers(Long surveyId, List<AsAnswer> inputAnswers) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        ensureRespondent(surveyId);
        upsertAnswers(surveyId, inputAnswers);
        if (!AssessConstants.STATUS_REVIEWING.equals(survey.getStatus())
                && !AssessConstants.STATUS_RETURNED.equals(survey.getStatus())) {
            survey.setStatus(AssessConstants.STATUS_FILLING);
            update(survey);
        }
        return survey;
    }

    /**
     * 评估详情（管理端）：survey + template + chapters + questions(按 chapterScope 过滤) + 最新答案。
     */
    public Map<String, Object> adminDetail(Long id) {
        AsSurvey survey = findById(id);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        QmTemplate template = dao.findById(QmTemplate.class, survey.getTemplateId());
        List<QmQuestion> allQuestions = questionService.listByTemplate(survey.getTemplateId());
        // 章节范围过滤
        Set<Long> scope = null;
        if (StringUtils.isNotEmpty(survey.getChapterScope())) {
            scope = new HashSet<>();
            for (String sid : survey.getChapterScope().split(",")) {
                try { scope.add(Long.parseLong(sid.trim())); } catch (NumberFormatException ignore) {}
            }
        }
        final Set<Long> finalScope = scope;
        long totalQuestionCount = allQuestions.stream()
                .filter(q -> (finalScope == null || finalScope.contains(q.getChapterId())) && !"DESCRIPTION".equals(q.getQuestionType()))
                .count();
        // 必填题 ID 列表（用于前端校验提交按钮）
        List<Long> requiredQuestionIds = allQuestions.stream()
                .filter(q -> "Y".equals(q.getRequired())
                        && (finalScope == null || finalScope.contains(q.getChapterId()))
                        && !"DESCRIPTION".equals(q.getQuestionType()))
                .map(QmQuestion::getId)
                .collect(Collectors.toList());
        // 按章节分组必填题 ID（初始化时即可显示各章节必填未答数）
        Map<Long, List<Long>> requiredByChapter = new HashMap<>();
        for (QmQuestion q : allQuestions) {
            if ("Y".equals(q.getRequired()) && !"DESCRIPTION".equals(q.getQuestionType())
                    && (finalScope == null || finalScope.contains(q.getChapterId()))) {
                requiredByChapter.computeIfAbsent(q.getChapterId(), k -> new ArrayList<>()).add(q.getId());
            }
        }
        List<QmChapter> chapters = chapterService.listByTemplate(survey.getTemplateId());

        // 每题修改请求数(用于前端"查看请求"按钮显隐)
        Map<Long, Long> requestCountByQuestion = requestService.countByQuestion(id);

        // 每题风险记录数(用于前端"查看风险"按钮显隐)
        Map<Long, Long> riskRecordCountByQuestion = riskRecordService.countByQuestion(id);

        // 每章"待修改"题数(章节标题三角标识,无需懒加载题目即可显示)
        // 同一题同时存在请求+风险时只算 1 道题
        Map<Long, Long> pendingCountByChapter = buildPendingCountByChapter(allQuestions, requestCountByQuestion, latestAnswers(id));

        Map<String, Object> result = new HashMap<>();
        result.put("survey", survey);
        result.put("template", template);
        result.put("chapters", chapters);
        result.put("totalQuestionCount", totalQuestionCount);
        result.put("requiredQuestionIds", requiredQuestionIds);
        result.put("requiredByChapter", requiredByChapter);
        result.put("requestCountByQuestion", requestCountByQuestion);
        result.put("riskRecordCountByQuestion", riskRecordCountByQuestion);
        result.put("pendingCountByChapter", pendingCountByChapter);
        result.put("answers", latestAnswers(id));
        result.put("currentRole", currentRole(id));
        return result;
    }

    /**
     * 聚合每章"待修改"题数(存在请求或风险标记)。
     * 用于章节标题的黄色三角标识,在章节未展开时即可显示。
     */
    private Map<Long, Long> buildPendingCountByChapter(List<QmQuestion> allQuestions, Map<Long, Long> requestCountByQuestion, List<AsAnswer> answers) {
        // qid -> chapterId 映射
        Map<Long, Long> qidToChapter = new HashMap<>();
        for (QmQuestion q : allQuestions) {
            qidToChapter.put(q.getId(), q.getChapterId());
        }
        // 待修改的题目 ID 集合(去重)
        Set<Long> pendingQids = new HashSet<>();
        for (Map.Entry<Long, Long> e : requestCountByQuestion.entrySet()) {
            if (e.getValue() != null && e.getValue() > 0) {
                pendingQids.add(e.getKey());
            }
        }
        if (answers != null) {
            for (AsAnswer a : answers) {
                if (AssessConstants.YES.equalsIgnoreCase(a.getRiskFlag())) {
                    pendingQids.add(a.getQuestionId());
                }
            }
        }
        // 按章节聚合
        Map<Long, Long> result = new HashMap<>();
        for (Long qid : pendingQids) {
            Long chId = qidToChapter.get(qid);
            if (chId != null) result.merge(chId, 1L, Long::sum);
        }
        return result;
    }

    /**
     * 按章节加载题目（含选项 + 逻辑），供详情页懒加载。
     */
    public List<QuestionVo> chapterQuestions(Long surveyId, Long chapterId) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        // 章节范围校验
        if (StringUtils.isNotEmpty(survey.getChapterScope())) {
            Set<Long> scope = new HashSet<>();
            for (String sid : survey.getChapterScope().split(",")) {
                try { scope.add(Long.parseLong(sid.trim())); } catch (NumberFormatException ignore) {}
            }
            if (!scope.contains(chapterId)) {
                return new ArrayList<>();
            }
        }
        return questionService.listVoByChapter(chapterId);
    }

    /**
     * 某题的答案变更历史（从 as_answer_history 表查询）。
     */
    public List<AsAnswerHistory> answerHistory(Long surveyId, Long questionId) {
        return answerHistoryService.listByQuestion(surveyId, questionId);
    }
    private void evaluateRiskRules(Long templateId, Long surveyId, List<AsAnswer> answers) {
        List<RiskRuleVo> rules = riskRuleService.listVoByTemplate(templateId);
        if (rules == null || rules.isEmpty()) {
            return;
        }
        // 构建答案映射 questionId -> answerValue
        Map<Long, String> answerMap = new HashMap<>();
        for (AsAnswer a : answers) {
            if (a.getQuestionId() != null) {
                answerMap.put(a.getQuestionId(), a.getAnswerValue() == null ? "" : a.getAnswerValue());
            }
        }
        for (RiskRuleVo rule : rules) {
            List<QmRiskRuleCond> conds = rule.getConditions();
            if (conds == null || conds.isEmpty()) {
                continue;
            }
            boolean allMet = true;
            for (QmRiskRuleCond c : conds) {
                if (!evalRiskCond(c, answerMap)) {
                    allMet = false;
                    break;
                }
            }
            if (allMet) {
                AsRiskRecord risk = new AsRiskRecord();
                risk.setSurveyId(surveyId);
                risk.setQuestionId(conds.get(0).getCondQuestionId());
                String name = StringUtils.isNotEmpty(rule.getRuleName()) ? rule.getRuleName()
                        : (StringUtils.isNotEmpty(rule.getRiskName()) ? rule.getRiskName() : "命中风险规则");
                String desc = StringUtils.isNotEmpty(rule.getRiskDesc()) ? name + "：" + rule.getRiskDesc() : name;
                risk.setRiskDesc(desc);
                risk.setLevel(StringUtils.isEmpty(rule.getLevel()) ? AssessConstants.LEVEL_MID : rule.getLevel());
                risk.setHandleStatus(AssessConstants.HANDLE_PENDING);
                risk.setProcessStatus(AssessConstants.PROCESS_STATUS_UNPROCESSED);
                dao.save(risk);
            }
        }
    }

    /** 单个条件求值 */
    private boolean evalRiskCond(QmRiskRuleCond c, Map<Long, String> answerMap) {
        String ans = answerMap.getOrDefault(c.getCondQuestionId(), "");
        String cv = c.getCondValue() == null ? "" : c.getCondValue();
        String op = c.getOp() == null ? "EQ" : c.getOp();
        switch (op) {
            case "EQ":
                return ans.equals(cv);
            case "NE":
                return !ans.equals(cv);
            case "IN":
                for (String v : cv.split(",")) {
                    if (v.trim().equals(ans)) {
                        return true;
                    }
                }
                return false;
            default:
                return false;
        }
    }

    /**
     * 退回重填(仅"审核中"状态的答卷可退回)
     */
    @Transactional
    public int returnBack(Long surveyId, String reason) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        ensureReviewer(surveyId);
        if (!AssessConstants.STATUS_REVIEWING.equals(survey.getStatus())) {
            throw new ServiceException("仅审核中的答卷可退回");
        }
        survey.setStatus(AssessConstants.STATUS_RETURNED);
        if (StringUtils.isNotEmpty(reason)) {
            survey.setRemark(reason);
        }
        return update(survey);
    }

    /**
     * 发回:审核中 → 进行中(允许受访人/评估人继续编辑)。
     * 与 returnBack 的区别:returnBack 进入"已退回"状态,sendBack 直接回退到"进行中"。
     */
    @Transactional
    public AsSurvey sendBack(Long surveyId) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        ensureReviewer(surveyId);
        if (!AssessConstants.STATUS_REVIEWING.equals(survey.getStatus())) {
            throw new ServiceException("仅审核中的答卷可发回");
        }
        survey.setStatus(AssessConstants.STATUS_FILLING);
        update(survey);
        return survey;
    }

    /**
     * 完成审核:审核中 → 审核通过(APPROVED) / 已拒绝(REJECTED)。
     * @param result  APPROVED / REJECTED
     * @param comment 审核备注(可选,会写入 AsSurvey.remark)
     */
    @Transactional
    public AsSurvey review(Long surveyId, String result, String comment) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            throw new ServiceException("评估实例不存在");
        }
        ensureReviewer(surveyId);
        if (!AssessConstants.STATUS_REVIEWING.equals(survey.getStatus())) {
            throw new ServiceException("仅审核中的答卷可完成审核");
        }
        if (AssessConstants.STATUS_APPROVED.equalsIgnoreCase(result)) {
            survey.setStatus(AssessConstants.STATUS_APPROVED);
        } else if (AssessConstants.STATUS_REJECTED.equalsIgnoreCase(result)) {
            survey.setStatus(AssessConstants.STATUS_REJECTED);
        } else {
            throw new ServiceException("审核结果参数错误,应为 APPROVED 或 REJECTED");
        }
        if (StringUtils.isNotEmpty(comment)) {
            survey.setRemark(comment);
        }
        update(survey);
        return survey;
    }

    /**
     * 过程监控统计
     */
    public StatisticsVo statistics(Long templateId) {
        List<AsSurvey> all = dao.findByProperty(AsSurvey.class, "templateId", templateId);
        long submitted = 0, returned = 0;
        for (AsSurvey s : all) {
            if (AssessConstants.STATUS_REVIEWING.equals(s.getStatus())) {
                submitted++;
            } else if (AssessConstants.STATUS_RETURNED.equals(s.getStatus())) {
                returned++;
            }
        }
        long total = all.size();
        long recovered = submitted + returned;
        StatisticsVo vo = new StatisticsVo();
        vo.setTotal(total);
        vo.setSubmitted(submitted);
        vo.setReturned(returned);
        vo.setCompleted(submitted);
        vo.setRecoveryRate(total > 0 ? Math.round(recovered * 10000.0 / total) / 10000.0 : 0d);
        vo.setCompletionRate(recovered > 0 ? Math.round(submitted * 10000.0 / recovered) / 10000.0 : 0d);
        return vo;
    }

    /**
     * 查询某实例全部答案（每题一行，无版本）
     */
    public List<AsAnswer> latestAnswers(Long surveyId) {
        return dao.findByProperty(AsAnswer.class, "surveyId", surveyId);
    }

    /**
     * 列表（按当前用户可见范围）：管理员全部；
     * 否则仅返回 respondentUserId=自己 / assessorIds 含自己 / 自己分发(createBy) 的问卷。
     * 绕过默认 @DataScope（它按 createBy 过滤，不适合受访人）。
     */
    public TableDataInfo listForCurrentUser(PageBean page, AsSurveyQuery query, List<SortFilter> sorts) {
        Long uid = SecurityUtils.getUserId();
        String username = SecurityUtils.getUsername();
        StringBuilder where = new StringBuilder(" where 1=1 ");
        List<Object> params = new ArrayList<>();
        if (query != null) {
            if (query.getTemplateId() != null) {
                where.append(" and s.templateId = ?");
                params.add(query.getTemplateId());
            }
            if (StringUtils.isNotEmpty(query.getStatus())) {
                where.append(" and s.status = ?");
                params.add(query.getStatus());
            }
            if (StringUtils.isNotEmpty(query.getRespondentName())) {
                where.append(" and s.respondentName like ?");
                params.add("%" + query.getRespondentName() + "%");
            }
            if (StringUtils.isNotEmpty(query.getRespondentEmail())) {
                where.append(" and s.respondentEmail like ?");
                params.add("%" + query.getRespondentEmail() + "%");
            }
        }
        if (!SecurityUtils.isAdmin(uid)) {
            where.append(" and (s.respondentUserId = ? or s.createBy = ? or concat(',', coalesce(s.assessorIds,''), ',') like ?)");
            params.add(uid);
            params.add(username);
            params.add("%," + uid + ",%");
        }
        Object[] arr = params.toArray();
        long total = dao.executeHqlCountQuery(Long.class, "select count(s.id) from AsSurvey s" + where, arr);
        TableDataInfo rsp = new TableDataInfo();
        rsp.setTotal(total);
        if (total > 0) {
            org.hibernate.query.Query<AsSurvey> q = dao.getHqlQuery(AsSurvey.class,
                    "from AsSurvey s" + where + " order by s.id desc", arr, null);
            q.setFirstResult(page.getStart());
            q.setMaxResults(page.getPageSize());
            rsp.setRows(q.list());
        } else {
            rsp.setRows(new ArrayList<>());
        }
        rsp.setCode(200);
        rsp.setMsg("查询成功");
        return rsp;
    }

    /**
     * 当前登录用户在本问卷的角色：RESPONDENT 受访人 / REVIEWER 审核人 / null 无归属。
     * 管理员(id=1)若无归属视为 REVIEWER，便于管理端审批。
     */
    public String currentRole(Long surveyId) {
        AsSurvey survey = findById(surveyId);
        if (survey == null) {
            return null;
        }
        Long uid = SecurityUtils.getUserId();
        if (uid != null && uid.equals(survey.getRespondentUserId())) {
            return AssessConstants.ROLE_RESPONDENT;
        }
        if (containsAssessor(survey.getAssessorIds(), uid)) {
            return AssessConstants.ROLE_REVIEWER;
        }
        if (SecurityUtils.isAdmin(uid)) {
            return AssessConstants.ROLE_REVIEWER;
        }
        return null;
    }

    /** assessorIds（逗号分隔）是否包含 uid */
    private boolean containsAssessor(String assessorIds, Long uid) {
        if (StringUtils.isEmpty(assessorIds) || uid == null) {
            return false;
        }
        for (String id : assessorIds.split(",")) {
            try {
                if (uid.equals(Long.parseLong(id.trim()))) {
                    return true;
                }
            } catch (NumberFormatException ignore) {
            }
        }
        return false;
    }

    /**
     * 创建题目修改请求：发起方由后端按当前用户归属自动判定（不信前端），无归属则拒绝。
     */
    @Transactional
    public AsRequest createRequest(Long surveyId, Long questionId, String content) {
        String role = currentRole(surveyId);
        if (role == null) {
            throw new ServiceException("您无权对该问卷发起请求");
        }
        AsRequest r = new AsRequest();
        r.setSurveyId(surveyId);
        r.setQuestionId(questionId);
        r.setContent(content);
        r.setSenderType(role);
        r.setSenderUserId(SecurityUtils.getUserId());
        requestService.insert(r);
        return r;
    }

    /** 校验当前用户是该问卷的受访人 */
    private void ensureRespondent(Long surveyId) {
        if (!AssessConstants.ROLE_RESPONDENT.equals(currentRole(surveyId))) {
            throw new ServiceException("仅受访人可填写/提交答卷");
        }
    }

    /** 校验当前用户是该问卷的审核人 */
    private void ensureReviewer(Long surveyId) {
        if (!AssessConstants.ROLE_REVIEWER.equals(currentRole(surveyId))) {
            throw new ServiceException("仅审核人可执行该操作");
        }
    }

    /**
     * 原地 upsert 答案：存在则比较差异→更新+记录历史，不存在则新增。
     */
    private void upsertAnswers(Long surveyId, List<AsAnswer> inputAnswers) {
        if (inputAnswers == null || inputAnswers.isEmpty()) {
            return;
        }
        // 加载现有答案 map: questionId → AsAnswer
        Map<Long, AsAnswer> existing = new HashMap<>();
        for (AsAnswer a : dao.findByProperty(AsAnswer.class, "surveyId", surveyId)) {
            existing.put(a.getQuestionId(), a);
        }
        for (AsAnswer incoming : inputAnswers) {
            if (incoming.getQuestionId() == null) {
                continue;
            }
            String newVal = incoming.getAnswerValue() == null ? "" : incoming.getAnswerValue();
            String newRemark = incoming.getRemark() == null ? "" : incoming.getRemark();
            String newRisk = StringUtils.isEmpty(incoming.getRiskFlag()) ? AssessConstants.NO : incoming.getRiskFlag();

            AsAnswer cur = existing.get(incoming.getQuestionId());
            if (cur == null) {
                // 新增
                AsAnswer a = new AsAnswer();
                a.setSurveyId(surveyId);
                a.setQuestionId(incoming.getQuestionId());
                a.setAnswerValue(newVal);
                a.setRemark(newRemark);
                a.setRiskFlag(newRisk);
                dao.save(a);
                // 记录历史（空 → 新值）
                if (!newVal.isEmpty()) {
                    recordHistory(surveyId, incoming.getQuestionId(), "", newVal);
                }
            } else {
                String oldVal = cur.getAnswerValue() == null ? "" : cur.getAnswerValue();
                String oldRemark = cur.getRemark() == null ? "" : cur.getRemark();
                boolean changed = !oldVal.equals(newVal) || !oldRemark.equals(newRemark);
                if (changed) {
                    // 记录历史
                    recordHistory(surveyId, incoming.getQuestionId(), oldVal, newVal);
                    // 原地更新
                    cur.setAnswerValue(newVal);
                    cur.setRemark(newRemark);
                    cur.setRiskFlag(newRisk);
                    dao.update(cur);
                }
            }
        }
    }

    /**
     * 记录答案变更历史
     */
    private void recordHistory(Long surveyId, Long questionId, String oldValue, String newValue) {
        AsAnswerHistory h = new AsAnswerHistory();
        h.setSurveyId(surveyId);
        h.setQuestionId(questionId);
        h.setOldValue(oldValue);
        h.setNewValue(newValue);
        dao.save(h);
    }

    // ===================== 私有辅助 =====================

    /**
     * 答案校验：必填、正则、字数
     */
    private void validateAnswers(AsSurvey survey, List<AsAnswer> answers) {
        List<QmQuestion> questions = questionService.listByTemplate(survey.getTemplateId());
        Map<Long, AsAnswer> answerMap = new HashMap<>();
        if (answers != null) {
            for (AsAnswer a : answers) {
                if (a.getQuestionId() != null) {
                    answerMap.put(a.getQuestionId(), a);
                }
            }
        }
        for (QmQuestion q : questions) {
            if ("DESCRIPTION".equals(q.getQuestionType())) {
                continue; // 说明题仅展示，不需要作答
            }
            AsAnswer a = answerMap.get(q.getId());
            String value = a == null ? null : a.getAnswerValue();
            boolean empty = StringUtils.isEmpty(value);
            // 必填
            if (AssessConstants.YES.equalsIgnoreCase(q.getRequired()) && empty) {
                throw new ServiceException("题目「" + q.getTitle() + "」为必填");
            }
            if (empty) {
                continue;
            }
            // 文本类校验参数（结构化字段）
            Integer minLen = q.getMinLen();
            Integer maxLen = q.getMaxLen();
            String regex = q.getRegex();
            int len = value.length();
            if (minLen != null && len < minLen) {
                throw new ServiceException("题目「" + q.getTitle() + "」最少 " + minLen + " 字");
            }
            if (maxLen != null && len > maxLen) {
                throw new ServiceException("题目「" + q.getTitle() + "」最多 " + maxLen + " 字");
            }
            if (StringUtils.isNotEmpty(regex) && !Pattern.matches(regex, value)) {
                throw new ServiceException("题目「" + q.getTitle() + "」格式不正确");
            }
        }
    }

    /**
     * 发送分发邮件（HTML），异步发送，失败仅记日志不影响分发流程。
     * 当 mail.enabled=false 时只记录填写链接。
     */
    private void sendDistributionMail(AsSurvey s) {
        String link = mailService.getFrontUrl() + "/#/assessment/surveyDetail?id=" + s.getId();
        log.info("[问卷分发] 收件人={} 标题={} 填写链接={}", s.getRespondentEmail(), s.getTitle(), link);

        String subject = "【" + mailService.getFromName() + "】问卷填写邀请：" + s.getTitle();
        String name = StringUtils.isEmpty(s.getRespondentName()) ? "您" : s.getRespondentName();
        String html = "<div style=\"font-size:14px;line-height:1.7\">"
                + "<p>" + escapeHtml(name) + " 您好，</p>"
                + "<p>您被邀请填写问卷：<b>" + escapeHtml(s.getTitle()) + "</b></p>"
                + "<p>请点击下方链接开始填写（此链接为您的专属链接，请勿转发）：</p>"
                + "<p><a href=\"" + link + "\">" + link + "</a></p>"
                + "<p style=\"color:#999;font-size:12px;margin-top:24px\">此邮件由系统自动发送，请勿直接回复。</p>"
                + "</div>";
        mailService.sendAsync(s.getRespondentEmail(), subject, html);
    }

    private static String escapeHtml(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
    }
}
