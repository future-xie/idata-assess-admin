package com.rutong.framework.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 数据权限过滤注解
 * 标注在 Service 查询方法上，自动根据当前用户角色的 dataScope 过滤数据
 *
 * 过滤逻辑：根据角色的 dataScope 解析出允许的部门 → 查询这些部门下的用户名 → 按 createBy 过滤
 *
 * dataScope 规则：
 * 1 = 全部数据权限
 * 2 = 自定义数据权限（通过 sys_role_dept 关联）
 * 3 = 本部门数据权限
 * 4 = 本部门及以下数据权限
 * 5 = 仅本人数据权限
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface DataScope {
    /**
     * 实体中表示创建人的字段名，默认 "createBy"（对应 BaseEntity.createBy）
     */
    String userAlias() default "createBy";
}
