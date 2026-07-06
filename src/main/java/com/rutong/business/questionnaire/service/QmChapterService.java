package com.rutong.business.questionnaire.service;

import com.rutong.business.questionnaire.entity.QmChapter;
import com.rutong.framework.service.MpBaseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 章节 业务层
 */
@Service
public class QmChapterService extends MpBaseService<QmChapter> {

    /**
     * 按模板查询章节
     */
    public List<QmChapter> listByTemplate(Long templateId) {
        return lambdaQuery().eq(QmChapter::getTemplateId, templateId).list();
    }
}
