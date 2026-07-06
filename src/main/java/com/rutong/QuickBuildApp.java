package com.rutong;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.rutong.business.**.mapper")
public class QuickBuildApp {
    public static void main(String[] args) {
        SpringApplication.run(QuickBuildApp.class,args);
    }
}
