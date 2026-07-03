package com.rutong.framework.mail;

import lombok.Data;

/**
 * 邮件配置视图对象（存储于 sys_config，前端可编辑）。
 */
@Data
public class MailConfigVo {

    /** 是否启用 */
    private Boolean enabled;

    /** SMTP 主机 */
    private String host;

    /** SMTP 端口 */
    private Integer port;

    /** SMTP 账号 */
    private String username;

    /** SMTP 密码 / 授权码（读取时脱敏） */
    private String password;

    /** 是否启用 SSL */
    private Boolean ssl;

    /** 发件人地址 */
    private String from;

    /** 发件人显示名称 */
    private String fromName;

    /** 前端访问根地址，用于拼接填写链接 */
    private String frontUrl;
}
