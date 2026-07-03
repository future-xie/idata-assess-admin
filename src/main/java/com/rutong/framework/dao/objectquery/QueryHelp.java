package com.rutong.framework.dao.objectquery;

import com.rutong.framework.utils.StringUtils;
import jakarta.persistence.criteria.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.util.*;

@SuppressWarnings({"unchecked","all"})
public class QueryHelp {
	private static Logger log = LoggerFactory.getLogger(QueryHelp.class);

    public static <R, Q> Predicate getPredicate(Root<R> root, Q query, CriteriaBuilder cb) {
        List<Predicate> list = new ArrayList<>();
        if(query == null){
            return cb.and(list.toArray(new Predicate[0]));
        }
        try {
            List<Field> fields = getAllFields(query.getClass(), new ArrayList<>());
            Map<String, List<Predicate>> orGroups = new HashMap<>(); // 存储OR分组

            for (Field field : fields) {
                boolean accessible = field.isAccessible();
                // 设置对象的访问权限，保证对private的属性的访
                field.setAccessible(true);
                Query q = field.getAnnotation(Query.class);
                if (q != null) {
                    String propName = q.propName();
                    String joinName = q.joinName();
                    String blurry = q.blurry();
                    String orGroup = q.orGroup(); // 获取OR分组
                    String attributeName = isBlank(propName) ? field.getName() : propName;
                    Class<?> fieldType = field.getType();
                    Object val = field.get(query);
                    if (val == null || "".equals(val)) {
                        continue;
                    }
                    Join join = null;
                    // 模糊多字段
                    if (StringUtils.isNotEmpty(blurry)) {
                        String[] blurrys = blurry.split(",");
                        List<Predicate> orPredicate = new ArrayList<>();
                        for (String s : blurrys) {
                            orPredicate.add(cb.like(root.get(s)
                                    .as(String.class), "%" + val.toString() + "%"));
                        }
                        Predicate[] p = new Predicate[orPredicate.size()];
                        if (StringUtils.isEmpty(orGroup)) {
                            list.add(cb.or(orPredicate.toArray(p)));
                        } else {
                            orGroups.computeIfAbsent(orGroup, k -> new ArrayList<>())
                                    .add(cb.or(orPredicate.toArray(p)));
                        }
                        continue;
                    }
                    if (StringUtils.isNotEmpty(joinName)) {
                        String[] joinNames = joinName.split(">");
                        for (String name : joinNames) {
                            switch (q.join()) {
                                case LEFT:
                                    if(StringUtils.isNotNull(join) && StringUtils.isNotNull(val)){
                                        join = join.join(name, JoinType.LEFT);
                                    } else {
                                        join = root.join(name, JoinType.LEFT);
                                    }
                                    break;
                                case RIGHT:
                                    if(StringUtils.isNotNull(join) && StringUtils.isNotNull(val)){
                                        join = join.join(name, JoinType.RIGHT);
                                    } else {
                                        join = root.join(name, JoinType.RIGHT);
                                    }
                                    break;
                                case INNER:
                                    if(StringUtils.isNotNull(join) && StringUtils.isNotNull(val)){
                                        join = join.join(name, JoinType.INNER);
                                    } else {
                                        join = root.join(name, JoinType.INNER);
                                    }
                                    break;
                                default: break;
                            }
                        }
                    }
                    // 根据查询类型构建谓词
                    Predicate predicate = buildPredicate(q, root, cb, attributeName, join, fieldType, val);
                    if (predicate != null) {
                        // 如果有OR分组，放入对应分组；否则直接添加到AND列表
                        if (StringUtils.isNotEmpty(orGroup)) {
                            orGroups.computeIfAbsent(orGroup, k -> new ArrayList<>()).add(predicate);
                        } else {
                            list.add(predicate);
                        }
                    }
                }
                field.setAccessible(accessible);
            }

            // 处理OR分组：每个分组内的条件用OR连接，然后放入AND列表
            for (List<Predicate> orGroupPredicates : orGroups.values()) {
                if (!orGroupPredicates.isEmpty()) {
                    list.add(cb.or(orGroupPredicates.toArray(new Predicate[0])));
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        int size = list.size();
        return cb.and(list.toArray(new Predicate[size]));
    }

    private static <R> Predicate buildPredicate(Query q, Root<R> root, CriteriaBuilder cb,
                                                String attributeName, Join join,
                                                Class<?> fieldType, Object val) {
        Expression<?> expression = getExpression(attributeName, join, root);
        switch (q.type()) {
            case EQUAL:
                return cb.equal(getExpression(attributeName,join,root)
                        .as((Class<? extends Comparable>) fieldType),val);
            case GREATER_THAN:
                return cb.greaterThanOrEqualTo(getExpression(attributeName,join,root)
                        .as((Class<? extends Comparable>) fieldType), (Comparable) val);
            case LESS_THAN:
                return cb.lessThanOrEqualTo(getExpression(attributeName,join,root)
                        .as((Class<? extends Comparable>) fieldType), (Comparable) val);
            case LESS_THAN_NQ:
                return cb.lessThan(getExpression(attributeName,join,root)
                        .as((Class<? extends Comparable>) fieldType), (Comparable) val);
            case INNER_LIKE:
                return cb.like(getExpression(attributeName,join,root)
                        .as(String.class), "%" + val.toString() + "%");
            case LEFT_LIKE:
                return cb.like(getExpression(attributeName,join,root)
                        .as(String.class), "%" + val.toString());
            case RIGHT_LIKE:
                return cb.like(getExpression(attributeName,join,root)
                        .as(String.class), val.toString() + "%");
            case IN:
                if (StringUtils.isNotEmpty((Collection<Long>)val)) {
                    return getExpression(attributeName,join,root).in((Collection<Long>) val);
                }
                return null;
            case NOT_EQUAL:
                return cb.notEqual(getExpression(attributeName,join,root), val);
            case IS_NULL:
                if(Boolean.parseBoolean(val.toString())){
                    Predicate predicate = cb.isNull(getExpression(attributeName,join,root));
                    return predicate;
                }else{
                    return cb.isNotNull(getExpression(attributeName,join,root));
                }
            case BETWEEN:
                List<Object> between = new ArrayList<>((List<Object>)val);
                return cb.between(getExpression(attributeName, join, root).as((Class<? extends Comparable>) between.get(0).getClass()),
                        (Comparable) between.get(0), (Comparable) between.get(1));
            default: {
                return null;
            }
        }
    }

    @SuppressWarnings("unchecked")
    private static <T, R> Expression<T> getExpression(String attributeName, Join join, Root<R> root) {
        if (StringUtils.isNotNull(join)) {
            return join.get(attributeName);
        } else {
            return root.get(attributeName);
        }
    }

    private static boolean isBlank(final CharSequence cs) {
        int strLen;
        if (cs == null || (strLen = cs.length()) == 0) {
            return true;
        }
        for (int i = 0; i < strLen; i++) {
            if (!Character.isWhitespace(cs.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public static List<Field> getAllFields(Class clazz, List<Field> fields) {
        if (clazz != null) {
            fields.addAll(Arrays.asList(clazz.getDeclaredFields()));
            getAllFields(clazz.getSuperclass(), fields);
        }
        return fields;
    }
}
