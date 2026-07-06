package com.rutong.framework.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.rutong.framework.security.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * MyBatis-Plus 审计字段自动填充：insert 填 createBy/createTime/updateBy/updateTime，
 * update 填 updateBy/updateTime。替代旧 BaseService 的手动 set。
 * 仅对实体上标了 @TableField(fill=...) 的字段生效（见 BaseEntity）。
 */
@Component
public class AutoMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        String username = currentUsername();
        Date now = new Date();
        this.strictInsertFill(metaObject, "createBy", String.class, username);
        this.strictInsertFill(metaObject, "createTime", Date.class, now);
        this.strictInsertFill(metaObject, "updateBy", String.class, username);
        this.strictInsertFill(metaObject, "updateTime", Date.class, now);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictUpdateFill(metaObject, "updateBy", String.class, currentUsername());
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
    }

    private String currentUsername() {
        try {
            return SecurityUtils.getUsername();
        } catch (Exception e) {
            return null;
        }
    }
}
