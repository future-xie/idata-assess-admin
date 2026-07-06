package com.rutong.configuration;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.DataPermissionInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.rutong.framework.mybatis.DataPermissionHandlerImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * MyBatis-Plus 配置：
 * 1) DataPermissionInterceptor —— 数据权限（create_by 拦截），须在分页之前注册；
 *    由 {@link DataPermissionHandlerImpl} 按当前用户角色 dataScope 追加条件，仅对配置的表生效。
 * 2) PaginationInnerInterceptor —— 分页（不配置则 page() 返回全表）。
 */
@Configuration
public class MybatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor(DataPermissionHandlerImpl dataPermissionHandler) {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new DataPermissionInterceptor(dataPermissionHandler));
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }
}
