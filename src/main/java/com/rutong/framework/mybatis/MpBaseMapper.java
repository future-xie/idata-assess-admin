package com.rutong.framework.mybatis;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * MyBatis-Plus 通用 Mapper 基类。
 * 业务 Mapper 继承它获得通用 CRUD；自定义查询在各 Mapper 加方法 + XML。
 */
public interface MpBaseMapper<T> extends BaseMapper<T> {
}
