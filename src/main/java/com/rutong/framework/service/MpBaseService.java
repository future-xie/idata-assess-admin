package com.rutong.framework.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.rutong.business.common.entity.BaseEntity;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.mybatis.MpBaseMapper;
import com.rutong.framework.mybatis.objectquery.SortFilter;
import com.rutong.framework.mybatis.objectquery.WrapperBuilder;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

/**
 * MyBatis-Plus 版通用 Service。
 * 保留旧方法签名以兼容 controller：findById/insert/update/deleteById/deleteByIds
 * /findAll/findAllByPage/findAll。
 * 数据权限不再由方法级 @DataScope 处理，改为全局 DataPermissionInterceptor
 * （见 MybatisPlusConfig）按表拦截 create_by；本类的 list 方法对所有表一致，
 * 是否过滤由拦截器按 Mapper 限定名决定。
 * 审计字段由 AutoMetaObjectHandler 自动填充，无需手动 set。
 */
/**
 * 类级 @Transactional 保留为读写事务兜底（避免子类/MP 原生 save·updateById·removeById
 * 直接被调用时丢失事务）。读方法在此显式标注 readOnly=true，让 list/getInfo 等高频查询
 * 走只读事务（Spring 会向驱动下发 readOnly、连接池可优化）；写方法显式声明 rollbackFor
 * 以覆盖默认仅 RuntimeException 回滚的限制。
 */
@Transactional
public abstract class MpBaseService<T extends BaseEntity> extends ServiceImpl<MpBaseMapper<T>, T> {

    @Transactional(readOnly = true)
    public T findById(Serializable id) {
        return getById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    public int insert(T entity) {
        return save(entity) ? 1 : 0;
    }

    /**
     * 不强制写 createBy 的插入（日志等无登录上下文场景）。
     * MP 下由 AutoMetaObjectHandler 处理：无登录用户名时 createBy 留空，与原 insertNoAuth 等效。
     */
    @Transactional(rollbackFor = Exception.class)
    public int insertNoAuth(T entity) {
        return save(entity) ? 1 : 0;
    }

    @Transactional(rollbackFor = Exception.class)
    public int update(T entity) {
        return updateById(entity) ? 1 : 0;
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteById(Serializable id) {
        return removeById(id) ? 1 : 0;
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteByIds(Long[] ids) {
        if (ids == null || ids.length == 0) {
            return 0;
        }
        return removeByIds(Arrays.asList(ids)) ? ids.length : 0;
    }

    @Transactional(readOnly = true)
    public List<T> findAll() {
        return list();
    }

    @Transactional(readOnly = true)
    public TableDataInfo findAllByPage(PageBean page, Object query, List<SortFilter> sorts) {
        QueryWrapper<T> wrapper = WrapperBuilder.build(query,sorts);
        // 数据权限由 DataPermissionInterceptor 在 SQL 层按表统一拦截，此处不再注入
        Page<T> p = page.toPage();
        Page<T> result = page(p, wrapper);
        TableDataInfo rsp = new TableDataInfo();
        rsp.setTotal(result.getTotal());
        rsp.setRows(result.getRecords());
        rsp.setCode(200);
        rsp.setMsg("查询成功");
        return rsp;
    }

    @Transactional(readOnly = true)
    public List<T> findAll(Object query, List<SortFilter> sorts) {
        QueryWrapper<T> wrapper = WrapperBuilder.build(query, sorts);
        return list(wrapper);
    }
}
