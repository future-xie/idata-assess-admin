package com.rutong.business.questionnaire.service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.rutong.business.common.entity.BaseEntity;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.constant.QuestionConstants;
import com.rutong.business.questionnaire.entity.QmChapter;
import com.rutong.business.questionnaire.entity.QmPersonalQuestion;
import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import com.rutong.business.questionnaire.entity.QmTemplate;
import com.rutong.business.questionnaire.entity.QmTemplateLibrary;
import com.rutong.business.questionnaire.pojo.QuestionImportRow;
import com.rutong.business.questionnaire.pojo.QuestionVo;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 问卷模板 业务层
 */
@Service
public class QmTemplateService extends BaseService<QmTemplate> {

    @Autowired
    private QmChapterService chapterService;
    @Autowired
    private QmQuestionService questionService;
    @Autowired
    private QmQuestionOptionService optionService;

    /**
     * 空白创建
     */
    @Transactional
    public QmTemplate createBlank(QmTemplate data) {
        data.setSourceType(QuestionConstants.SOURCE_BLANK);
        data.setStatus(QuestionConstants.STATUS_DRAFT);
        insert(data);
        return data;
    }

    /**
     * 模板创建：从行业模板库深拷贝
     */
    @Transactional
    public QmTemplate createFromLibrary(Long libId) {
        QmTemplateLibrary lib = dao.findById(QmTemplateLibrary.class, libId);
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
    @Transactional
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
    @Transactional
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
    @Transactional
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
    @Transactional
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
     * 删除：级联删除题目、章节，再删模板
     */
    @Override
    @Transactional
    public int deleteById(Serializable id) {
        dao.deleteByProperty(QmQuestion.class, "templateId", id);
        dao.deleteByProperty(QmChapter.class, "templateId", id);
        return super.deleteById(id);
    }

    /**
     * 查询个人题库（收藏的题目）
     */
    public List<QmPersonalQuestion> listPersonalQuestion() {
        return dao.findByProperty(QmPersonalQuestion.class, "userId",
                com.rutong.framework.security.SecurityUtils.getUserId());
    }

    /**
     * 行业模板库列表
     */
    public List<QmTemplateLibrary> listLibrary() {
        return dao.findAll(QmTemplateLibrary.class);
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
