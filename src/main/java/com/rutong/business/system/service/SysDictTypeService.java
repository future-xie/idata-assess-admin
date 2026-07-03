package com.rutong.business.system.service;

import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.exception.ServiceException;
import com.rutong.framework.utils.DictUtils;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysDictData;
import com.rutong.business.system.entity.SysDictType;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 字典 业务层处理
 *
 * @author ruoyi
 */
@Service
public class SysDictTypeService extends BaseService<SysDictType> {

    /**
     * 项目启动时，初始化字典到缓存
     */
    @PostConstruct
    public void init() {
        loadingDictCache();
    }

    /**
     * 根据所有字典类型
     *
     * @return 字典类型集合信息
     */
    public List<SysDictType> selectDictTypeAll() {
        return dao.findAll(SysDictType.class);
    }

    /**
     * 批量删除字典类型信息
     *
     * @param dictIds 需要删除的字典ID
     */
    @Transactional
    public void deleteDictTypeByIds(Long[] dictIds) {
        for (Long dictId : dictIds) {
            SysDictType dictType = findById(dictId);
            if (dao.countByProperty(SysDictData.class,"dictType.dictType",dictType.getDictType()) > 0) {
                throw new ServiceException(String.format("%1$s已分配,不能删除", dictType.getDictName()));
            }
            super.deleteById(dictId);
            DictUtils.removeDictCache(dictType.getDictType());
        }
    }

    /**
     * 加载字典缓存数据
     */
    public void loadingDictCache() {
        Map<String, List<SysDictData>> dictDataMap = dao.findAll(SysDictData.class).stream().collect(Collectors.groupingBy(s -> s.getDictType().getDictType()));
        for (Map.Entry<String, List<SysDictData>> entry : dictDataMap.entrySet()) {
            DictUtils.setDictCache(entry.getKey(), entry.getValue().stream().sorted(Comparator.comparing(SysDictData::getDictSort)).collect(Collectors.toList()));
        }
    }

    /**
     * 清空字典缓存数据
     */
    public void clearDictCache() {
        DictUtils.clearDictCache();
    }

    /**
     * 重置字典缓存数据
     */
    public void resetDictCache() {
        clearDictCache();
        loadingDictCache();
    }

    /**
     * 新增保存字典类型信息
     *
     * @param dict 字典类型信息
     * @return 结果
     */
    @Transactional
    public int insertDictType(SysDictType dict) {
        int row = super.insert(dict);
        if (row > 0) {
            DictUtils.setDictCache(dict.getDictType(), null);
        }
        return row;
    }

    /**
     * 校验字典类型称是否唯一
     *
     * @param dict 字典类型
     * @return 结果
     */
    public boolean checkDictTypeUnique(SysDictType dict) {
        Long dictId = StringUtils.isNull(dict.getId()) ? -1L : dict.getId();
        SysDictType dictType = dao.findByPropertyFirst(SysDictType.class,"dictType",dict.getDictType());
        if (StringUtils.isNotNull(dictType) && dictType.getId().longValue() != dictId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }


}
