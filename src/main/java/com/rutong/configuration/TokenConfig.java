package com.rutong.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Token 签名密钥配置。
 * <p>
 * 生产环境应通过 {@code jwt.secret}（Base64 编码，长度 ≥ 64 字节）配置固定密钥，
 * 保证重启/发布后已签发的 token 仍然有效；未配置或长度不足时回退为随机密钥
 * （仅开发环境，每次重启所有 token 失效）。
 */
@Configuration
public class TokenConfig {

    private static final Logger log = LoggerFactory.getLogger(TokenConfig.class);

    /** HS512 要求密钥至少 512 位（64 字节） */
    private static final int KEY_LENGTH_BYTES = 64;

    private final SecretKey signingKey;

    public TokenConfig(@Value("${jwt.secret:}") String jwtSecret) {
        byte[] keyBytes;
        if (jwtSecret != null && !jwtSecret.isEmpty()) {
            byte[] decoded;
            try {
                decoded = Base64.getDecoder().decode(jwtSecret);
            } catch (IllegalArgumentException ex) {
                log.warn("jwt.secret 不是合法的 Base64，回退为随机密钥");
                decoded = null;
            }
            if (decoded == null || decoded.length < KEY_LENGTH_BYTES) {
                log.warn("配置的 jwt.secret 解码后不足 {} 字节（HS512 要求），回退为随机密钥（仅开发环境）", KEY_LENGTH_BYTES);
                keyBytes = randomKeyBytes();
            } else {
                keyBytes = decoded;
                log.info("JWT 签名密钥来自配置 jwt.secret（{}字节）", keyBytes.length);
            }
        } else {
            keyBytes = randomKeyBytes();
            log.warn("未配置 jwt.secret，使用随机密钥（每次重启后 token 失效，仅适用于开发环境）");
        }
        this.signingKey = new SecretKeySpec(keyBytes, "HmacSHA512");
    }

    private static byte[] randomKeyBytes() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] keyBytes = new byte[KEY_LENGTH_BYTES];
        secureRandom.nextBytes(keyBytes);
        return keyBytes;
    }

    /**
     * 获取签名密钥
     */
    public SecretKey getSigningKey() {
        return signingKey;
    }
}
