package com.rutong.business.system.service;

import com.rutong.business.system.entity.SysConfig;
import com.rutong.framework.cache.CaffeineCache;
import com.rutong.framework.constant.CacheConstants;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
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
public class SysConfigService extends MpBaseService<SysConfig> {
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
     */
    public String selectConfigByKey(String configKey) {
        String configValue = ConvertStr.toStr(caffeineCache.getCacheObject(getCacheKey(configKey)));
        if (StringUtils.isNotEmpty(configValue)) {
            return configValue;
        }
        SysConfig retConfig = lambdaQuery().eq(SysConfig::getConfigKey, configKey).one();
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
     */
    public boolean checkConfigKeyUnique(SysConfig config) {
        Long configId = StringUtils.isNull(config.getId()) ? -1L : config.getId();
        SysConfig info = lambdaQuery().eq(SysConfig::getConfigKey, config.getConfigKey()).one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != configId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    private String getCacheKey(String configKey) {
        return CacheConstants.SYS_CONFIG_KEY + configKey;
    }

    /**
     * 按键名新增或更新参数值（不存在则新增，存在则覆盖）。
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveOrUpdateByKey(String configKey, String configValue) {
        SysConfig config = lambdaQuery().eq(SysConfig::getConfigKey, configKey).one();
        if (config == null) {
            config = new SysConfig();
            config.setConfigKey(configKey);
            config.setConfigName(configKey);
            config.setConfigType("Y");
            config.setConfigValue(configValue);
            save(config);
        } else {
            config.setConfigValue(configValue);
            updateById(config);
        }
        // 落库后立即刷新该 key 的缓存，否则 selectConfigByKey 会一直命中旧值
        caffeineCache.setCacheObject(getCacheKey(configKey), configValue);
    }

    /**
     * 覆盖父类：更新配置后刷新对应缓存。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(SysConfig config) {
        int rows = super.update(config);
        if (rows > 0) {
            caffeineCache.setCacheObject(getCacheKey(config.getConfigKey()), config.getConfigValue());
        }
        return rows;
    }

    /**
     * 覆盖父类：批量删除配置后重置缓存（删除的 key 仍在缓存里会导致读到已删除值）。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteByIds(Long[] ids) {
        int rows = super.deleteByIds(ids);
        if (rows > 0) {
            resetConfigCache();
        }
        return rows;
    }
}
