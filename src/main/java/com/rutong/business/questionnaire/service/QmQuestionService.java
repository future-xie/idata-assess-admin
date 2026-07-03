package com.rutong.business.questionnaire.service;

import com.alibaba.fastjson2.JSON;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.constant.QuestionConstants;
import com.rutong.business.questionnaire.entity.QmPersonalQuestion;
import com.rutong.business.questionnaire.entity.QmQuestion;
import com.rutong.business.questionnaire.entity.QmQuestionLogic;
import com.rutong.business.questionnaire.entity.QmQuestionOption;
import com.rutong.business.questionnaire.pojo.QuestionVo;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.utils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 题目 业务层。
 * 题型配置以结构化字段 + qm_question_option 子表存储（不使用 JSON）。
 */
@Service
public class QmQuestionService extends BaseService<QmQuestion> {

    @Autowired
    private QmQuestionOptionService optionService;

    @Autowired
    private QmQuestionLogicService logicService;

    /**
     * 按模板查询全部题目（按 orderNum 升序），不含选项。
     */
    public List<QmQuestion> listByTemplate(Long templateId) {
        List<QmQuestion> list = dao.findByProperty(QmQuestion.class, "templateId", templateId);
        list.sort(Comparator.comparing(q -> q.getOrderNum() == null ? Integer.MAX_VALUE : q.getOrderNum()));
        return list;
    }

    /**
     * 按模板查询题目（含选项，批量加载避免 N+1），供前端配置/填写回显。
     */
    public List<QuestionVo> listVoByTemplate(Long templateId) {
        return buildVoList(listByTemplate(templateId));
    }

    /**
     * 按章节查询题目（含选项 + 逻辑，批量加载）
     */
    public List<QuestionVo> listVoByChapter(Long chapterId) {
        List<QmQuestion> list = dao.findByProperty(QmQuestion.class, "chapterId", chapterId);
        list.sort(Comparator.comparing(q -> q.getOrderNum() == null ? Integer.MAX_VALUE : q.getOrderNum()));
        return buildVoList(list);
    }

    /**
     * 批量构建 VO（options + logic 子表）
     */
    private List<QuestionVo> buildVoList(List<QmQuestion> list) {
        if (list == null || list.isEmpty()) {
            return new ArrayList<>();
        }
        List<Long> ids = list.stream().map(QmQuestion::getId).collect(Collectors.toList());
        Map<Long, List<QmQuestionOption>> byQuestion = optionService.listByQuestionIds(ids).stream()
                .collect(Collectors.groupingBy(QmQuestionOption::getQuestionId));
        Map<Long, List<QmQuestionLogic>> logicByQuestion = logicService.listByQuestionIds(ids).stream()
                .collect(Collectors.groupingBy(QmQuestionLogic::getQuestionId));
        List<QuestionVo> result = new ArrayList<>();
        for (QmQuestion q : list) {
            result.add(toVo(q, byQuestion.get(q.getId()), logicByQuestion.get(q.getId())));
        }
        return result;
    }

    /**
     * 题目详情（含选项）
     */
    public QuestionVo getVo(Long id) {
        return toVo(findById(id), optionService.listByQuestion(id), logicService.listByQuestion(id));
    }

    /**
     * 新增题目（含选项）
     */
    @Transactional
    public QuestionVo saveQuestion(QuestionVo vo) {
        QmQuestion q = toEntity(vo);
        q.setId(null);
        insert(q);
        optionService.replaceOptions(q.getId(), vo.getOptions());
        logicService.replaceLogic(q.getId(), vo.getLogic());
        return getVo(q.getId());
    }

    /**
     * 修改题目（含选项）
     */
    @Transactional
    public QuestionVo updateQuestionVo(QuestionVo vo) {
        QmQuestion q = toEntity(vo);
        update(q);
        optionService.replaceOptions(q.getId(), vo.getOptions());
        logicService.replaceLogic(q.getId(), vo.getLogic());
        return getVo(q.getId());
    }

    /**
     * 拖拽排序 / 跨章节移动：批量更新 chapterId 与 orderNum（不动选项）。
     * 入参为全量顺序快照 [{id, chapterId, orderNum}]，由前端按显示顺序计算后提交。
     */
    @Transactional
    public int reorder(List<QmQuestion> items) {
        if (items == null || items.isEmpty()) {
            return 0;
        }
        for (QmQuestion patch : items) {
            if (patch == null || patch.getId() == null) {
                continue;
            }
            // 入参可能是 QuestionVo（未映射子类）实例，构造真实 QmQuestion 再更新，
            // 避免 Hibernate "Unable to locate persister: QuestionVo"
            QmQuestion p = new QmQuestion();
            p.setId(patch.getId());
            p.setChapterId(patch.getChapterId());
            p.setOrderNum(patch.getOrderNum());
            dao.update(p, "chapterId", "orderNum");
        }
        return items.size();
    }

    /**
     * 复制题目（含选项）到同模板末尾
     */
    @Transactional
    public QuestionVo copy(Long id) {
        QmQuestion source = findById(id);
        if (source == null) {
            throw new RuntimeException("题目不存在");
        }
        // 新建实例（不改动受管的 source），避免 Hibernate "identifier was altered"
        QmQuestion q = new QmQuestion();
        q.setTemplateId(source.getTemplateId());
        q.setChapterId(source.getChapterId());
        q.setQuestionType(source.getQuestionType());
        q.setTitle(source.getTitle());
        q.setRequired(source.getRequired());
        q.setOrderNum(nextOrderNum(source.getTemplateId()));
        q.setMinLen(source.getMinLen());
        q.setMaxLen(source.getMaxLen());
        q.setRegex(source.getRegex());
        q.setPlaceholder(source.getPlaceholder());
        q.setMaxCount(source.getMaxCount());
        q.setMaxSize(source.getMaxSize());
        q.setAccept(source.getAccept());
        insert(q); // insert 写 createBy 等审计字段
        // 克隆选项
        List<QmQuestionOption> opts = optionService.listByQuestion(id);
        List<QmQuestionOption> clones = new ArrayList<>();
        for (QmQuestionOption o : opts) {
            QmQuestionOption c = new QmQuestionOption();
            c.setOptType(o.getOptType());
            c.setOptLabel(o.getOptLabel());
            c.setOptValue(o.getOptValue());
            c.setOrderNum(o.getOrderNum());
            clones.add(c);
        }
        optionService.replaceOptions(q.getId(), clones);
        // 克隆逻辑规则
        List<QmQuestionLogic> srcLogic = logicService.listByQuestion(id);
        List<QmQuestionLogic> logicClones = new ArrayList<>();
        for (QmQuestionLogic l : srcLogic) {
            QmQuestionLogic c = new QmQuestionLogic();
            c.setCondQuestionId(l.getCondQuestionId());
            c.setOp(l.getOp());
            c.setCondValue(l.getCondValue());
            c.setAction(l.getAction());
            logicClones.add(c);
        }
        logicService.replaceLogic(q.getId(), logicClones);
        return getVo(q.getId());
    }

    /**
     * 收藏题目到个人题库（题目 + 选项 生成 JSON 快照）
     */
    @Transactional
    public int collectToPersonal(Long id) {
        QuestionVo vo = getVo(id);
        if (vo == null || vo.getId() == null) {
            throw new RuntimeException("题目不存在");
        }
        QmPersonalQuestion pq = new QmPersonalQuestion();
        pq.setUserId(SecurityUtils.getUserId());
        pq.setQuestionSnapshot(JSON.toJSONString(vo));
        dao.save(pq);
        return 1;
    }

    /**
     * 删除题目：级联删除其选项
     */
    @Override
    @Transactional
    public int deleteById(Serializable id) {
        optionService.deleteByQuestion((Long) id);
        logicService.deleteByQuestion((Long) id);
        return super.deleteById(id);
    }

    /**
     * 新增时默认必填、排序
     */
    @Override
    public int insert(QmQuestion data) {
        if (data.getRequired() == null) {
            data.setRequired(QuestionConstants.NO);
        }
        if (data.getOrderNum() == null) {
            data.setOrderNum(nextOrderNum(data.getTemplateId()));
        }
        return super.insert(data);
    }

    // ===================== 私有辅助 =====================

    /**
     * 将 QuestionVo 拷贝为真实 QmQuestion 实体。
     * QuestionVo 虽继承 QmQuestion，但本身未作为 @Entity 映射，
     * 直接持久化会触发 Hibernate "Unable to locate persister: QuestionVo"。
     */
    private QmQuestion toEntity(QuestionVo vo) {
        QmQuestion q = new QmQuestion();
        try {
            BeanUtils.copyProperties(q, vo);
        } catch (Exception e) {
            throw new RuntimeException("题目视图转换失败", e);
        }
        return q;
    }

    private QuestionVo toVo(QmQuestion q, List<QmQuestionOption> opts, List<QmQuestionLogic> logic) {
        if (q == null) {
            return null;
        }
        QuestionVo vo = new QuestionVo();
        try {
            BeanUtils.copyProperties(vo, q);
        } catch (Exception e) {
            throw new RuntimeException("题目视图转换失败", e);
        }
        vo.setOptions(opts == null ? new ArrayList<>() : opts);
        vo.setLogic(logic == null ? new ArrayList<>() : logic);
        return vo;
    }

    private Integer nextOrderNum(Long templateId) {
        List<QmQuestion> list = dao.findByProperty(QmQuestion.class, "templateId", templateId);
        int max = 0;
        for (QmQuestion q : list) {
            if (q.getOrderNum() != null && q.getOrderNum() > max) {
                max = q.getOrderNum();
            }
        }
        return max + 1;
    }
}
