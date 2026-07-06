package com.rutong.framework.mybatis.objectquery;

import com.alibaba.fastjson2.JSON;
import com.rutong.framework.utils.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class SortFilter {
	public static final String DESC = "desc";
	public static final String ASC = "asc";
	
	private String property;

	private String direction;

	public SortFilter(String property,String direction){
		this.property = property;
		this.direction = direction;
	}

	public static List<SortFilter> parse(String sortFilter){
		if(StringUtils.isEmpty(sortFilter)){
			return new ArrayList<>();
		}
		return JSON.parseArray(sortFilter, SortFilter.class);
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}
	
}
