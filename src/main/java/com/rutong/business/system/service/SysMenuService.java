package com.rutong.business.system.service;

import com.rutong.business.system.entity.SysUser;
import com.rutong.framework.bean.TreeSelect;
import com.rutong.framework.constant.Constants;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysMenu;
import com.rutong.business.system.entity.SysRole;
import com.rutong.business.system.pojo.MetaVo;
import com.rutong.business.system.pojo.RouterVo;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 菜单 业务层处理
 */
@Service
public class SysMenuService extends BaseService<SysMenu> {

    /**
     * 根据用户ID查询权限
     *
     * @param userId 用户ID
     * @return 权限列表
     */
    public Set<String> selectMenuPermsByUserId(Long userId) {
        String sql = "select distinct m.perms from sys_menu m " +
                " left join sys_role_menu rm on m.id = rm.menu_id " +
                " left join sys_user_role ur on rm.role_id = ur.role_id " +
                " where ur.user_id = " + userId;
        List<String> perms = dao.executeSQLQuery(String.class, sql);
        Set<String> permsSet = new HashSet<>();
        for (String perm : perms) {
            if (StringUtils.isNotEmpty(perm)) {
                permsSet.addAll(Arrays.asList(perm.trim().split(",")));
            }
        }
        return permsSet;
    }

    /**
     * 根据角色ID查询权限
     *
     * @param roleId 角色ID
     * @return 权限列表
     */
    public Set<String> selectMenuPermsByRoleId(Long roleId) {
        String sql = "select distinct m.perms from sys_menu m " +
                " left join sys_role_menu rm on m.id = rm.menu_id " +
                "  where rm.role_id = " + roleId;
        List<String> perms = dao.executeSQLQuery(String.class, sql);
        Set<String> permsSet = new HashSet<>();
        for (String perm : perms) {
            if (StringUtils.isNotEmpty(perm)) {
                permsSet.addAll(Arrays.asList(perm.trim().split(",")));
            }
        }
        return permsSet;
    }

    /**
     * 根据用户ID查询菜单
     *
     * @param userId 用户名称
     * @return 菜单列表（树形结构，仅包含用户有权限的菜单）
     */
    public List<SysMenu> selectMenuByUserId(Long userId) {
        List<SysMenu> menus;
        if (SecurityUtils.isAdmin(userId)) {
            // 管理员：查询所有菜单（排除按钮类型F）
            String hql = "FROM SysMenu m WHERE m.menuType <> 'F' ORDER BY m.parentId, m.orderNum";
            menus = dao.executeHqlQuery(SysMenu.class, hql);
        } else {
            // 普通用户：只查询角色关联的菜单（排除按钮类型F）
            // 查出扁平列表，再手动构建树，避免 JPA @OneToMany 加载未授权的子菜单
            String hql = "select distinct m from SysUser u join u.roles r join r.menus m " +
                    "where u.id = " + userId + " AND m.menuType <> 'F' ORDER BY m.parentId, m.orderNum";
            menus = dao.executeHqlQuery(SysMenu.class, hql);
        }
        return buildMenuTree(menus);
    }

    /**
     * 从扁平菜单列表构建菜单树
     * 只包含列表中的菜单，避免 JPA @OneToMany 懒加载未授权的子菜单
     *
     * @param menus 扁平菜单列表
     * @return 树形菜单列表（仅根节点）
     */
    private List<SysMenu> buildMenuTree(List<SysMenu> menus) {
        Map<Long, SysMenu> menuMap = new LinkedHashMap<>();
        for (SysMenu menu : menus) {
            menu.getChildren().clear();
            menuMap.put(menu.getId(), menu);
        }

        List<SysMenu> roots = new ArrayList<>();
        for (SysMenu menu : menus) {
            Long parentId = menu.getParentId();
            if (parentId == null || !menuMap.containsKey(parentId)) {
                // 根菜单：无父级 或 父级不在授权列表中（作为根节点展示）
                roots.add(menu);
            } else {
                // 子菜单：加入父菜单的 children 集合
                menuMap.get(parentId).getChildren().add(menu);
            }
        }
        return roots;
    }

    /**
     * 根据角色ID查询菜单树信息
     *
     * @param roleId 角色ID
     * @return 选中菜单列表
     */
    public List<Long> selectMenuListByRoleId(Long roleId) {
        SysRole role = dao.findById(SysRole.class, roleId);
        String sql = "select m.id from sys_menu m left join sys_role_menu rm on m.id = rm.menu_id " +
                " where rm.role_id = " + roleId;
        sql += " order by m.parent_id, m.order_num ";
        return dao.executeSQLQuery(Long.class, sql);
    }

    /**
     * 构建前端路由所需要的菜单
     *
     * @param menus 菜单列表
     * @return 路由列表
     */
    public List<RouterVo> buildMenus(List<SysMenu> menus) {
        List<RouterVo> routers = new LinkedList<RouterVo>();
        for (SysMenu menu : menus) {
            RouterVo router = new RouterVo();
            router.setHidden("0".equals(menu.getVisible()));
            router.setName(getRouteName(menu));
            router.setPath(getRouterPath(menu));
            router.setComponent(getComponent(menu));
            router.setQuery(menu.getQuery());
            router.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon(), StringUtils.equals("1", menu.getIsCache()), menu.getPath()));
            Set<SysMenu> cMenus = menu.getChildren();
            if (StringUtils.isNotEmpty(cMenus) && UserConstants.TYPE_DIR.equals(menu.getMenuType())) {
                router.setAlwaysShow(true);
                router.setRedirect("noRedirect");
                router.setChildren(buildMenus(new ArrayList<>(cMenus)));
            } else if (isMenuFrame(menu)) {
                router.setMeta(null);
                List<RouterVo> childrenList = new ArrayList<RouterVo>();
                RouterVo children = new RouterVo();
                children.setPath(menu.getPath());
                children.setComponent(menu.getComponent());
                children.setName(getRouteName(menu.getRouteName(), menu.getPath()));
                children.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon(), StringUtils.equals("1", menu.getIsCache()), menu.getPath()));
                children.setQuery(menu.getQuery());
                childrenList.add(children);
                router.setChildren(childrenList);
            } else if (menu.getParentId() == null && isInnerLink(menu)) {
                router.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon()));
                router.setPath("/");
                List<RouterVo> childrenList = new ArrayList<RouterVo>();
                RouterVo children = new RouterVo();
                String routerPath = innerLinkReplaceEach(menu.getPath());
                children.setPath(routerPath);
                children.setComponent(UserConstants.INNER_LINK);
                children.setName(getRouteName(menu.getRouteName(), routerPath));
                children.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon(), menu.getPath()));
                childrenList.add(children);
                router.setChildren(childrenList);
            }
            routers.add(router);
        }
        return routers;
    }

    /**
     * 是否存在菜单子节点
     *
     * @param menuId 菜单ID
     * @return 结果
     */
    public boolean hasChildByMenuId(Long menuId) {
        long result = dao.countByProperty(SysMenu.class, "parentId", menuId);
        return result > 0;
    }

    /**
     * 校验菜单名称是否唯一
     *
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean checkMenuNameUnique(SysMenu menu) {
        Long menuId = StringUtils.isNull(menu.getId()) ? -1L : menu.getId();
        Long pId = menu.getParentId() == null ? 0L : menu.getParentId();
        SysMenu info = dao.findByPropertyFirst(SysMenu.class, "menuName", menu.getMenuName(), "parentId", pId);
        if (StringUtils.isNotNull(info) && info.getId().longValue() != menuId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 获取路由名称
     *
     * @param menu 菜单信息
     * @return 路由名称
     */
    public String getRouteName(SysMenu menu) {
        // 非外链并且是一级目录（类型为目录）
        if (isMenuFrame(menu)) {
            return StringUtils.EMPTY;
        }
        return getRouteName(menu.getRouteName(), menu.getPath());
    }

    /**
     * 获取路由名称，如没有配置路由名称则取路由地址
     *
     * @param name 路由名称
     * @param path 路由地址
     * @return 路由名称（驼峰格式）
     */
    public String getRouteName(String name, String path) {
        String routerName = StringUtils.isNotEmpty(name) ? name : path;
        return StringUtils.capitalize(routerName);
    }

    /**
     * 获取路由地址
     *
     * @param menu 菜单信息
     * @return 路由地址
     */
    public String getRouterPath(SysMenu menu) {
        String routerPath = menu.getPath();
        // 内链打开外网方式
        if (menu.getParentId() != null && isInnerLink(menu)) {
            routerPath = innerLinkReplaceEach(routerPath);
        }
        // 非外链并且是一级目录（类型为目录）
        if (menu.getParentId() == null && UserConstants.TYPE_DIR.equals(menu.getMenuType())
                && UserConstants.NO_FRAME.equals(menu.getIsFrame())) {
            routerPath = menu.getPath().startsWith("/") ? menu.getPath() : "/" + menu.getPath();
        }
        // 非外链并且是一级目录（类型为菜单）
        else if (isMenuFrame(menu)) {
            routerPath = "/";
        }
        return routerPath;
    }

    /**
     * 获取组件信息
     *
     * @param menu 菜单信息
     * @return 组件信息
     */
    public String getComponent(SysMenu menu) {
        String component = UserConstants.LAYOUT;
        if (StringUtils.isNotEmpty(menu.getComponent()) && !isMenuFrame(menu)) {
            component = menu.getComponent();
        } else if (StringUtils.isEmpty(menu.getComponent()) && menu.getParentId() != null && isInnerLink(menu)) {
            component = UserConstants.INNER_LINK;
        } else if (StringUtils.isEmpty(menu.getComponent()) && isParentView(menu)) {
            component = UserConstants.PARENT_VIEW;
        }
        return component;
    }

    /**
     * 是否为菜单内部跳转
     *
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean isMenuFrame(SysMenu menu) {
        return menu.getParentId() == null && UserConstants.TYPE_MENU.equals(menu.getMenuType())
                && menu.getIsFrame().equals(UserConstants.NO_FRAME);
    }

    /**
     * 是否为内链组件
     *
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean isInnerLink(SysMenu menu) {
        return menu.getIsFrame().equals(UserConstants.NO_FRAME) && StringUtils.ishttp(menu.getPath());
    }

    /**
     * 是否为parent_view组件
     *
     * @param menu 菜单信息
     * @return 结果
     */
    public boolean isParentView(SysMenu menu) {
        return menu.getParentId() != null && UserConstants.TYPE_DIR.equals(menu.getMenuType());
    }

    /**
     * 得到子节点列表
     */
    private Set<SysMenu> getChildList(List<SysMenu> list, SysMenu t) {
        Set<SysMenu> tlist = new HashSet<>();
        Iterator<SysMenu> it = list.iterator();
        while (it.hasNext()) {
            SysMenu n = (SysMenu) it.next();
            if (t.getId().equals(n.getParentId())) {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<SysMenu> list, SysMenu t) {
        return getChildList(list, t).size() > 0;
    }

    /**
     * 内链域名特殊字符替换
     *
     * @return 替换后的内链域名
     */
    public String innerLinkReplaceEach(String path) {
        return StringUtils.replaceEach(path, new String[]{Constants.HTTP, Constants.HTTPS, Constants.WWW, ".", ":"},
                new String[]{"", "", "", "/", "/"});
    }

    public List<TreeSelect> buildMenuTreeSelect(List<SysMenu> menus) {
        return menus.stream().map(TreeSelect::new).collect(Collectors.toList());
    }
}
