package com.rutong.business.system.service;

import com.rutong.framework.utils.DictUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysDictData;
import com.rutong.business.system.entity.SysDictType;
import com.rutong.framework.utils.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 字典 业务层处理
 *
 * @author ruoyi
 */
@Service
public class SysDictDataService extends BaseService<SysDictData> {

    /**
     * 批量删除字典数据信息
     *
     * @param dictCodes 需要删除的字典数据ID
     */
    @Transactional
    public void deleteDictDataByIds(Long[] dictCodes) {
        for (Long dictCode : dictCodes) {
            SysDictData data = findById(dictCode);
            super.deleteById(dictCode);
            List<SysDictData> dictDatas = dao.findByProperty(SysDictData.class,"dictType",data.getDictType());
            DictUtils.setDictCache(data.getDictType().getDictType(), dictDatas);
        }
    }

    /**
     * 新增保存字典数据信息
     *
     * @param data 字典数据信息
     * @return 结果
     */
    @Transactional
    public int insertDictData(SysDictData data) {
        // 将前端传入的脱管 dictType 替换为托管实体
        if (data.getDictType() != null && data.getDictType().getId() != null) {
            String dictTypeStr = data.getDictType().getDictType();
            SysDictType managed = dao.findById(SysDictType.class, data.getDictType().getId());
            if (managed != null) {
                data.setDictType(managed);
            }
            int row = super.insert(data);
            if (row > 0) {
                String cacheKey = StringUtils.isNotEmpty(dictTypeStr) ? dictTypeStr : managed.getDictType();
                List<SysDictData> dictDatas = dao.findByProperty(SysDictData.class, "dictType.dictType", cacheKey);
                DictUtils.setDictCache(cacheKey, dictDatas);
            }
            return row;
        }
        return super.insert(data);
    }

    /**
     * 修改保存字典数据信息
     *
     * @param data 字典数据信息
     * @return 结果
     */
    @Transactional
    public int updateDictData(SysDictData data) {
        // 将前端传入的脱管 dictType 替换为托管实体
        if (data.getDictType() != null && data.getDictType().getId() != null) {
            String dictTypeStr = data.getDictType().getDictType();
            SysDictType managed = dao.findById(SysDictType.class, data.getDictType().getId());
            if (managed != null) {
                data.setDictType(managed);
            }
            int row = super.update(data);
            if (row > 0) {
                // 优先用已有的 dictType 字符串，否则从托管实体取
                String cacheKey = StringUtils.isNotEmpty(dictTypeStr) ? dictTypeStr : managed.getDictType();
                List<SysDictData> dictDatas = dao.findByProperty(SysDictData.class, "dictType.dictType", cacheKey);
                DictUtils.setDictCache(cacheKey, dictDatas);
            }
            return row;
        }
        return super.update(data);
    }

    public List<SysDictData> loadDictDataList(String dictType) {
        List<SysDictData> dictDatas = DictUtils.getDictCache(dictType);
        if(StringUtils.isEmpty(dictDatas)){
            dictDatas =  dao.findByProperty(SysDictData.class,dictType,"dictType.dictType");
            DictUtils.setDictCache(dictType, dictDatas);
        }
        return dictDatas;
    }
}
