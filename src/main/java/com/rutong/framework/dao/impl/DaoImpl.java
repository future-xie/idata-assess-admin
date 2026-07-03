package com.rutong.framework.dao.impl;

import com.rutong.framework.bean.PageBean;
import com.rutong.framework.dao.IDao;
import com.rutong.framework.dao.objectquery.QueryHelp;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.framework.dao.objectquery.SortUtils;
import com.rutong.framework.security.context.DataScopeContext;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Path;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.metamodel.EntityType;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.hibernate.type.Type;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

@Repository
public class DaoImpl implements IDao {

    @Resource
    private EntityManager entityManager;

    /**
     * 获取 Hibernate Session
     */
    private Session getSession() {
        return entityManager.unwrap(Session.class);
    }

    /**
     * 获取实体的标识符（ID），兼容持久化和游离状态
     */
    @SuppressWarnings("unchecked")
    private <T> Serializable getEntityIdentifier(T t) {
        Object id = entityManager.getEntityManagerFactory().getPersistenceUnitUtil().getIdentifier(t);
        return id != null ? (Serializable) id : null;
    }

    /**
     * 获取实体名称（用于 Hibernate SessionFactory）
     */
    private <T> String getEntityName(Class<T> clazz) {
        EntityType<T> entityType = entityManager.getMetamodel().entity(clazz);
        return entityType.getName();
    }

    // =================== Session 管理 ====================

    @Override
    public void flush() {
        entityManager.flush();
    }

    @Override
    public void clear() {
        entityManager.clear();
    }

    @Override
    public void close() {
        // EntityManager 生命周期由 Spring 管理，无需手动关闭
    }

    @Override
    public Transaction beginTransaction() {
        return getSession().beginTransaction();
    }

    @Override
    public void commit() {
        getSession().getTransaction().commit();
    }

    @Override
    public void rollback() {
        Transaction tx = getSession().getTransaction();
        if (tx != null && tx.isActive()) {
            tx.rollback();
        }
    }

    @Override
    public <T> void refresh(T t) {
        entityManager.refresh(t);
    }

    @Override
    public <T> void evict(T t) {
        getSession().evict(t);
    }

    // =================== 插入操作 ====================

    @Override
    public <T> Serializable save(T t) {
        entityManager.persist(t);
        // 对于 IDENTITY 策略，Hibernate 在 persist 时立即执行 INSERT 并生成 ID
        // 对于 SEQUENCE/TABLE 策略，ID 在 persist 时已从序列/表中获取
        return getEntityIdentifier(t);
    }

    @Override
    public <T> List<Serializable> bulkSave(List<T> ts) {
        if (ts == null || ts.isEmpty()) {
            return Collections.emptyList();
        }
        List<Serializable> result = new ArrayList<>(ts.size());
        for (int i = 0; i < ts.size(); i++) {
            entityManager.persist(ts.get(i));
            result.add(getEntityIdentifier(ts.get(i)));
            // 每 50 条刷写一次，避免内存溢出
            if ((i + 1) % 50 == 0) {
                entityManager.flush();
                entityManager.clear();
            }
        }
        entityManager.flush();
        entityManager.clear();
        return result;
    }

    // =================== 更新操作 ====================

    @Override
    public <T> T update(T t) {
        return entityManager.merge(t);
    }

    @Override
    public <T> T update(T t, String... includeFields) {
        return update(t, true, includeFields);
    }

    @Override
    public <T> T update(T t, boolean ignoredNull, String... includeFields) {
        Session session = getSession();
        Serializable id = getEntityIdentifier(t);

        if (id == null) {
            return entityManager.merge(t);
        }

        @SuppressWarnings("unchecked")
        T existing = (T) session.get(t.getClass(), id);
        if (existing == null) {
            return entityManager.merge(t);
        }

        if (includeFields != null && includeFields.length > 0) {
            // 只更新指定字段
            for (String fieldName : includeFields) {
                copyField(t, existing, fieldName);
            }
        } else if (ignoredNull) {
            // 过滤空值，只更新非空字段
            copyNonNullFields(t, existing, t.getClass());
        } else {
            // 更新所有字段
            copyAllFields(t, existing, t.getClass());
        }

        // existing 是托管状态，修改会在 flush 时自动同步到数据库
        return existing;
    }

    // =================== 删除操作 ====================

    @Override
    public <T> void delete(T t) {
        // 如果实体已脱离管理，先合并再删除
        entityManager.remove(entityManager.contains(t) ? t : entityManager.merge(t));
    }

    @Override
    public <T> int deleteByProperty(Class<T> t, String prop, Object value) {
        String hql = "delete from " + t.getSimpleName() + " where " + prop + " = ?1";
        return executeUpdate(hql, value);
    }

    // =================== HQL 更新/删除 ====================

    @Override
    public int bulkUpdate(String queryString, Object... values) {
        Query<?> query = getSession().createQuery(queryString);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i + 1, values[i]);
            }
        }
        return query.executeUpdate();
    }

    @Override
    public int executeUpdate(String hql, Object... params) {
        Query<?> query = getSession().createQuery(hql);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        return query.executeUpdate();
    }

    // =================== 插入或更新 ====================

    @Override
    public <T> T saveOrUpdate(T t) {
        return entityManager.merge(t);
    }

    @Override
    public <T> T saveOrUpdate(T t, String... includeFields) {
        return saveOrUpdate(t, true, includeFields);
    }

    @Override
    public <T> T saveOrUpdate(T t, boolean ignoredNull, String... includeFields) {
        Serializable id = getEntityIdentifier(t);

        if (id == null) {
            // 新实体，直接持久化
            entityManager.persist(t);
            return t;
        }

        // 已有 ID，执行更新逻辑
        return update(t, ignoredNull, includeFields);
    }

    // =================== 按 ID 查询 ====================

    @Override
    public <T, ID extends Serializable> T findById(Class<T> c, ID id) {
        return entityManager.find(c, id);
    }

    @Override
    public <ID extends Serializable> Object findById(String entityName, ID id) {
        return getSession().get(entityName, id);
    }

    // =================== 按属性查询 ====================

    @Override
    public <T> List<T> findByProperty(Class<T> t, Object... obj) {
        if (obj == null || obj.length < 2) {
            return Collections.emptyList();
        }
        // obj 格式: propertyName1, value1, propertyName2, value2, ...
        StringBuilder hql = new StringBuilder("from ").append(t.getSimpleName()).append(" where 1=1");
        for (int i = 0; i < obj.length - 1; i += 2) {
            hql.append(" and ").append(obj[i]).append(" = ?").append(i / 2 + 1);
        }
        Query<T> query = getSession().createQuery(hql.toString(), t);
        for (int i = 0; i < obj.length - 1; i += 2) {
            query.setParameter(i / 2 + 1, obj[i + 1]);
        }
        return query.getResultList();
    }

    @Override
    public <T> long countByProperty(Class<T> t, Object... obj) {
        if (obj == null || obj.length < 2) {
            CriteriaBuilder cb = entityManager.getCriteriaBuilder();
            CriteriaQuery<Long> cq = cb.createQuery(Long.class);
            Root<T> root = cq.from(t);
            cq.select(cb.count(root));
            return entityManager.createQuery(cq).getSingleResult();
        }
        StringBuilder hql = new StringBuilder("select count(1) from ").append(t.getSimpleName()).append(" where 1=1");
        for (int i = 0; i < obj.length - 1; i += 2) {
            hql.append(" and ").append(obj[i]).append(" = ?").append(i / 2 + 1);
        }
        Query<Long> query = getSession().createQuery(hql.toString(), Long.class);
        for (int i = 0; i < obj.length - 1; i += 2) {
            query.setParameter(i / 2 + 1, obj[i + 1]);
        }
        return query.uniqueResult();
    }

    @Override
    public <T> T findByPropertyFirst(Class<T> t, Object... obj) {
        List<T> list = findByProperty(t, obj);
        return list.isEmpty() ? null : list.get(0);
    }

    // =================== HQL 查询 ====================

    @Override
    public <T> List<T> executeHqlQuery(Class<T> t, String hql, Object... params) {
        Query<T> query = getSession().createQuery(hql, t);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        return query.getResultList();
    }

    @Override
    public <T> T executeHqlCountQuery(Class<T> t, String hql, Object... params) {
        Query<T> query = getSession().createQuery(hql, t);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        return query.uniqueResult();
    }

    /**
     * 带命名集合参数的 HQL 查询，用于 in (:paramName)。
     * 集合参数通过 setParameterList 绑定，确保 Hibernate 正确展开 IN 列表。
     */
    @Override
    public <T> List<T> executeHqlInQuery(Class<T> t, String hql, String paramName, Collection<?> values) {
        Query<T> query = getSession().createQuery(hql, t);
        query.setParameterList(paramName, values);
        return query.getResultList();
    }

    // =================== Criteria 分页查询 ====================

    @Override
    public <T> long count(Class<T> t, Object filters) {
        // 支持 filters 为 HQL 字符串（直接执行）或查询条件对象（Criteria）
        if (filters instanceof String) {
            Query<Long> query = getSession().createQuery((String) filters, Long.class);
            return query.uniqueResult();
        }

        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
        Root<T> root = cq.from(t);
        cq.select(cb.count(root));

        Predicate queryPredicate = filters != null ? QueryHelp.getPredicate(root, filters, cb) : null;
        Predicate dataScopePredicate = buildDataScopePredicate(root, cb);
        cq.where(mergePredicates(cb, queryPredicate, dataScopePredicate));

        return entityManager.createQuery(cq).getSingleResult();
    }

    @Override
    public <T> List<T> queryPage(Class<T> t, PageBean pg, Object filters, List<SortFilter> sorts) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(t);
        Root<T> root = cq.from(t);
        cq.select(root);

        Predicate queryPredicate = filters != null ? QueryHelp.getPredicate(root, filters, cb) : null;
        Predicate dataScopePredicate = buildDataScopePredicate(root, cb);
        cq.where(mergePredicates(cb, queryPredicate, dataScopePredicate));

        if (sorts != null && !sorts.isEmpty()) {
            cq.orderBy(SortUtils.getSorts(cb, root, sorts));
        }

        TypedQuery<T> query = entityManager.createQuery(cq);
        query.setFirstResult(pg.getStart());
        query.setMaxResults(pg.getPageSize());
        return query.getResultList();
    }

    // =================== 查询全部 ====================

    @Override
    public <T> List<T> findAll(Class<T> t) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(t);
        Root<T> root = cq.from(t);
        cq.select(root);
        return entityManager.createQuery(cq).getResultList();
    }

    @Override
    public <T> List<T> findAll(Class<T> t, Object filters, List<SortFilter> sorts) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(t);
        Root<T> root = cq.from(t);
        cq.select(root);

        Predicate queryPredicate = filters != null ? QueryHelp.getPredicate(root, filters, cb) : null;
        Predicate dataScopePredicate = buildDataScopePredicate(root, cb);
        cq.where(mergePredicates(cb, queryPredicate, dataScopePredicate));

        if (sorts != null && !sorts.isEmpty()) {
            cq.orderBy(SortUtils.getSorts(cb, root, sorts));
        }

        return entityManager.createQuery(cq).getResultList();
    }

    // =================== HQL Query 构建 ====================

    // =================== 数据权限过滤 ====================

    /**
     * 构建 DataScope 过滤谓词
     * 从 DataScopeContext（ThreadLocal）读取数据权限配置，生成对应的 JPA Predicate
     *
     * 过滤策略：通过 entity.createBy 反查创建人所属部门，实现部门级数据隔离
     * - 实体不需要包含 dept 字段，只需有 createBy（继承自 BaseEntity）
     * - DataScopeAspect 已根据当前用户角色的 dataScope 解析出允许查看的用户名集合
     * - 此处直接按 createBy IN (用户名集合) 过滤即可
     */
    private <T> Predicate buildDataScopePredicate(Root<T> root, CriteriaBuilder cb) {
        DataScopeContext scope = DataScopeContext.get();
        if (scope == null || scope.isAll()) {
            return null;
        }

        String userAlias = scope.getUserAlias() != null ? scope.getUserAlias() : "createBy";

        // 按用户名列表过滤（本部门/本部门及以下/自定义部门 等场景）
        // DataScopeAspect 已将允许的部门下所有用户名收集到 createByList
        if (scope.getCreateByList() != null && !scope.getCreateByList().isEmpty()) {
            Path<Object> userPath = resolvePathSafely(root, userAlias);
            if (userPath != null) {
                return userPath.in(scope.getCreateByList());
            }
        }

        // 按单一用户名过滤（仅本人场景）
        if (scope.getCreateBy() != null) {
            Path<Object> userPath = resolvePathSafely(root, userAlias);
            if (userPath != null) {
                return cb.equal(userPath, scope.getCreateBy());
            }
        }

        return null;
    }

    /**
     * 安全地根据属性路径解析 JPA Path（支持嵌套属性如 "dept.id"）
     * 如果路径中任何一环不存在，返回 null 而非抛异常
     */
    private <T> Path<Object> resolvePathSafely(Root<T> root, String propertyPath) {
        try {
            String[] parts = propertyPath.split("\\.");
            Path<Object> path = root.get(parts[0]);
            for (int i = 1; i < parts.length; i++) {
                path = path.get(parts[i]);
            }
            return path;
        } catch (IllegalArgumentException e) {
            // 实体不包含该属性（如 SysDept 没有 dept 字段），跳过过滤
            return null;
        }
    }

    /**
     * 合并查询谓词和数据权限谓词
     */
    private Predicate mergePredicates(CriteriaBuilder cb, Predicate... predicates) {
        List<Predicate> valid = new ArrayList<>();
        for (Predicate p : predicates) {
            if (p != null) {
                valid.add(p);
            }
        }
        if (valid.isEmpty()) {
            return null;
        }
        if (valid.size() == 1) {
            return valid.get(0);
        }
        return cb.and(valid.toArray(new Predicate[0]));
    }

    @Override
    public <T> Query<T> getHqlQuery(Class<T> t, String hql, Object[] params1, Map<String, Object> params2) {
        Query<T> query = getSession().createQuery(hql, t);
        if (params1 != null) {
            for (int i = 0; i < params1.length; i++) {
                query.setParameter(i + 1, params1[i]);
            }
        }
        if (params2 != null) {
            for (Map.Entry<String, Object> entry : params2.entrySet()) {
                query.setParameter(entry.getKey(), entry.getValue());
            }
        }
        return query;
    }

    // =================== SQL 原生操作 ====================

    @Override
    public List<Map<String, Object>> executeSQLQuery(String sql, Object... params) {
        return getSession().doReturningWork(connection -> {
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                if (params != null) {
                    for (int i = 0; i < params.length; i++) {
                        ps.setObject(i + 1, params[i]);
                    }
                }
                try (ResultSet rs = ps.executeQuery()) {
                    ResultSetMetaData metaData = rs.getMetaData();
                    int columnCount = metaData.getColumnCount();
                    List<Map<String, Object>> result = new ArrayList<>();
                    while (rs.next()) {
                        Map<String, Object> map = new LinkedHashMap<>();
                        for (int i = 1; i <= columnCount; i++) {
                            String label = metaData.getColumnLabel(i);
                            if (label == null || label.isEmpty()) {
                                label = metaData.getColumnName(i);
                            }
                            map.put(label, rs.getObject(i));
                        }
                        result.add(map);
                    }
                    return result;
                }
            }
        });
    }

    @Override
    public <T> List<T> executeSQLQuery(Class<T> t, String sql, Object... params) {
        NativeQuery<T> query = getSession().createNativeQuery(sql, t);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        return query.getResultList();
    }

    @Override
    public int executeSQLUpdate(String sql, Object... params) {
        NativeQuery<?> query = getSession().createNativeQuery(sql);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        return query.executeUpdate();
    }

    @Override
    public long executeCountSQLQuery(String sql, Object... params) {
        NativeQuery<?> query = getSession().createNativeQuery(sql);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]);
            }
        }
        Object result = query.uniqueResult();
        return result instanceof Number ? ((Number) result).longValue() : 0L;
    }

    // =================== 私有辅助方法 ====================

    /**
     * 复制指定字段的值
     */
    private <T> void copyField(T source, T target, String fieldName) {
        Field field = findField(source.getClass(), fieldName);
        if (field != null) {
            try {
                field.setAccessible(true);
                field.set(target, field.get(source));
            } catch (IllegalAccessException e) {
                throw new RuntimeException("复制字段失败: " + fieldName, e);
            }
        }
    }

    /**
     * 递归复制所有非空字段（包含父类）
     */
    private <T> void copyNonNullFields(T source, T target, Class<?> clazz) {
        if (clazz == null || clazz == Object.class) {
            return;
        }
        for (Field field : clazz.getDeclaredFields()) {
            try {
                field.setAccessible(true);
                Object value = field.get(source);
                if (value != null) {
                    field.set(target, value);
                }
            } catch (IllegalAccessException e) {
                // 跳过无法访问的字段
            }
        }
        copyNonNullFields(source, target, clazz.getSuperclass());
    }

    /**
     * 递归复制所有字段（包含父类）
     */
    private <T> void copyAllFields(T source, T target, Class<?> clazz) {
        if (clazz == null || clazz == Object.class) {
            return;
        }
        for (Field field : clazz.getDeclaredFields()) {
            try {
                field.setAccessible(true);
                field.set(target, field.get(source));
            } catch (IllegalAccessException e) {
                // 跳过无法访问的字段
            }
        }
        copyAllFields(source, target, clazz.getSuperclass());
    }

    /**
     * 在类层次结构中查找字段
     */
    private Field findField(Class<?> clazz, String fieldName) {
        Class<?> current = clazz;
        while (current != null && current != Object.class) {
            try {
                return current.getDeclaredField(fieldName);
            } catch (NoSuchFieldException e) {
                current = current.getSuperclass();
            }
        }
        return null;
    }
}
