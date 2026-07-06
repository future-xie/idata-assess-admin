package com.rutong.framework.bean;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public class PageBean {

    private Integer pageSize = 10;
    private Integer pageNum = 1;

    public int getStart() {
        return (pageNum - 1) * pageSize;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    /**
     * 由本分页参数构造 MyBatis-Plus 的 {@link Page}。
     * 页码缺省 1、页大小缺省 10，避免 null 拆箱空指针。
     */
    public <T> Page<T> toPage() {
        int num = this.getPageNum() == null ? 1 : this.getPageNum();
        int size = this.getPageSize() == null ? 10 : this.getPageSize();
        return new Page<>(num, size);
    }
}
