package com.rutong.business.questionnaire.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.questionnaire.entity.QmChapter;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 章节 业务层
 */
@Service
public class QmChapterService extends BaseService<QmChapter> {

    /**
     * 按模板查询章节
     */
    public List<QmChapter> listByTemplate(Long templateId) {
        return dao.findByProperty(QmChapter.class, "templateId", templateId);
    }
}
