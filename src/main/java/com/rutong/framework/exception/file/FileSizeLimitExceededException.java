package com.rutong.framework.exception.file;

/**
 * 文件名大小限制异常类
 */
public class FileSizeLimitExceededException extends FileException {
    private static final long serialVersionUID = 1L;

    public FileSizeLimitExceededException(long defaultMaxSize) {
        super("文件太大");
    }
}
