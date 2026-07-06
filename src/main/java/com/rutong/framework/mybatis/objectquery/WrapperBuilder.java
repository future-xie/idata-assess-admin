package com.rutong.framework.mybatis.objectquery;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.rutong.framework.utils.StringUtils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * 将 @Query 注解标注的 Query DTO 反射转为 MyBatis-Plus QueryWrapper。
 * 替代 JPA 的 QueryHelp（输出 Wrapper 而非 Criteria Predicate）。
 * <p>仅实现项目实际使用的 type：EQUAL/NOT_EQUAL/INNER_LIKE/LEFT_LIKE/RIGHT_LIKE
 * /GREATER_THAN/LESS_THAN/LESS_THAN_NQ/IN/BETWEEN/IS_NULL。
 * joinName（关联 join）不支持——MP 无自动 join，需在 Mapper XML 自定义。
 */
public class WrapperBuilder {

    /**
     * 按 query DTO 上的 @Query 注解构建 QueryWrapper。
     *
     * @param query 查询对象（字段标注 @Query），可为 null
     * @param sorts
     */
    public static <T> QueryWrapper<T> build(Object query, List<SortFilter> sorts) {
        QueryWrapper<T> wrapper = new QueryWrapper<>();
        if (query == null) {
            return wrapper;
        }
        for (Field field : getAllFields(query.getClass())) {
            Query q = field.getAnnotation(Query.class);
            if (q == null) {
                continue;
            }
            field.setAccessible(true);
            Object val;
            try {
                val = field.get(query);
            } catch (IllegalAccessException e) {
                continue;
            }
            if (isEmpty(val)) {
                continue;
            }
            String column = camelToSnake(StringUtils.isNotEmpty(q.propName()) ? q.propName() : field.getName());
            if (q.type() == Query.Type.IS_NULL) {
                if((Boolean) val){
                    wrapper.isNull(column);
                }else{
                    wrapper.isNotNull(column);
                }
                continue;
            }
            apply(wrapper, q, column, val);
        }
        if(StringUtils.isNotNull(sorts)){
            applySort(wrapper,sorts);
        }
        return wrapper;
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    /**
     * 将 SortFilter 列表应用到 QueryWrapper（属性名 camelCase → 列名 snake_case）。
     * 抽离自 MpBaseService，便于其他构建 Wrapper 的场景复用排序逻辑。
     */
    public static <T> void applySort(QueryWrapper<T> wrapper, List<SortFilter> sorts) {
        if (sorts == null) {
            return;
        }
        for (SortFilter s : sorts) {
            if (s == null || s.getProperty() == null) {
                continue;
            }
            String col = camelToSnake(s.getProperty());
            // 排序列名直接拼入 ORDER BY，必须校验为合法标识符，防 SQL 注入
            if (!isSafeIdentifier(col)) {
                continue;
            }
            if (SortFilter.DESC.equalsIgnoreCase(s.getDirection())) {
                wrapper.orderByDesc(col);
            } else {
                wrapper.orderByAsc(col);
            }
        }
    }

    private static <T> void apply(QueryWrapper<T> wrapper, Query q, String column, Object val) {
        switch (q.type()) {
            case EQUAL:
                wrapper.eq(column, val);
                break;
            case NOT_EQUAL:
                wrapper.ne(column, val);
                break;
            case INNER_LIKE:
                wrapper.like(column, val.toString());
                break;
            case LEFT_LIKE:
                wrapper.likeLeft(column, val.toString());
                break;
            case RIGHT_LIKE:
                wrapper.likeRight(column, val.toString());
                break;
            case GREATER_THAN:
                wrapper.ge(column, val);
                break;
            case LESS_THAN:
                wrapper.le(column, val);
                break;
            case LESS_THAN_NQ:
                wrapper.lt(column, val);
                break;
            case IN:
                if (val instanceof Collection) {
                    if (!((Collection) val).isEmpty()) {
                        wrapper.in(column, (Collection) val);
                    }
                } else {
                    wrapper.eq(column, val);
                }
                break;
            case BETWEEN:
                if (val instanceof Object[]) {
                    Object[] arr = (Object[]) val;
                    if (arr.length == 2) {
                        wrapper.between(column, arr[0], arr[1]);
                    }
                } else if (val instanceof Collection && ((Collection) val).size() == 2) {
                    Object[] arr = ((Collection) val).toArray();
                    wrapper.between(column, arr[0], arr[1]);
                }
                break;
            default:
                break;
        }
    }

    private static boolean isEmpty(Object val) {
        if (val == null) {
            return true;
        }
        if (val instanceof CharSequence) {
            return StringUtils.isEmpty(val.toString());
        }
        if (val instanceof Collection) {
            return ((Collection<?>) val).isEmpty();
        }
        return false;
    }

    /** 属性名（camelCase）→ 列名（snake_case） */
    public static String camelToSnake(String camel) {
        if (camel == null || camel.isEmpty()) {
            return camel;
        }
        StringBuilder sb = new StringBuilder();
        for (char c : camel.toCharArray()) {
            if (Character.isUpperCase(c)) {
                if (sb.length() > 0) {
                    sb.append('_');
                }
                sb.append(Character.toLowerCase(c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    /** 排序列名合法性校验（防 ORDER BY 注入，仅允许字母开头+字母/数字/下划线） */
    private static boolean isSafeIdentifier(String col) {
        return col != null && col.matches("^[a-zA-Z][a-zA-Z0-9_]*$");
    }

    private static Field[] getAllFields(Class<?> clazz) {
        List<Field> fields = new ArrayList<>();
        while (clazz != null && clazz != Object.class) {
            for (Field f : clazz.getDeclaredFields()) {
                fields.add(f);
            }
            clazz = clazz.getSuperclass();
        }
        return fields.toArray(new Field[0]);
    }
}
