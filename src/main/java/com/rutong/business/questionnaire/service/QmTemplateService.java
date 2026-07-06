package com.rutong.business.questionnaire.service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rutong.business.common.entity.BaseEntity;
import com.rutong.business.questionnaire.constant.QuestionConstants;
import com.rutong.business.questionnaire.entity.QmChapter;
import com.rutong.business.questionnaire.entity.QmPersonalQuestion;
import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import com.rutong.business.questionnaire.entity.QmTemplate;
import com.rutong.business.questionnaire.entity.QmTemplateLibrary;
import com.rutong.business.questionnaire.mapper.QmChapterMapper;
import com.rutong.business.questionnaire.mapper.QmPersonalQuestionMapper;
import com.rutong.business.questionnaire.mapper.QmQuestionLogicMapper;
import com.rutong.business.questionnaire.mapper.QmQuestionMapper;
import com.rutong.business.questionnaire.mapper.QmQuestionOptionMapper;
import com.rutong.business.questionnaire.mapper.QmTemplateLibraryMapper;
import com.rutong.business.questionnaire.pojo.QuestionImportRow;
import com.rutong.business.questionnaire.pojo.QuestionVo;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 问卷模板 业务层
 */
@Service
public class QmTemplateService extends MpBaseService<QmTemplate> {

    @Autowired
    private QmChapterService chapterService;
    @Autowired
    private QmQuestionService questionService;
    @Autowired
    private QmQuestionOptionService optionService;
    @Autowired
    private QmQuestionMapper questionMapper;
    @Autowired
    private QmQuestionOptionMapper questionOptionMapper;
    @Autowired
    private QmQuestionLogicMapper questionLogicMapper;
    @Autowired
    private QmChapterMapper chapterMapper;
    @Autowired
    private QmTemplateLibraryMapper templateLibraryMapper;
    @Autowired
    private QmPersonalQuestionMapper personalQuestionMapper;

    /**
     * 覆盖父类：已发布(PUBLISHED)的模板不可修改，如需调整请新建或归档后重做。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(QmTemplate data) {
        QmTemplate exist = findById(data.getId());
        if (exist != null && QuestionConstants.STATUS_PUBLISHED.equals(exist.getStatus())) {
            throw new ServiceException("已发布的模板不可修改");
        }
        return super.update(data);
    }

    /**
     * 空白创建
     */
    @Transactional(rollbackFor = Exception.class)
    public QmTemplate createBlank(QmTemplate data) {
        data.setSourceType(QuestionConstants.SOURCE_BLANK);
        data.setStatus(QuestionConstants.STATUS_DRAFT);
        insert(data);
        return data;
    }

    /**
     * 模板创建：从行业模板库深拷贝
     */
    @Transactional(rollbackFor = Exception.class)
    public QmTemplate createFromLibrary(Long libId) {
        QmTemplateLibrary lib = templateLibraryMapper.selectById(libId);
        if (lib == null) {
            throw new ServiceException("行业模板不存在");
        }
        QmTemplate t = new QmTemplate();
        t.setTemplateName(lib.getTemplateName());
        t.setCategory(lib.getCategory());
        t.setSourceType(QuestionConstants.SOURCE_TEMPLATE);
        t.setStatus(QuestionConstants.STATUS_DRAFT);
        insert(t);
        if (StringUtils.isNotEmpty(lib.getSnapshot())) {
            restoreSnapshot(t.getId(), lib.getSnapshot());
        }
        return t;
    }

    /**
     * 复制创建：复制已有问卷为基底
     */
    @Transactional(rollbackFor = Exception.class)
    public QmTemplate copyFrom(Long srcId) {
        QmTemplate src = findById(srcId);
        if (src == null) {
            throw new ServiceException("源模板不存在");
        }
        QmTemplate t = new QmTemplate();
        t.setTemplateName(src.getTemplateName() + "_副本");
        t.setCategory(src.getCategory());
        t.setDescription(src.getDescription());
        t.setStyleConfig(src.getStyleConfig());
        t.setSourceType(QuestionConstants.SOURCE_COPY);
        t.setStatus(QuestionConstants.STATUS_DRAFT);
        insert(t);

        // 复制章节：一律新建实例，避免改动"受管"源实体导致 Hibernate "identifier was altered"
        Map<Long, Long> chapterIdMap = new HashMap<>();
        for (QmChapter sc : chapterService.listByTemplate(srcId)) {
            QmChapter c = new QmChapter();
            c.setTemplateId(t.getId());
            c.setChapterName(sc.getChapterName());
            c.setOrderNum(sc.getOrderNum());
            c.setVisible(sc.getVisible());
            chapterService.insert(c);
            chapterIdMap.put(sc.getId(), c.getId());
        }
        // 复制题目 + 选项：新建实例；跨模板题目 ID 变化，逻辑条件会失效，故不复制逻辑
        for (QuestionVo sv : questionService.listVoByTemplate(srcId)) {
            QmQuestion q = new QmQuestion();
            q.setTemplateId(t.getId());
            q.setChapterId(chapterIdMap.get(sv.getChapterId()));
            q.setQuestionType(sv.getQuestionType());
            q.setTitle(sv.getTitle());
            q.setRequired(sv.getRequired());
            q.setOrderNum(sv.getOrderNum());
            q.setMinLen(sv.getMinLen());
            q.setMaxLen(sv.getMaxLen());
            q.setRegex(sv.getRegex());
            q.setPlaceholder(sv.getPlaceholder());
            q.setMaxCount(sv.getMaxCount());
            q.setMaxSize(sv.getMaxSize());
            q.setAccept(sv.getAccept());
            questionService.insert(q);
            List<QmQuestionOption> optClones = new ArrayList<>();
            for (QmQuestionOption so : sv.getOptions()) {
                QmQuestionOption o = new QmQuestionOption();
                o.setOptType(so.getOptType());
                o.setOptLabel(so.getOptLabel());
                o.setOptValue(so.getOptValue());
                o.setOrderNum(so.getOrderNum());
                optClones.add(o);
            }
            optionService.replaceOptions(q.getId(), optClones);
        }
        return t;
    }

    /**
     * 导入创建：从 Excel 导入题目
     */
    @Transactional(rollbackFor = Exception.class)
    public QmTemplate importFromExcel(String templateName, String category, MultipartFile file) {
        if (StringUtils.isEmpty(templateName)) {
            throw new ServiceException("模板名称不能为空");
        }
        List<QuestionImportRow> rows;
        try {
            rows = EasyExcel.read(file.getInputStream()).head(QuestionImportRow.class).sheet().doReadSync();
        } catch (IOException e) {
            throw new ServiceException("解析 Excel 失败：" + e.getMessage());
        }
        if (rows == null || rows.isEmpty()) {
            throw new ServiceException("Excel 中没有可导入的题目");
        }

        QmTemplate t = new QmTemplate();
        t.setTemplateName(templateName);
        t.setCategory(category);
        t.setSourceType(QuestionConstants.SOURCE_IMPORT);
        t.setStatus(QuestionConstants.STATUS_DRAFT);
        insert(t);

        // 按章节名首次出现顺序建章节，题目顺序写入
        Map<String, Long> chapterNameToId = new LinkedHashMap<>();
        int chapterOrder = 0;
        int questionOrder = 0;
        for (QuestionImportRow row : rows) {
            Long chapterId = null;
            if (StringUtils.isNotEmpty(row.getChapterName())) {
                chapterId = chapterNameToId.get(row.getChapterName());
                if (chapterId == null) {
                    QmChapter c = new QmChapter();
                    c.setTemplateId(t.getId());
                    c.setChapterName(row.getChapterName());
                    c.setOrderNum(++chapterOrder);
                    c.setVisible(QuestionConstants.YES);
                    chapterService.insert(c);
                    chapterId = c.getId();
                    chapterNameToId.put(row.getChapterName(), chapterId);
                }
            }
            QuestionVo vo = new QuestionVo();
            String type = normType(row.getQuestionType());
            vo.setTemplateId(t.getId());
            vo.setChapterId(chapterId);
            vo.setQuestionType(type);
            vo.setTitle(row.getTitle());
            vo.setRequired(normRequired(row.getRequired()));
            vo.setOrderNum(++questionOrder);
            vo.setOptions(buildOptions(type, row.getOptions()));
            questionService.saveQuestion(vo);
        }
        return t;
    }

    /**
     * 发布：校验题目非空后置为 PUBLISHED
     */
    @Transactional(rollbackFor = Exception.class)
    public int publish(Long id) {
        QmTemplate t = findById(id);
        if (t == null) {
            throw new ServiceException("模板不存在");
        }
        if (questionService.listByTemplate(id).isEmpty()) {
            throw new ServiceException("模板没有题目，无法发布");
        }
        t.setStatus(QuestionConstants.STATUS_PUBLISHED);
        return update(t);
    }

    /**
     * 归档
     */
    @Transactional(rollbackFor = Exception.class)
    public int archive(Long id) {
        QmTemplate t = findById(id);
        if (t == null) {
            throw new ServiceException("模板不存在");
        }
        t.setStatus(QuestionConstants.STATUS_ARCHIVED);
        return update(t);
    }

    /**
     * 详情：模板 + 章节 + 题目
     */
    public Map<String, Object> detail(Long id) {
        QmTemplate t = findById(id);
        Map<String, Object> result = new HashMap<>();
        result.put("template", t);
        result.put("chapters", chapterService.listByTemplate(id));
        result.put("questions", questionService.listVoByTemplate(id));
        return result;
    }

    /**
     * 删除：级联删除题目选项、题目逻辑、题目、章节，再删模板。
     * MyBatis-Plus 不走数据库外键级联，必须显式清理，否则 option/logic 成为孤儿数据。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteById(Serializable id) {
        cascadeDeleteByTemplateIds(Collections.singleton((Long) id));
        return super.deleteById(id);
    }

    /**
     * 批量删除：同样需级联清理子表（父类默认实现只删模板主表）。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteByIds(Long[] ids) {
        if (ids == null || ids.length == 0) {
            return 0;
        }
        cascadeDeleteByTemplateIds(Arrays.asList(ids));
        return super.deleteByIds(ids);
    }

    /**
     * 按 templateId 集合级联清理：option/logic（按 questionId）→ question → chapter。
     */
    private void cascadeDeleteByTemplateIds(Collection<Long> templateIds) {
        if (templateIds == null || templateIds.isEmpty()) {
            return;
        }
        List<Long> questionIds = questionMapper.selectList(new LambdaQueryWrapper<QmQuestion>()
                        .select(QmQuestion::getId)
                        .in(QmQuestion::getTemplateId, templateIds))
                .stream().map(QmQuestion::getId).collect(Collectors.toList());
        if (!questionIds.isEmpty()) {
            questionOptionMapper.delete(new LambdaQueryWrapper<QmQuestionOption>()
                    .in(QmQuestionOption::getQuestionId, questionIds));
            questionLogicMapper.delete(new LambdaQueryWrapper<QmQuestionLogic>()
                    .in(QmQuestionLogic::getQuestionId, questionIds));
        }
        questionMapper.delete(new LambdaQueryWrapper<QmQuestion>()
                .in(QmQuestion::getTemplateId, templateIds));
        chapterMapper.delete(new LambdaQueryWrapper<QmChapter>()
                .in(QmChapter::getTemplateId, templateIds));
    }

    /**
     * 查询个人题库（收藏的题目）
     */
    public List<QmPersonalQuestion> listPersonalQuestion() {
        return personalQuestionMapper.selectList(new LambdaQueryWrapper<QmPersonalQuestion>()
                .eq(QmPersonalQuestion::getUserId,
                        com.rutong.framework.security.SecurityUtils.getUserId()));
    }

    /**
     * 行业模板库列表
     */
    public List<QmTemplateLibrary> listLibrary() {
        return templateLibraryMapper.selectList(null);
    }

    // ===================== 私有辅助 =====================

    /**
     * 从行业模板快照恢复章节与题目
     */
    private void restoreSnapshot(Long templateId, String snapshot) {
        JSONObject root = JSON.parseObject(snapshot);
        if (root == null) {
            return;
        }
        JSONArray chapters = root.getJSONArray("chapters");
        if (chapters == null) {
            return;
        }
        for (int i = 0; i < chapters.size(); i++) {
            JSONObject ch = chapters.getJSONObject(i);
            QmChapter c = new QmChapter();
            c.setTemplateId(templateId);
            c.setChapterName(ch.getString("chapterName"));
            c.setOrderNum(ch.getInteger("orderNum") == null ? i + 1 : ch.getInteger("orderNum"));
            String visible = ch.getString("visible");
            c.setVisible(StringUtils.isEmpty(visible) ? QuestionConstants.YES : visible);
            chapterService.insert(c);

            JSONArray questions = ch.getJSONArray("questions");
            if (questions == null) {
                continue;
            }
            for (int j = 0; j < questions.size(); j++) {
                JSONObject qo = questions.getJSONObject(j);
                QuestionVo vo = new QuestionVo();
                String type = qo.getString("questionType");
                vo.setTemplateId(templateId);
                vo.setChapterId(c.getId());
                vo.setQuestionType(type);
                vo.setTitle(qo.getString("title"));
                String required = qo.getString("required");
                vo.setRequired(StringUtils.isEmpty(required) ? QuestionConstants.NO : required);
                vo.setOrderNum(qo.getInteger("orderNum") == null ? j + 1 : qo.getInteger("orderNum"));
                vo.setOptions(parseSnapshotOptions(type, qo));
                questionService.saveQuestion(vo);
            }
        }
    }

    private void resetAudit(BaseEntity e) {
        e.setCreateBy(null);
        e.setCreateTime(null);
        e.setUpdateBy(null);
        e.setUpdateTime(null);
    }

    private String normType(String raw) {
        if (StringUtils.isEmpty(raw)) {
            return QuestionConstants.TYPE_TEXT;
        }
        String t = raw.trim().toUpperCase();
        // 兼容中文题型名
        switch (t) {
            case "单选":
            case "单选题":
                return QuestionConstants.TYPE_RADIO;
            case "多选":
            case "多选题":
                return QuestionConstants.TYPE_CHECKBOX;
            case "下拉":
            case "下拉题":
                return QuestionConstants.TYPE_SELECT;
            case "上传":
            case "文件上传":
            case "上传题":
                return QuestionConstants.TYPE_UPLOAD;
            case "说明":
            case "说明题":
            case "描述":
                return QuestionConstants.TYPE_DESCRIPTION;
            case "文本":
            case "单行文本":
            case "单行文本题":
                return QuestionConstants.TYPE_TEXT;
            default:
                return t;
        }
    }

    private String normRequired(String raw) {
        if (StringUtils.isEmpty(raw)) {
            return QuestionConstants.NO;
        }
        String t = raw.trim();
        return "Y".equalsIgnoreCase(t) || "是".equals(t) || "必填".equals(t)
                ? QuestionConstants.YES : QuestionConstants.NO;
    }

    /**
     * 是否为选择题（含选项）
     */
    private boolean isChoiceType(String type) {
        return QuestionConstants.TYPE_RADIO.equals(type)
                || QuestionConstants.TYPE_CHECKBOX.equals(type)
                || QuestionConstants.TYPE_SELECT.equals(type);
    }

    /**
     * 逗号分隔的选项文本 → 选项实体列表
     */
    private List<QmQuestionOption> buildOptions(String type, String optionsCsv) {
        List<QmQuestionOption> list = new ArrayList<>();
        if (!isChoiceType(type) || StringUtils.isEmpty(optionsCsv)) {
            return list;
        }
        int order = 1;
        for (String s : optionsCsv.split("[,，;；]")) {
            if (StringUtils.isEmpty(s)) {
                continue;
            }
            QmQuestionOption o = new QmQuestionOption();
            o.setOptType(QuestionConstants.OPT_OPTION);
            o.setOptLabel(s.trim());
            o.setOptValue(s.trim());
            o.setOrderNum(order++);
            list.add(o);
        }
        return list;
    }

    /**
     * 从旧版快照（optionsConfig 为 JSON 字符串 {options:[...]}）解析选项
     */
    private List<QmQuestionOption> parseSnapshotOptions(String type, JSONObject qo) {
        List<QmQuestionOption> list = new ArrayList<>();
        if (!isChoiceType(type)) {
            return list;
        }
        String oc = qo.getString("optionsConfig");
        if (StringUtils.isEmpty(oc)) {
            return list;
        }
        try {
            JSONArray arr = JSON.parseObject(oc).getJSONArray("options");
            if (arr == null) {
                return list;
            }
            int order = 1;
            for (int k = 0; k < arr.size(); k++) {
                String label = arr.getString(k);
                QmQuestionOption o = new QmQuestionOption();
                o.setOptType(QuestionConstants.OPT_OPTION);
                o.setOptLabel(label);
                o.setOptValue(label);
                o.setOrderNum(order++);
                list.add(o);
            }
        } catch (Exception ignore) {
            // 选项解析失败忽略，题目仍可创建
        }
        return list;
    }
}
