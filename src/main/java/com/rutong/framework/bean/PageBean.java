package com.rutong.framework.bean;

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
}
