package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.cache.CaffeineCache;
import com.rutong.framework.constant.CacheConstants;
import com.rutong.framework.constant.Constants;
import com.rutong.framework.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * 验证码操作处理
 */
@RestController
public class CaptchaController {

    /** 验证码宽度 */
    private static final int WIDTH = 120;
    /** 验证码高度 */
    private static final int HEIGHT = 40;
    /** 验证码位数 */
    private static final int CODE_COUNT = 4;
    /** 干扰线数量 */
    private static final int LINE_COUNT = 6;
    /** 噪点数量 */
    private static final int DOT_COUNT = 50;

    @Autowired
    private CaffeineCache caffeineCache;

    /**
     * 生成验证码
     */
    @GetMapping("/captchaImage")
    public AjaxResult getCode() {
        AjaxResult ajax = AjaxResult.success();

        // 生成随机4位数字验证码
        Random random = new Random();
        StringBuilder codeBuilder = new StringBuilder();
        for (int i = 0; i < CODE_COUNT; i++) {
            codeBuilder.append(random.nextInt(10));
        }
        String captchaCode = codeBuilder.toString();

        // 生成图片
        BufferedImage image = generateImage(captchaCode, random);

        // 转为 Base64
        String base64Img = imageToBase64(image);

        // 唯一标识
        String uuid = IdUtils.fastUUID();
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + uuid;

        // 存入缓存，2分钟过期
        caffeineCache.setCacheObject(verifyKey, captchaCode,
                Constants.CAPTCHA_EXPIRATION, TimeUnit.MINUTES);

        ajax.put("img", base64Img);
        ajax.put("uuid", uuid);
        ajax.put("captchaEnabled", true);
        return ajax;
    }

    /**
     * 生成验证码图片
     */
    private BufferedImage generateImage(String code, Random random) {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // 设置抗锯齿
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        // 1. 填充背景色（浅色系随机）
        g.setColor(new Color(240 + random.nextInt(16), 240 + random.nextInt(16), 240 + random.nextInt(16)));
        g.fillRect(0, 0, WIDTH, HEIGHT);

        // 2. 绘制边框
        g.setColor(Color.LIGHT_GRAY);
        g.drawRect(0, 0, WIDTH - 1, HEIGHT - 1);

        // 3. 绘制干扰线
        for (int i = 0; i < LINE_COUNT; i++) {
            g.setColor(randomColor(random, 150, 200));
            int x1 = random.nextInt(WIDTH);
            int y1 = random.nextInt(HEIGHT);
            int x2 = random.nextInt(WIDTH);
            int y2 = random.nextInt(HEIGHT);
            g.setStroke(new BasicStroke(1.2f));
            g.drawLine(x1, y1, x2, y2);
        }

        // 4. 绘制噪点
        for (int i = 0; i < DOT_COUNT; i++) {
            int x = random.nextInt(WIDTH);
            int y = random.nextInt(HEIGHT);
            image.setRGB(x, y, randomColor(random, 100, 220).getRGB());
        }

        // 5. 绘制验证码数字
        int charWidth = (WIDTH - 20) / CODE_COUNT;
        for (int i = 0; i < code.length(); i++) {
            // 随机颜色（深色系）
            g.setColor(randomColor(random, 20, 130));

            // 随机字体
            String[] fontNames = {"Arial", "Courier New", "Georgia", "Verdana"};
            int fontStyle = random.nextBoolean() ? Font.BOLD : Font.PLAIN;
            int fontSize = 22 + random.nextInt(8);
            g.setFont(new Font(fontNames[random.nextInt(fontNames.length)], fontStyle, fontSize));

            // 计算位置，带随机偏移
            int x = 10 + i * charWidth + random.nextInt(5);
            int y = 28 + random.nextInt(6) - 3;

            // 绘制字符（带轻微旋转）
            Graphics2D g2d = (Graphics2D) g.create();
            double theta = (random.nextDouble() - 0.5) * 0.4; // -0.2 ~ 0.2 弧度
            g2d.rotate(theta, x + charWidth / 2.0, y - fontSize / 2.0);
            g2d.setColor(g.getColor());
            g2d.setFont(g.getFont());
            g2d.drawString(String.valueOf(code.charAt(i)), x, y);
            g2d.dispose();
        }

        g.dispose();
        return image;
    }

    /**
     * 生成随机颜色（指定亮度范围）
     */
    private Color randomColor(Random random, int min, int max) {
        int r = min + random.nextInt(max - min);
        int g = min + random.nextInt(max - min);
        int b = min + random.nextInt(max - min);
        return new Color(r, g, b);
    }

    /**
     * BufferedImage 转 Base64 字符串
     */
    private String imageToBase64(BufferedImage image) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            ImageIO.write(image, "png", baos);
            return Base64.getEncoder().encodeToString(baos.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("验证码图片生成失败", e);
        }
    }
}
