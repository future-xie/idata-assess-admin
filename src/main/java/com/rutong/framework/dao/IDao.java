package com.rutong.framework.dao;

import com.rutong.framework.bean.PageBean;
import com.rutong.framework.dao.objectquery.SortFilter;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.query.Query;
import org.hibernate.type.Type;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface IDao {

    /**
     * <b>操作当前线程Session对象</b></br>
     * 刷新数据
     */
    public void flush();

    /**
     * <b>操作当前线程Session对象</b></br>
     * 清除缓存
     */
    public void clear();

    /**
     * <b>当前线程Session对象</b></br>
     * 关闭连接
     */
    public void close();

    /**
     * <b>当前线程Session对象</b></br>
     * 开启事物
     *
     * @return
     */
    public Transaction beginTransaction();

    /**
     * <b>当前线程Session对象</b></br>
     * 提交事物
     */
    public void commit();

    /**
     * <b>当前线程Session对象</b></br>
     * 回滚事物
     */
    public void rollback();

    /**
     * <b>当前线程Session对象</b></br>
     * 刷新对象
     *
     * @param t 实体对象
     */
    public <T> void refresh(T t);

    /**
     * <b>脱离对象和数据库绑定</b></br>
     *
     * @param t 实体对象
     */
    public <T> void evict(T t);

    /**
     * 插入数据
     *
     * @param <T> 实体对象类
     * @param t
     * @return
     */
    public <T> Serializable save(T t);

    /**
     * 批量插入数据
     *
     * @param T: 实体对象类
     * @param ts
     * @return
     */
    public <T> List<Serializable> bulkSave(List<T> ts);

    /**
     * 批量更新
     *
     * @param queryString
     * @param values
     * @return
     */
    public int bulkUpdate(final String queryString, final Object... values);

    /**
     * 修改数据,更新实体对象
     *
     * @param T: 实体对象类
     * @param t
     * @return
     */
    public <T> T update(T t);

    /**
     * 修改数据,更新includeFields中的字段
     *
     * @param <T>
     * @param t             实体对象类
     * @param includeFields 只更新的字段
     * @return
     */
    public <T> T update(T t, String... includeFields);

    /**
     * 修改数据
     *
     * @param t             实体对象类
     * @param ignoredNull   如果设置为TRUE，那么只更新includeFields中的字段
     * @param includeFields 只更新的字段
     * @return
     */
    public <T> T update(T t, boolean ignoredNull, String... includeFields);

    /**
     * 删除数据
     *
     * @param T 实体对象类
     * @param t
     * @return
     */
    public <T> void delete(T t);

    /**
     * 带 ? 参数基础更新操作、支持insert、update、delete三种语句
     *
     * @param hql
     * @param params
     * @return 响应行数
     */
    public int executeUpdate(String hql, Object... params);

    /**
     * 插入或更新,过滤空值更新
     *
     * @param t 实体对象
     * @return 返回当前操作的实体对象, 可以使用当前对象对数据库进行操作
     */
    public <T> T saveOrUpdate(T t);

    /**
     * 插入或更新
     *
     * @param t             实体对象
     * @param includeFields 更新情况下,必须更新的字段,NULL也更新
     * @return 返回当前操作的实体对象, 可以使用当前对象对数据库进行操作
     */
    public <T> T saveOrUpdate(T t, String... includeFields);

    /**
     * 插入或更新
     *
     * @param t             实体对象
     * @param ignoredNull   是否过滤空(缺省为true=过滤)
     * @param includeFields 更新情况下,必须更新的字段,NULL也更新
     * @return 返回当前操作的实体对象, 可以使用当前对象对数据库进行操作
     */
    public <T> T saveOrUpdate(T t, boolean ignoredNull, String... includeFields);

    /**
     * 加载实体对象<如数据库不存在,返回null。 >
     *
     * @param c  实体对象
     * @param id 实体对象主键
     * @return
     */
    public <T, ID extends Serializable> T findById(Class<T> c, ID id);

    /**
     * 加载实体对象<如数据库不存在,返回null。 >
     *
     * @param c          实体对象名称
     * @param id         实体对象主键
     * @param entityName
     * @return
     */
    public <ID extends Serializable> Object findById(String entityName, ID id);

    /**
     * 基础查询，通过实体对象类查询对象列表信息
     *
     * @param t
     * @param obj 参数 格式，usercode,admin,password,admin
     * @return
     */
    public <T> List<T> findByProperty(Class<T> t, Object... obj);

    /**
     * 基础查询，通过实体对象类查询对象数量信息
     *
     * @param <T>
     * @param t
     * @param obj
     * @return
     */
    public <T> long countByProperty(Class<T> t, Object... obj);

    /**
     * 基础查询，通过实体对象类查询对象信息
     *
     * @param t
     * @param obj 参数 格式，usercode,admin,password,admin
     * @return
     */
    public <T> T findByPropertyFirst(Class<T> t, Object... obj);

    /**
     * 带Object参数基础查询
     *
     * @param hql
     * @param params
     * @return List<T>: 每一元素是一个实体对象
     */
    public <T> List<T> executeHqlQuery(Class<T> t, String hql, Object... params);

    /**
     * 总数
     *
     * @param <T>
     * @param t
     * @return
     */
    public <T> long count(Class<T> t, Object filters);

    /**
     * 分页查询list
     *
     * @param <T>
     * @param t
     * @param pg
     * @return
     */
    public <T> List<T> queryPage(Class<T> t, PageBean pg, Object filters, List<SortFilter> sorts);

    /**
     * 根据bean类取得所有记录
     *
     * @param t
     * @return 所有记录列表
     */
    public <T> List<T> findAll(Class<T> t);

    /**
     * 条件查询
     *
     * @param <T>
     * @param t
     * @param filters
     * @param sorts
     * @return
     */
    public <T> List<T> findAll(Class<T> t, Object filters, List<SortFilter> sorts);

    /**
     * 根据ID删除
     *
     * @param <T>
     * @param t
     */
    public <T> int deleteByProperty(Class<T> t, String prop, Object value);


    public <T> Query<T> getHqlQuery(Class<T> t, String hql, Object[] params1, Map<String, Object> params2);

    public <T> T executeHqlCountQuery(Class<T> t, String hql, Object... params);

    /**
     * 带命名集合参数的 HQL 查询，用于 in (:paramName) 场景。
     * 集合参数须用 setParameterList 绑定，不能用 setParameter（否则 Hibernate 不会展开集合）。
     */
    public <T> List<T> executeHqlInQuery(Class<T> t, String hql, String paramName, Collection<?> values);

    //===================sql操作=============================

    /**
     * 基础查询
     *
     * @param sql
     * @param params 数组参数 例如： user.name=?
     * @return List<Map>: 每一元素Map中应一行, Map中的键对应数据库中的字段名
     */
    public List<Map<String, Object>> executeSQLQuery(String sql, Object... params);

    /**
     * 基础查询
     *
     * @param sql
     * @param params 数组参数 例如： user.name=?
     * @return List<Map>: 每一元素Map中应一行, Map中的键对应数据库中的字段名
     */
    public <T> List<T> executeSQLQuery(Class<T> t, String sql, Object... params);

    /**
     * sql更新数据
     *
     * @param sql
     * @param params
     * @return
     */
    public int executeSQLUpdate(String sql, Object... params);

    public long executeCountSQLQuery(String sql, Object... params);

}
