package com.rutong.configuration;

import com.rutong.framework.security.filter.JwtAuthenticationTokenFilter;
import com.rutong.framework.security.handle.AuthenticationEntryPointImpl;
import com.rutong.framework.security.handle.LogoutSuccessHandlerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutFilter;
import org.springframework.web.filter.CorsFilter;

import java.util.Collections;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    /**
     * 退出处理类
     */
    @Autowired
    private LogoutSuccessHandlerImpl logoutSuccessHandler;
    @Autowired
    private JwtAuthenticationTokenFilter authenticationTokenFilter;
    @Autowired
    private AuthenticationEntryPointImpl authenticationEntryPointImpl;
    /**
     * 跨域过滤器
     */
    @Autowired
    private CorsFilter corsFilter;
    /**
     * 自定义用户认证逻辑
     */
    @Autowired
    private UserDetailsService userDetailsService;

    /**
     * 身份验证实现
     */
    @Bean
    public AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(userDetailsService);
        daoAuthenticationProvider.setPasswordEncoder(bCryptPasswordEncoder());
        return new ProviderManager(Collections.singletonList(daoAuthenticationProvider));
    }

    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                // 1. 禁用 CSRF（适用于无状态 API）
                .csrf(csrf -> csrf.disable())

                // 2. 配置 Headers：禁用缓存控制，允许同源 iframe
                .headers(headers -> headers
                        .cacheControl(cache -> cache.disable())
                        .frameOptions(frame -> frame.sameOrigin())
                )

                // 3. 认证入口点（未登录时处理）
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(authenticationEntryPointImpl)
                )

                // 4. 无状态 Session（基于 Token）
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                // 5. 授权规则（使用 authorizeHttpRequests 和 requestMatchers）
                .authorizeHttpRequests(auth -> auth
                        // 允许匿名访问的路径
                        .requestMatchers("/login", "/captchaImage").permitAll()
                        //图片资源
                        .requestMatchers("/profile/**").permitAll()
                        // 前端静态资源放行（打包至 static/，由 Spring Boot 托管，访问根路径即前端首页）
                        .requestMatchers(
                                "/",
                                "/index.html",
                                "/favicon.svg",
                                "/icons.svg",
                                "/assets/**"
                        ).permitAll()
                        // 其他所有请求需要认证
                        .anyRequest().authenticated()
                )

                // 6. 注销配置
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessHandler(logoutSuccessHandler)
                )

                // 7. 添加自定义过滤器
                .addFilterBefore(authenticationTokenFilter, UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(corsFilter, JwtAuthenticationTokenFilter.class)   // 注意：JwtAuthenticationTokenFilter 可能是自定义类
                .addFilterBefore(corsFilter, LogoutFilter.class);

        return httpSecurity.build();
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
