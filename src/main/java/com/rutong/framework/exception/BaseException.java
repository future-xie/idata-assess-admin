package com.rutong.framework.exception;

/**
 * 基础异常
 */
public class BaseException extends RuntimeException {
    private static final long serialVersionUID = 1L;


    /**
     * 错误码
     */
    private String code;

    /**
     * 错误消息
     */
    private String defaultMessage;

    public BaseException(String code, String defaultMessage) {
        this.code = code;
        this.defaultMessage = defaultMessage;
    }

    public BaseException(String defaultMessage) {
        this("500", defaultMessage);
    }

    @Override
    public String getMessage() {
        return defaultMessage;
    }

    public String getCode() {
        return code;
    }

    public String getDefaultMessage() {
        return defaultMessage;
    }
}
