package com.rutong.configuration;

import com.rutong.framework.constant.Constants;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/profile/**").addResourceLocations("file:" + ApplicationConfig.ATTACH_DIR_PATH);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(globalKeyInterceptor).addPathPatterns("/**");
//		registry.addInterceptor(appLoginInterceptor).addPathPatterns("/app/**").excludePathPatterns("/app/update/getVersion","/app/auth/login","/app/config/getByKey");
//		registry.addInterceptor(queryLimiterInterceptor).addPathPatterns("/app/**");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // 访问根路径重定向到前端入口 index.html（由 Spring Boot 从 static/ 托管）
        registry.addRedirectViewController("/", "/index.html");
    }


    /**
     * 跨域配置
     */
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        // 设置访问源地址
        config.addAllowedOrigin("*");
        // 设置访问源请求头
        config.addAllowedHeader("*");
        // 设置访问源请求方法
        config.addAllowedMethod("*");
        // 有效期 1800秒
        config.setMaxAge(1800L);
        // 添加映射路径，拦截一切请求
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        // 返回新的CorsFilter
        return new CorsFilter(source);
    }

    // 为定时任务单独创建一个调度器
    @Bean(name = "scheduledTaskScheduler")
    @Primary  // 标记为主要调度器，这样@Scheduled会默认使用它
    public TaskScheduler scheduledTaskScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(100);
        scheduler.setThreadNamePrefix("scheduled-task-");
        scheduler.initialize();
        return scheduler;
    }
}
