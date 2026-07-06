package com.rutong.business.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.rutong.business.common.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@TableName("sys_menu")
public class SysMenu extends BaseEntity {

    /** 菜单名称 */
    private String menuName;
    /** 显示顺序 */
    private Integer orderNum;
    /** 路由地址 */
    private String path;
    /** 组件路径 */
    private String component;
    /** 路由参数 */
    private String query;
    /** 路由名称 */
    private String routeName;
    /** 是否为外链（1是 0否） */
    private String isFrame;
    /** 是否缓存（1缓存 0不缓存） */
    private String isCache;
    /** 类型（M目录 C菜单 F按钮） */
    private String menuType;
    /** 显示状态（1显示 0隐藏） */
    private String visible;
    /** 权限字符串 */
    private String perms;
    /** 菜单图标 */
    private String icon;

    /** 父菜单 ID*/
    @TableField(value = "parent_id")
    private Long parentId;

    /** 子菜单（仅用于构建树输出，不持久化）。用 LinkedHashSet 保留 SQL 的 order_num 顺序 */
    @TableField(exist = false)
    private Set<SysMenu> children = new LinkedHashSet<>();
}
