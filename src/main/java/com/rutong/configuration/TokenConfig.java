package com.rutong.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Token 密钥配置
 * 启动时自动生成 HS512 安全密钥，每次重启后之前的 Token 自动失效
 */
@Configuration
public class TokenConfig {

    private static final Logger log = LoggerFactory.getLogger(TokenConfig.class);

    /** HS512 要求密钥至少 512 位（64 字节） */
    private static final int KEY_LENGTH_BYTES = 64;

    private final SecretKey signingKey;

    public TokenConfig() {
        // 启动时随机生成安全密钥
        SecureRandom secureRandom = new SecureRandom();
        byte[] keyBytes = new byte[KEY_LENGTH_BYTES];
        secureRandom.nextBytes(keyBytes);
        this.signingKey = new SecretKeySpec(keyBytes, "HmacSHA512");
        log.info("JWT 签名密钥已动态生成（HS512，{}字节）", KEY_LENGTH_BYTES);
    }

    /**
     * 获取签名密钥
     */
    public SecretKey getSigningKey() {
        return signingKey;
    }
}
