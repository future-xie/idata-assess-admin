package com.rutong.framework.mail;

import com.rutong.business.system.service.SysConfigService;
import com.rutong.framework.manager.AsyncManager;
import com.rutong.framework.utils.StringUtils;
import jakarta.annotation.Resource;
import jakarta.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.Properties;
import java.util.TimerTask;

/**
 * 邮件服务。
 * <p>
 * 配置存储于 {@code sys_config}（键前缀 {@code mail.*}），由前端"邮件配置"页面维护，
 * 不再读取 application.yml。每次发送时按当前配置动态构造 {@link JavaMailSender}。
 * <p>
 * 当 {@code mail.enabled != true} 或未配置 host 时，{@link #send} 仅记录日志，不实际发送。
 */
@Service
public class MailService {

    private static final Logger log = LoggerFactory.getLogger(MailService.class);

    private static final String MASK = "******";

    @Resource
    private SysConfigService sysConfigService;

    // ===================== 配置读写 =====================

    /**
     * 读取邮件配置（密码脱敏）
     */
    public MailConfigVo getConfig() {
        MailConfigVo vo = new MailConfigVo();
        vo.setEnabled(bool("mail.enabled"));
        vo.setHost(cfg("mail.host"));
        vo.setPort(parseInt(cfg("mail.port"), 465));
        vo.setUsername(cfg("mail.username"));
        String pwd = cfg("mail.password");
        vo.setPassword(StringUtils.isEmpty(pwd) ? "" : MASK);
        vo.setSsl(bool("mail.ssl"));
        vo.setFrom(cfg("mail.from"));
        vo.setFromName(getFromName());
        vo.setFrontUrl(getFrontUrl());
        return vo;
    }

    /**
     * 保存邮件配置到 sys_config（密码为脱敏占位或空时保留原值），并刷新缓存。
     */
    public void saveConfig(MailConfigVo vo) {
        if (vo.getEnabled() != null) {
            sysConfigService.saveOrUpdateByKey("mail.enabled", vo.getEnabled().toString());
        }
        if (vo.getHost() != null) {
            sysConfigService.saveOrUpdateByKey("mail.host", vo.getHost());
        }
        if (vo.getPort() != null) {
            sysConfigService.saveOrUpdateByKey("mail.port", vo.getPort().toString());
        }
        if (vo.getUsername() != null) {
            sysConfigService.saveOrUpdateByKey("mail.username", vo.getUsername());
        }
        String pwd = vo.getPassword();
        if (pwd != null && !pwd.isEmpty() && !MASK.equals(pwd)) {
            sysConfigService.saveOrUpdateByKey("mail.password", pwd);
        }
        if (vo.getSsl() != null) {
            sysConfigService.saveOrUpdateByKey("mail.ssl", vo.getSsl().toString());
        }
        if (vo.getFrom() != null) {
            sysConfigService.saveOrUpdateByKey("mail.from", vo.getFrom());
        }
        if (vo.getFromName() != null) {
            sysConfigService.saveOrUpdateByKey("mail.fromName", vo.getFromName());
        }
        if (vo.getFrontUrl() != null) {
            sysConfigService.saveOrUpdateByKey("mail.frontUrl", vo.getFrontUrl());
        }
        sysConfigService.resetConfigCache();
    }

    /**
     * 发送测试邮件
     */
    public void test(String to) {
        send(to, "【" + getFromName() + "】邮件测试",
                "<p>这是一封来自「" + getFromName() + "」的测试邮件，收到即表示邮件配置正确。</p>");
    }

    // ===================== 业务取值 =====================

    public boolean isEnabled() {
        return bool("mail.enabled");
    }

    public String getFrontUrl() {
        String v = cfg("mail.frontUrl");
        return StringUtils.isEmpty(v) ? "http://localhost:3000" : v;
    }

    public String getFromName() {
        String v = cfg("mail.fromName");
        return StringUtils.isEmpty(v) ? "数据合规管理后台" : v;
    }

    // ===================== 发送 =====================

    /**
     * 同步发送 HTML 邮件。失败仅记录日志、不抛异常。
     */
    public void send(String to, String subject, String html) {
        if (!isEnabled()) {
            log.info("[邮件未启用] to={} subject={}", to, subject);
            return;
        }
        if (StringUtils.isEmpty(to)) {
            log.warn("[邮件跳过] 收件人为空 subject={}", subject);
            return;
        }
        if (StringUtils.isEmpty(cfg("mail.host"))) {
            log.warn("[邮件未配置] 未配置 SMTP 主机，跳过发送 subject={}", subject);
            return;
        }
        try {
            JavaMailSenderImpl sender = buildSender();
            MimeMessage message = sender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
            helper.setFrom(cfg("mail.from"), getFromName());
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(html, true);
            sender.send(message);
            log.info("[邮件已发送] to={} subject={}", to, subject);
        } catch (Exception e) {
            log.error("[邮件发送失败] to={} subject={} err={}", to, subject, e.getMessage(), e);
        }
    }

    /**
     * 异步发送（经 AsyncManager 调度线程池）
     */
    public void sendAsync(String to, String subject, String html) {
        AsyncManager.me().execute(new TimerTask() {
            @Override
            public void run() {
                send(to, subject, html);
            }
        });
    }

    // ===================== 私有辅助 =====================

    /**
     * 按当前 sys_config 配置构造 JavaMailSender
     */
    private JavaMailSenderImpl buildSender() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost(cfg("mail.host"));
        sender.setPort(parseInt(cfg("mail.port"), 465));
        sender.setUsername(cfg("mail.username"));
        sender.setPassword(cfg("mail.password"));
        sender.setDefaultEncoding("UTF-8");
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        if (bool("mail.ssl")) {
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        } else {
            props.put("mail.smtp.starttls.enable", "true");
        }
        sender.setJavaMailProperties(props);
        return sender;
    }

    private String cfg(String key) {
        return sysConfigService.selectConfigByKey(key);
    }

    private boolean bool(String key) {
        return "true".equalsIgnoreCase(cfg(key));
    }

    private int parseInt(String s, int def) {
        if (StringUtils.isEmpty(s)) {
            return def;
        }
        try {
            return Integer.parseInt(s.trim());
        } catch (NumberFormatException e) {
            return def;
        }
    }
}
