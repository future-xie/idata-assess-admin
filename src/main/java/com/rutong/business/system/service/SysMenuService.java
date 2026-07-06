package com.rutong.business.system.service;

import com.rutong.business.system.entity.SysMenu;
import com.rutong.business.system.mapper.SysMenuMapper;
import com.rutong.framework.bean.TreeSelect;
import com.rutong.framework.constant.Constants;
import com.rutong.framework.constant.UserConstants;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.service.MpBaseService;
import com.rutong.framework.utils.StringUtils;
import com.rutong.business.system.pojo.MetaVo;
import com.rutong.business.system.pojo.RouterVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 菜单 业务层处理
 */
@Service
public class SysMenuService extends MpBaseService<SysMenu> {

    @Autowired
    private SysMenuMapper menuMapper;

    public Set<String> selectMenuPermsByUserId(Long userId) {
        List<String> perms = menuMapper.selectMenuPermsByUserId(userId);
        return toPermSet(perms);
    }

    public Set<String> selectMenuPermsByRoleId(Long roleId) {
        List<String> perms = menuMapper.selectMenuPermsByRoleId(roleId);
        return toPermSet(perms);
    }

    private Set<String> toPermSet(List<String> perms) {
        Set<String> permsSet = new HashSet<>();
        for (String perm : perms) {
            if (StringUtils.isNotEmpty(perm)) {
                permsSet.addAll(Arrays.asList(perm.trim().split(",")));
            }
        }
        return permsSet;
    }

    /**
     * 根据用户ID查询菜单树（管理员全部，普通用户仅授权菜单）
     */
    public List<SysMenu> selectMenuByUserId(Long userId) {
        List<SysMenu> menus;
        if (SecurityUtils.isAdmin(userId)) {
            menus = menuMapper.selectAllMenusNotButton();
        } else {
            menus = menuMapper.selectMenusByUserId(userId);
        }
        return buildMenuTree(menus);
    }

    /**
     * 全部菜单树（含按钮 F 级操作权限），用于角色菜单授权——角色需能勾选按钮权限。
     * 不能复用 selectMenuByUserId（其管理员分支排除了按钮）。
     */
    public List<SysMenu> selectAllMenuTree() {
        return buildMenuTree(menuMapper.selectAllMenus());
    }

    /**
     * 从扁平菜单列表构建菜单树（手动填充 children，避免 JPA 懒加载未授权子菜单）
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
                roots.add(menu);
            } else {
                menuMap.get(parentId).getChildren().add(menu);
            }
        }
        return roots;
    }

    /**
     * 根据角色ID查询勾选的菜单 ID 列表
     */
    public List<Long> selectMenuListByRoleId(Long roleId) {
        return menuMapper.selectMenuIdsByRoleId(roleId);
    }

    /**
     * 构建前端路由
     */
    public List<RouterVo> buildMenus(List<SysMenu> menus) {
        List<RouterVo> routers = new LinkedList<>();
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
                List<RouterVo> childrenList = new ArrayList<>();
                RouterVo children = new RouterVo();
                children.setPath(menu.getPath());
                children.setComponent(menu.getComponent());
                children.setName(getRouteName(menu.getRouteName(), menu.getPath()));
                children.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon(), StringUtils.equals("1", menu.getIsCache()), menu.getPath()));
                children.setQuery(menu.getQuery());
                childrenList.add(children);
                router.setChildren(childrenList);
            } else if (isTopLevel(menu) && isInnerLink(menu)) {
                router.setMeta(new MetaVo(menu.getMenuName(), menu.getIcon()));
                router.setPath("/");
                List<RouterVo> childrenList = new ArrayList<>();
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

    /** 顶级菜单：parent_id 为空或 0（顶级统一存 0，兼容历史 NULL） */
    private boolean isTopLevel(SysMenu menu) {
        Long pid = menu.getParentId();
        return pid == null || pid == 0L;
    }

    /** 新增菜单：顶级 parent_id 统一为 0（外键已移除，0 不再受限） */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insert(SysMenu menu) {
        if (menu.getParentId() == null) {
            menu.setParentId(0L);
        }
        return super.insert(menu);
    }

    /** 修改菜单：顶级 parent_id 统一为 0 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(SysMenu menu) {
        if (menu.getParentId() == null) {
            menu.setParentId(0L);
        }
        return super.update(menu);
    }

    public boolean hasChildByMenuId(Long menuId) {
        return lambdaQuery().eq(SysMenu::getParentId, menuId).count() > 0;
    }

    public boolean checkMenuNameUnique(SysMenu menu) {
        Long menuId = StringUtils.isNull(menu.getId()) ? -1L : menu.getId();
        Long pId = menu.getParentId() != null ? menu.getParentId() : 0L;
        SysMenu info = lambdaQuery()
                .eq(SysMenu::getMenuName, menu.getMenuName())
                .eq(SysMenu::getParentId, pId)
                .one();
        if (StringUtils.isNotNull(info) && info.getId().longValue() != menuId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    public String getRouteName(SysMenu menu) {
        if (isMenuFrame(menu)) {
            return StringUtils.EMPTY;
        }
        return getRouteName(menu.getRouteName(), menu.getPath());
    }

    public String getRouteName(String name, String path) {
        String routerName = StringUtils.isNotEmpty(name) ? name : path;
        return StringUtils.capitalize(routerName);
    }

    public String getRouterPath(SysMenu menu) {
        String routerPath = menu.getPath();
        if (!isTopLevel(menu) && isInnerLink(menu)) {
            routerPath = innerLinkReplaceEach(routerPath);
        }
        if (isTopLevel(menu) && UserConstants.TYPE_DIR.equals(menu.getMenuType())
                && UserConstants.NO_FRAME.equals(menu.getIsFrame())) {
            routerPath = menu.getPath().startsWith("/") ? menu.getPath() : "/" + menu.getPath();
        } else if (isMenuFrame(menu)) {
            routerPath = "/";
        }
        return routerPath;
    }

    public String getComponent(SysMenu menu) {
        String component = UserConstants.LAYOUT;
        if (StringUtils.isNotEmpty(menu.getComponent()) && !isMenuFrame(menu)) {
            component = menu.getComponent();
        } else if (StringUtils.isEmpty(menu.getComponent()) && !isTopLevel(menu) && isInnerLink(menu)) {
            component = UserConstants.INNER_LINK;
        } else if (StringUtils.isEmpty(menu.getComponent()) && isParentView(menu)) {
            component = UserConstants.PARENT_VIEW;
        }
        return component;
    }

    public boolean isMenuFrame(SysMenu menu) {
        return isTopLevel(menu) && UserConstants.TYPE_MENU.equals(menu.getMenuType())
                && menu.getIsFrame().equals(UserConstants.NO_FRAME);
    }

    public boolean isInnerLink(SysMenu menu) {
        return menu.getIsFrame().equals(UserConstants.NO_FRAME) && StringUtils.ishttp(menu.getPath());
    }

    public boolean isParentView(SysMenu menu) {
        return !isTopLevel(menu) && UserConstants.TYPE_DIR.equals(menu.getMenuType());
    }

    public String innerLinkReplaceEach(String path) {
        return StringUtils.replaceEach(path, new String[]{Constants.HTTP, Constants.HTTPS, Constants.WWW, ".", ":"},
                new String[]{"", "", "", "/", "/"});
    }

    public List<TreeSelect> buildMenuTreeSelect(List<SysMenu> menus) {
        return menus.stream().map(TreeSelect::new).collect(Collectors.toList());
    }
}
