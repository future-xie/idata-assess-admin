package com.rutong.framework.manager;

import com.rutong.framework.utils.SpringUtils;

import java.util.TimerTask;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 异步任务管理器
 */
public class AsyncManager {
    /**
     * 操作延迟10毫秒
     */
    private final int OPERATE_DELAY_TIME = 10;

    /**
     * 异步操作任务调度线程池。
     * 懒加载：不在饿汉实例化期 getBean，避免容器尚未就绪导致 NoSuchBeanDefinitionException。
     */
    private volatile ScheduledExecutorService executor;

    /**
     * 单例模式
     */
    private AsyncManager() {
    }

    private static AsyncManager me = new AsyncManager();

    public static AsyncManager me() {
        return me;
    }

    private ScheduledExecutorService getExecutor() {
        if (executor == null) {
            synchronized (AsyncManager.class) {
                if (executor == null) {
                    executor = SpringUtils.getBean("scheduledExecutorService");
                }
            }
        }
        return executor;
    }

    /**
     * 执行任务
     *
     * @param task 任务
     */
    public void execute(TimerTask task) {
        getExecutor().schedule(task, OPERATE_DELAY_TIME, TimeUnit.MILLISECONDS);
    }

    /**
     * 停止任务线程池
     */
    public void shutdown() {
        Threads.shutdownAndAwaitTermination(executor);
    }
}
