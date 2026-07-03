package com.rutong.configuration;

/**
 * 读取项目相关配置
 */
public class ApplicationConfig {

    public static final String PROFILE_URL = "/profile/";

    public static final String ATTACH_URL = "/attach/";

    /**
     * 上传路径
     */
    private static String ROOT_PATH = System.getProperty("user.dir");

    public static final String ATTACH_DIR_PATH = ROOT_PATH + ATTACH_URL;
    public static final String AVATAR_DIR_PATH = ATTACH_DIR_PATH + "/avatar";
}
