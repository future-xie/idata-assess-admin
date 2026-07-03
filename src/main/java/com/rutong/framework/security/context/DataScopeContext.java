package com.rutong.framework.security.context;

import java.util.Set;

/**
 * 数据权限上下文（ThreadLocal）
 * 由 DataScopeAspect 写入，DaoImpl 读取，查询完成后清理
 *
 * 核心字段：createByList — 允许查看的创建人用户名集合
 * 过滤逻辑：entity.createBy IN (createByList)
 */
public class DataScopeContext {

    private static final ThreadLocal<DataScopeContext> CONTEXT = new ThreadLocal<>();

    /** 是否全部数据权限（管理员或 dataScope=1），跳过过滤 */
    private boolean isAll;

    /** 允许的创建人用户名集合（通过部门反查得到），null 表示不限制 */
    private Set<String> createByList;

    /** 仅本人时使用的用户名，非 null 时直接用 equal 而非 in */
    private String createBy;

    /** 实体中表示创建人的字段名，默认 "createBy" */
    private String userAlias;

    public boolean isAll() {
        return isAll;
    }

    public void setAll(boolean all) {
        isAll = all;
    }

    public Set<String> getCreateByList() {
        return createByList;
    }

    public void setCreateByList(Set<String> createByList) {
        this.createByList = createByList;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getUserAlias() {
        return userAlias;
    }

    public void setUserAlias(String userAlias) {
        this.userAlias = userAlias;
    }

    /**
     * 设置当前线程的数据权限上下文
     */
    public static void set(DataScopeContext context) {
        CONTEXT.set(context);
    }

    /**
     * 获取当前线程的数据权限上下文
     */
    public static DataScopeContext get() {
        return CONTEXT.get();
    }

    /**
     * 清除当前线程的数据权限上下文
     */
    public static void clear() {
        CONTEXT.remove();
    }
}
