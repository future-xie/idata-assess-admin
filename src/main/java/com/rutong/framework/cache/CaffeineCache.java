package com.rutong.framework.cache;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.RemovalCause;
import com.github.benmanes.caffeine.cache.RemovalListener;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.function.Supplier;
import java.util.stream.Collectors;

/**
 * Caffeine 缓存工具类
 **/
@Slf4j
@Component
public class CaffeineCache {

    /**
     * 默认缓存配置
     */
    private static final long DEFAULT_MAXIMUM_SIZE = 10000L;
    private static final long DEFAULT_EXPIRE_TIME = 24 * 60 * 60L; // 24小时
    private static final TimeUnit DEFAULT_TIME_UNIT = TimeUnit.SECONDS;

    /**
     * 主缓存容器
     * key: 缓存名称，value: Caffeine 缓存实例
     */
    private final Map<String, Cache<String, Object>> cacheMap = new ConcurrentHashMap<>();

    /**
     * 初始化默认缓存
     */
    @PostConstruct
    public void init() {
        // 创建默认缓存
        createCache("default", DEFAULT_MAXIMUM_SIZE, DEFAULT_EXPIRE_TIME, DEFAULT_TIME_UNIT);
        log.info("CaffeineCache 初始化完成");
    }

    /**
     * ==================== 基础缓存操作 ====================
     */

    /**
     * 缓存基本的对象，Integer、String、实体类等（使用默认缓存）
     *
     * @param key   缓存的键值
     * @param value 缓存的值
     */
    public <T> void setCacheObject(final String key, final T value) {
        setCacheObject("default", key, value, DEFAULT_EXPIRE_TIME, DEFAULT_TIME_UNIT);
    }

    /**
     * 缓存基本的对象，Integer、String、实体类等（使用默认缓存）
     *
     * @param key      缓存的键值
     * @param value    缓存的值
     * @param timeout  时间
     * @param timeUnit 时间颗粒度
     */
    public <T> void setCacheObject(final String key, final T value, final long timeout, final TimeUnit timeUnit) {
        setCacheObject("default", key, value, timeout, timeUnit);
    }

    /**
     * 缓存基本的对象到指定缓存
     *
     * @param cacheName 缓存名称
     * @param key       缓存的键值
     * @param value     缓存的值
     * @param timeout   时间
     * @param timeUnit  时间颗粒度
     */
    public <T> void setCacheObject(final String cacheName, final String key, final T value,
                                   final long timeout, final TimeUnit timeUnit) {
        try {
            Cache<String, Object> cache = getOrCreateCache(cacheName, DEFAULT_MAXIMUM_SIZE, timeout, timeUnit);
            cache.put(key, value);
            log.debug("缓存对象成功 - cache: {}, key: {}, timeout: {} {}", cacheName, key, timeout, timeUnit);
        } catch (Exception e) {
            log.error("缓存对象失败 - cache: {}, key: {}", cacheName, key, e);
        }
    }

    /**
     * 判断 key 是否存在（使用默认缓存）
     *
     * @param key 键
     * @return true 存在 false不存在
     */
    public Boolean hasKey(final String key) {
        return hasKey("default", key);
    }

    /**
     * 判断指定缓存中 key 是否存在
     *
     * @param cacheName 缓存名称
     * @param key       键
     * @return true 存在 false不存在
     */
    public Boolean hasKey(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                return cache.getIfPresent(key) != null;
            }
        } catch (Exception e) {
            log.error("判断key是否存在失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return false;
    }

    /**
     * 获得缓存的基本对象（使用默认缓存）
     *
     * @param key 缓存键值
     * @return 缓存键值对应的数据
     */
    public <T> T getCacheObject(final String key) {
        return getCacheObject("default", key);
    }

    /**
     * 获得指定缓存的基本对象
     *
     * @param cacheName 缓存名称
     * @param key       缓存键值
     * @return 缓存键值对应的数据
     */
    @SuppressWarnings("unchecked")
    public <T> T getCacheObject(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                return (T) cache.getIfPresent(key);
            }
        } catch (Exception e) {
            log.error("获取缓存对象失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return null;
    }

    /**
     * 删除单个对象（使用默认缓存）
     *
     * @param key 键
     */
    public boolean deleteObject(final String key) {
        return deleteObject("default", key);
    }

    /**
     * 删除指定缓存中的单个对象
     *
     * @param cacheName 缓存名称
     * @param key       键
     */
    public boolean deleteObject(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                cache.invalidate(key);
                log.debug("删除缓存对象成功 - cache: {}, key: {}", cacheName, key);
                return true;
            }
        } catch (Exception e) {
            log.error("删除缓存对象失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return false;
    }

    /**
     * 删除集合对象（使用默认缓存）
     *
     * @param keys 多个对象键
     * @return 是否成功
     */
    public boolean deleteObject(final Collection<String> keys) {
        return deleteObject("default", keys);
    }

    /**
     * 删除指定缓存中的集合对象
     *
     * @param cacheName 缓存名称
     * @param keys      多个对象键
     * @return 是否成功
     */
    public boolean deleteObject(final String cacheName, final Collection<String> keys) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null && !CollectionUtils.isEmpty(keys)) {
                cache.invalidateAll(keys);
                log.debug("批量删除缓存对象成功 - cache: {}, keys: {}", cacheName, keys.size());
                return true;
            }
        } catch (Exception e) {
            log.error("批量删除缓存对象失败 - cache: {}, keys: {}", cacheName, keys.size(), e);
        }
        return false;
    }

    /**
     * ==================== List 操作 ====================
     */

    /**
     * 缓存List数据（使用默认缓存）
     *
     * @param key      缓存的键值
     * @param dataList 待缓存的List数据
     * @return 缓存的对象
     */
    public <T> long setCacheList(final String key, final List<T> dataList) {
        return setCacheList("default", key, dataList);
    }

    /**
     * 缓存List数据到指定缓存
     *
     * @param cacheName 缓存名称
     * @param key       缓存的键值
     * @param dataList  待缓存的List数据
     * @return 缓存的数量
     */
    public <T> long setCacheList(final String cacheName, final String key, final List<T> dataList) {
        try {
            if (CollectionUtils.isEmpty(dataList)) {
                return 0;
            }
            
            Cache<String, Object> cache = getOrCreateCache(cacheName);
            cache.put(key, new ArrayList<>(dataList));
            log.debug("缓存List成功 - cache: {}, key: {}, size: {}", cacheName, key, dataList.size());
            return dataList.size();
        } catch (Exception e) {
            log.error("缓存List失败 - cache: {}, key: {}", cacheName, key, e);
            return 0;
        }
    }

    /**
     * 获得缓存的list对象（使用默认缓存）
     *
     * @param key 缓存的键值
     * @return 缓存键值对应的数据
     */
    public <T> List<T> getCacheList(final String key) {
        return getCacheList("default", key);
    }

    /**
     * 获得指定缓存的list对象
     *
     * @param cacheName 缓存名称
     * @param key       缓存的键值
     * @return 缓存键值对应的数据
     */
    @SuppressWarnings("unchecked")
    public <T> List<T> getCacheList(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                Object value = cache.getIfPresent(key);
                if (value instanceof List) {
                    return new ArrayList<>((List<T>) value);
                }
            }
        } catch (Exception e) {
            log.error("获取缓存List失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return Collections.emptyList();
    }

    /**
     * ==================== Set 操作 ====================
     */

    /**
     * 缓存Set（使用默认缓存）
     *
     * @param key     缓存键值
     * @param dataSet 缓存的数据
     * @return 缓存的数据对象
     */
    public <T> Set<T> setCacheSet(final String key, final Set<T> dataSet) {
        return setCacheSet("default", key, dataSet);
    }

    /**
     * 缓存Set到指定缓存
     *
     * @param cacheName 缓存名称
     * @param key       缓存键值
     * @param dataSet   缓存的数据
     * @return 缓存的数据对象
     */
    public <T> Set<T> setCacheSet(final String cacheName, final String key, final Set<T> dataSet) {
        try {
            if (CollectionUtils.isEmpty(dataSet)) {
                return Collections.emptySet();
            }
            
            Cache<String, Object> cache = getOrCreateCache(cacheName);
            cache.put(key, new HashSet<>(dataSet));
            log.debug("缓存Set成功 - cache: {}, key: {}, size: {}", cacheName, key, dataSet.size());
            return dataSet;
        } catch (Exception e) {
            log.error("缓存Set失败 - cache: {}, key: {}", cacheName, key, e);
            return Collections.emptySet();
        }
    }

    /**
     * 获得缓存的set（使用默认缓存）
     *
     * @param key 缓存键值
     * @return 缓存的数据
     */
    public <T> Set<T> getCacheSet(final String key) {
        return getCacheSet("default", key);
    }

    /**
     * 获得指定缓存的set
     *
     * @param cacheName 缓存名称
     * @param key       缓存键值
     * @return 缓存的数据
     */
    @SuppressWarnings("unchecked")
    public <T> Set<T> getCacheSet(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                Object value = cache.getIfPresent(key);
                if (value instanceof Set) {
                    return new HashSet<>((Set<T>) value);
                }
            }
        } catch (Exception e) {
            log.error("获取缓存Set失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return Collections.emptySet();
    }

    /**
     * ==================== Map 操作 ====================
     */

    /**
     * 缓存Map（使用默认缓存）
     *
     * @param key     缓存键值
     * @param dataMap 缓存的数据
     */
    public <T> void setCacheMap(final String key, final Map<String, T> dataMap) {
        setCacheMap("default", key, dataMap);
    }

    /**
     * 缓存Map到指定缓存
     *
     * @param cacheName 缓存名称
     * @param key       缓存键值
     * @param dataMap   缓存的数据
     */
    public <T> void setCacheMap(final String cacheName, final String key, final Map<String, T> dataMap) {
        try {
            if (CollectionUtils.isEmpty(dataMap)) {
                return;
            }
            
            Cache<String, Object> cache = getOrCreateCache(cacheName);
            cache.put(key, new HashMap<>(dataMap));
            log.debug("缓存Map成功 - cache: {}, key: {}, size: {}", cacheName, key, dataMap.size());
        } catch (Exception e) {
            log.error("缓存Map失败 - cache: {}, key: {}", cacheName, key, e);
        }
    }

    /**
     * 获得缓存的Map（使用默认缓存）
     *
     * @param key 缓存键值
     * @return 缓存的数据
     */
    public <T> Map<String, T> getCacheMap(final String key) {
        return getCacheMap("default", key);
    }

    /**
     * 获得指定缓存的Map
     *
     * @param cacheName 缓存名称
     * @param key       缓存键值
     * @return 缓存的数据
     */
    @SuppressWarnings("unchecked")
    public <T> Map<String, T> getCacheMap(final String cacheName, final String key) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                Object value = cache.getIfPresent(key);
                if (value instanceof Map) {
                    return new HashMap<>((Map<String, T>) value);
                }
            }
        } catch (Exception e) {
            log.error("获取缓存Map失败 - cache: {}, key: {}", cacheName, key, e);
        }
        return Collections.emptyMap();
    }

    /**
     * 往Hash中存入数据（模拟Redis的Hash操作）
     *
     * @param key   Redis键
     * @param hKey  Hash键
     * @param value 值
     */
    public <T> void setCacheMapValue(final String key, final String hKey, final T value) {
        Map<String, T> map = getCacheMap(key);
        map.put(hKey, value);
        setCacheMap(key, map);
    }

    /**
     * 获取Hash中的数据（模拟Redis的Hash操作）
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
    @SuppressWarnings("unchecked")
    public <T> T getCacheMapValue(final String key, final String hKey) {
        Map<String, T> map = getCacheMap(key);
        return map.get(hKey);
    }

    /**
     * 获取多个Hash中的数据（模拟Redis的Hash操作）
     *
     * @param key   Redis键
     * @param hKeys Hash键集合
     * @return Hash对象集合
     */
    public <T> List<T> getMultiCacheMapValue(final String key, final Collection<String> hKeys) {
        Map<String, T> map = getCacheMap(key);
        return hKeys.stream()
                .map(map::get)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    /**
     * 删除Hash中的某条数据（模拟Redis的Hash操作）
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return 是否成功
     */
    public boolean deleteCacheMapValue(final String key, final String hKey) {
        Map<String, ?> map = getCacheMap(key);
        if (map.containsKey(hKey)) {
            map.remove(hKey);
            setCacheMap(key, map);
            return true;
        }
        return false;
    }

    /**
     * ==================== 高级功能 ====================
     */

    /**
     * 获取或计算缓存值（如果不存在则计算）
     *
     * @param key      缓存键
     * @param supplier 值提供者
     * @return 缓存值
     */
    public <T> T getOrCompute(final String key, final Supplier<T> supplier) {
        return getOrCompute("default", key, supplier, DEFAULT_EXPIRE_TIME, DEFAULT_TIME_UNIT);
    }

    /**
     * 获取或计算缓存值（如果不存在则计算）
     *
     * @param cacheName 缓存名称
     * @param key       缓存键
     * @param supplier  值提供者
     * @param timeout   过期时间
     * @param timeUnit  时间单位
     * @return 缓存值
     */
    @SuppressWarnings("unchecked")
    public <T> T getOrCompute(final String cacheName, final String key, final Supplier<T> supplier,
                              final long timeout, final TimeUnit timeUnit) {
        try {
            Cache<String, Object> cache = getOrCreateCache(cacheName, DEFAULT_MAXIMUM_SIZE, timeout, timeUnit);
            return (T) cache.get(key, k -> supplier.get());
        } catch (Exception e) {
            log.error("获取或计算缓存失败 - cache: {}, key: {}", cacheName, key, e);
            return supplier.get();
        }
    }

    /**
     * 获取所有缓存键（模拟Redis的keys命令）
     * 注意：Caffeine没有直接的keys方法，这里返回缓存的近似键集
     *
     * @param pattern 字符串前缀（暂时只支持前缀匹配）
     * @return 键集合
     */
    public Collection<String> keys(final String pattern) {
        return keys("default", pattern);
    }

    /**
     * 获取指定缓存的所有键
     *
     * @param cacheName 缓存名称
     * @param pattern   匹配模式（前缀匹配，如 "sys_config:*"）；传 null 或 "*" 表示全部
     * @return 键集合
     */
    public Collection<String> keys(final String cacheName, final String pattern) {
        Cache<String, Object> cache = cacheMap.get(cacheName);
        if (cache == null) {
            return Collections.emptyList();
        }
        Set<String> allKeys = cache.asMap().keySet();
        if (pattern == null || "*".equals(pattern)) {
            return allKeys;
        }
        // 只支持前缀匹配：去掉末尾的通配符后用 startsWith
        String prefix = pattern.endsWith("*") ? pattern.substring(0, pattern.length() - 1) : pattern;
        return allKeys.stream()
                .filter(k -> k.startsWith(prefix))
                .collect(Collectors.toList());
    }

    /**
     * 清空指定缓存
     *
     * @param cacheName 缓存名称
     */
    public void clearCache(final String cacheName) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                cache.invalidateAll();
                log.info("清空缓存成功 - cache: {}", cacheName);
            }
        } catch (Exception e) {
            log.error("清空缓存失败 - cache: {}", cacheName, e);
        }
    }

    /**
     * 清空所有缓存
     */
    public void clearAllCache() {
        try {
            cacheMap.values().forEach(Cache::invalidateAll);
            log.info("清空所有缓存成功");
        } catch (Exception e) {
            log.error("清空所有缓存失败", e);
        }
    }

    /**
     * 获取缓存统计信息
     *
     * @param cacheName 缓存名称
     * @return 统计信息字符串
     */
    public String getStats(final String cacheName) {
        try {
            Cache<String, Object> cache = cacheMap.get(cacheName);
            if (cache != null) {
                Cache<String, Object> nativeCache =
                        (Cache<String, Object>) cache;
                return nativeCache.stats().toString();
            }
        } catch (Exception e) {
            log.error("获取缓存统计信息失败 - cache: {}", cacheName, e);
        }
        return "Cache not found";
    }

    /**
     * ==================== 私有方法 ====================
     */

    /**
     * 获取或创建缓存实例（使用默认配置）
     */
    private Cache<String, Object> getOrCreateCache(final String cacheName) {
        return getOrCreateCache(cacheName, DEFAULT_MAXIMUM_SIZE, DEFAULT_EXPIRE_TIME, DEFAULT_TIME_UNIT);
    }

    /**
     * 获取或创建缓存实例
     */
    private Cache<String, Object> getOrCreateCache(final String cacheName,
                                                   final long maximumSize,
                                                   final long expireTime,
                                                   final TimeUnit timeUnit) {
        return cacheMap.computeIfAbsent(cacheName, key -> createCache(key, maximumSize, expireTime, timeUnit));
    }

    /**
     * 创建缓存实例
     */
    private Cache<String, Object> createCache(final String cacheName,
                                              final long maximumSize,
                                              final long expireTime,
                                              final TimeUnit timeUnit) {
        Caffeine<String, Object> caffeine = Caffeine.newBuilder()
                .maximumSize(maximumSize)
                .expireAfterWrite(expireTime, timeUnit)
                .removalListener(new RemovalListener<String, Object>() {
                    @Override
                    public void onRemoval(String key, Object value, RemovalCause cause) {
                        log.debug("缓存移除 - cache: {}, key: {}, cause: {}", cacheName, key, cause);
                    }
                });

        // 如果是长期缓存，则添加访问后过期策略
        if (expireTime > 3600) { // 超过1小时认为是长期缓存
            caffeine.expireAfterAccess(expireTime / 2, timeUnit);
        }

        return caffeine.build();
    }
}