package com.rutong.business.common.service;

import com.rutong.business.common.entity.BaseEntity;
import com.rutong.framework.annotation.DataScope;
import com.rutong.framework.bean.PageBean;
import com.rutong.framework.bean.TableDataInfo;
import com.rutong.framework.dao.IDao;
import com.rutong.framework.dao.objectquery.SortFilter;
import com.rutong.framework.security.LoginUser;
import com.rutong.framework.security.SecurityUtils;
import jakarta.annotation.Resource;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Transactional
public abstract class BaseService<T extends BaseEntity> {
    private Class<T> entityClass;

    @Resource
    protected IDao dao;

    public BaseService() {
        // 获取当前类的泛型父类类型
        Type genericSuperclass = getClass().getGenericSuperclass();
        if (genericSuperclass instanceof ParameterizedType) {
            ParameterizedType pt = (ParameterizedType) genericSuperclass;
            // 获取第一个类型参数
            Type actualType = pt.getActualTypeArguments()[0];
            if (actualType instanceof Class) {
                this.entityClass = (Class<T>) actualType;
            }
        } else {
            throw new IllegalArgumentException("无法获取泛型类型");
        }
    }

    public T findById(Serializable id) {
        return dao.findById(entityClass, id);
    }

    public int deleteById(Serializable id) {
        dao.delete(findById(id));
        return 1;
    }

    public int update(T data) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        data.setUpdateBy(loginUser.getUsername());
        data.setUpdateTime(new Date());
        dao.update(data);
        return 1;
    }

    public int insert(T data) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        data.setCreateBy(loginUser.getUsername());
        data.setCreateTime(new Date());
        dao.save(data);
        return 1;
    }

    public int insertNoAuth(T data) {
        data.setCreateTime(new Date());
        dao.save(data);
        dao.flush();
        return 1;
    }

    public List<T> findAll() {
        return dao.findAll(entityClass);
    }

    @DataScope
    public TableDataInfo findAllByPage(PageBean page, Object query, List<SortFilter> sorts) {
        TableDataInfo rspData = new TableDataInfo();
        long count = dao.count(entityClass, query);
        if (count > 0l) {
            List<?> list = dao.queryPage(entityClass, page, query, sorts);
            rspData.setRows(list);
        } else {
            rspData.setRows(Arrays.asList());
        }
        rspData.setTotal(count);
        rspData.setCode(200);
        rspData.setMsg("查询成功");
        return rspData;
    }

    @DataScope
    public List<T> findAll(Object query, List<SortFilter> sorts) {
        return dao.findAll(entityClass, query, sorts);
    }

    public int deleteByIds(Long[] ids) {
        for (Serializable id : ids) {
            deleteById(id);
        }
        return ids.length;
    }

}
