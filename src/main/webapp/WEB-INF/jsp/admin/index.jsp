﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jspf/taglib.jspf" %>
<!DOCTYPE HTML>
<html>
<head>
    <%@ include file="jspf/head.jspf" %>
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl">
            <a class="logo navbar-logo f-l mr-10 hidden-xs" href="${ctx}/admin">${systemWeb.title}</a>
            <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="${ctx}/admin">Exam</a>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs">${systemWeb.version}</span>
            <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
            <nav class="nav navbar-nav">
                <ul class="cl">
                    <li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i
                            class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li>
                                <a href="javascript:;" onclick="member_add('添加用户','${ctx}/admin/user/add','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a>
                            </li>
                            <li>
                                <a href="javascript:;" onclick="permission_add('添加权限','${ctx}/admin/permission/add','','510')"><i class="Hui-iconfont">&#xe705;</i> 权限</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li>
                        <c:if test="${session_user.roleId==1}">超级管理员</c:if>
                        <c:if test="${session_user.roleId==2}">网站管理员</c:if>
                        <c:if test="${session_user.roleId==3}">网站会员</c:if>
                    </li>
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">${session_user.reallyName} <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onClick="myselfInfo()">个人信息</a></li>
                            <li><a href="${ctx}/admin/logout">退出</a></li>
                        </ul>
                    </li>
                    
                    <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" class="dropDown_A"
                                                                               title="换肤"><i class="Hui-iconfont"
                                                                                             style="font-size:18px">
                        &#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">
    <input runat="server" id="divScrollValue" type="hidden" value=""/>
    <div class="menu_dropdown bk_2">

        <c:set var="parentIds" value="${parentIds}"/>
        <c:if test="${fn:contains(parentIds, '1')}">
            <dl id="menu-member">
                <dt><i class="Hui-iconfont">&#xe60d;</i> 会员管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${permissions}" var="c" >
                            <c:choose>
                                <c:when test="${c.parentId==1 and c.nowId==2}">
                                    <li><a data-href="${ctx}${c.uri}" data-title="${c.permissionName}" href="javascript:;">${c.permissionName}</a></li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:if>

        <c:if test="${fn:contains(parentIds, '2')}">
            <dl id="menu-role">
                <dt><i class="Hui-iconfont">&#xe705;</i> 角色权限<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${permissions}" var="c" >
                            <c:choose>
                                <c:when test="${c.parentId==2 and c.nowId==2}">
                                    <li><a data-href="${ctx}${c.uri}" data-title="${c.permissionName}" href="javascript:;">${c.permissionName}</a></li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:if>

        <c:if test="${fn:contains(parentIds, '3')}">
            <dl id="menu-yt">
                <dt><i class="Hui-iconfont">&#xe65a;</i> 人脸识别<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${permissions}" var="c" >
                            <c:choose>
                                <c:when test="${c.parentId==3 and c.nowId==2}">
                                    <li><a data-href="${ctx}${c.uri}" data-title="${c.permissionName}" href="javascript:;">${c.permissionName}</a></li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:if>

        <c:if test="${fn:contains(parentIds, '4')}">
            <dl id="menu-gcfx">
                <dt><i class="Hui-iconfont">&#xe61c;</i> 过程分析<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${permissions}" var="c" >
                            <c:choose>
                                <c:when test="${c.parentId==4 and c.nowId==2}">
                                    <li><a data-href="${ctx}${c.uri}" data-title="${c.permissionName}" href="javascript:;">${c.permissionName}</a></li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:if>

        <c:if test="${fn:contains(parentIds, '5')}">
            <dl id="menu-gcfx">
                <dt><i class="Hui-iconfont">&#xe62e;</i> 系统设置<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${permissions}" var="c" >
                            <c:choose>
                                <c:when test="${c.parentId==5 and c.nowId==2}">
                                    <li><a data-href="${ctx}${c.uri}" data-title="${c.permissionName}" href="javascript:;">${c.permissionName}</a></li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:if>

    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a>
</div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="${ctx}/admin/welcome">我的桌面</span>
                    <em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S"
                                                  href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a
                id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">
            &#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="${ctx}/admin/welcome"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前</li>
        <li id="closeall">关闭全部</li>
    </ul>
</div>

<!--_footer 作为公共模版分离出去-->
<%@ include file="jspf/footer.jspf" %>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctx}/resources/admin/plug-in/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">

    /**
     * 个人信息-修改
     */
    function myselfInfo() {
        layer_show("修改用户", "${ctx}/admin/user/edit/${session_user.id}");
    }

    /**
     * 用户-添加
     * @param title
     * @param url
     */
    function member_add(title, url) {
        layer_show(title, url);
    }

    /**
     * 权限-添加
     * @param title
     * @param url
     */
    function permission_add(title, url) {
        layer_show(title, url);
    }


</script>
</body>
</html>