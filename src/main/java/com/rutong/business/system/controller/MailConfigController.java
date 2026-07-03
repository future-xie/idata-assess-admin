package com.rutong.business.system.controller;

import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.bean.enums.BusinessType;
import com.rutong.framework.annotation.OperLog;
import com.rutong.framework.mail.MailConfigVo;
import com.rutong.framework.mail.MailService;
import com.rutong.framework.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 邮件配置 控制器（前端"邮件配置"页面使用，存储于 sys_config）
 */
@RestController
@RequestMapping("/system/mail")
public class MailConfigController {

    @Autowired
    private MailService mailService;

    /**
     * 读取邮件配置（密码脱敏）
     */
    @PreAuthorize("@ss.hasPermi('system:mail:config')")
    @GetMapping("/config")
    public AjaxResult get() {
        return AjaxResult.success(mailService.getConfig());
    }

    /**
     * 保存邮件配置
     */
    @PreAuthorize("@ss.hasPermi('system:mail:config')")
    @OperLog(title = "邮件配置", businessType = BusinessType.UPDATE)
    @PostMapping("/config")
    public AjaxResult save(@RequestBody MailConfigVo vo) {
        mailService.saveConfig(vo);
        return AjaxResult.success();
    }

    /**
     * 发送测试邮件
     */
    @PreAuthorize("@ss.hasPermi('system:mail:config')")
    @PostMapping("/test")
    public AjaxResult test(@RequestBody Map<String, String> body) {
        String to = body == null ? null : body.get("to");
        if (StringUtils.isEmpty(to)) {
            return AjaxResult.error("请输入收件邮箱");
        }
        mailService.test(to);
        return AjaxResult.success("已尝试发送，若未收到请检查配置");
    }
}
