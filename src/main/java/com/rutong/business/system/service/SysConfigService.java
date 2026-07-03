package com.rutong.business.system.service;

import com.rutong.framework.cache.CaffeineCache;
import com.rutong.framework.constant.CacheConstants;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysConfig;
import com.rutong.framework.utils.text.ConvertStr;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * 参数配置 服务层实现
 */
@Service
public class SysConfigService extends BaseService<SysConfig> {
    @Autowired
    private CaffeineCache caffeineCache;

    /**
     * 项目启动时，初始化参数到缓存
     */
    @PostConstruct
    public void init() {
        loadingConfigCache();
    }

    /**
     * 根据键名查询参数配置信息
     *
     * @param configKey 参数key
     * @return 参数键值
     */
    public String selectConfigByKey(String configKey) {
        String configValue = ConvertStr.toStr(caffeineCache.getCacheObject(getCacheKey(configKey)));
        if (StringUtils.isNotEmpty(configValue)) {
            return configValue;
        }
        SysConfig retConfig = dao.findByPropertyFirst(SysConfig.class,"configKey",configKey);
        if (StringUtils.isNotNull(retConfig)) {
            caffeineCache.setCacheObject(getCacheKey(configKey), retConfig.getConfigValue());
            return retConfig.getConfigValue();
        }
        return StringUtils.EMPTY;
    }

    /**
     * 加载参数缓存数据
     */
    public void loadingConfigCache() {
        List<SysConfig> configsList = this.findAll();
        for (SysConfig config : configsList) {
            caffeineCache.setCacheObject(getCacheKey(config.getConfigKey()), config.getConfigValue());
        }
    }

    /**
     * 清空参数缓存数据
     */
    public void clearConfigCache() {
        Collection<String> keys = caffeineCache.keys(CacheConstants.SYS_CONFIG_KEY + "*");
        caffeineCache.deleteObject(keys);
    }

    /**
     * 重置参数缓存数据
     */
    public void resetConfigCache() {
        clearConfigCache();
        loadingConfigCache();
    }

    /**
     * 校验参数键名是否唯一
     *
     * @param config 参数配置信息
     * @return 结果
     */
    public boolean checkConfigKeyUnique(SysConfig config) {
        Long configId = StringUtils.isNull(config.getId()) ? -1L : config.getId();
        SysConfig info = dao.findByPropertyFirst(SysConfig.class,"configKey",config.getConfigKey());
        if (StringUtils.isNotNull(info) && info.getId().longValue() != configId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 设置cache key
     *
     * @param configKey 参数键
     * @return 缓存键key
     */
    private String getCacheKey(String configKey) {
        return CacheConstants.SYS_CONFIG_KEY + configKey;
    }

    /**
     * 按键名新增或更新参数值（不存在则新增，存在则覆盖）。
     * 调用方负责在批量修改后调用 {@link #resetConfigCache()} 刷新缓存。
     */
    @Transactional
    public void saveOrUpdateByKey(String configKey, String configValue) {
        SysConfig config = dao.findByPropertyFirst(SysConfig.class, "configKey", configKey);
        if (config == null) {
            config = new SysConfig();
            config.setConfigKey(configKey);
            config.setConfigName(configKey);
            config.setConfigType("Y");
            config.setConfigValue(configValue);
            dao.save(config);
        } else {
            config.setConfigValue(configValue);
            dao.update(config);
        }
    }

}
