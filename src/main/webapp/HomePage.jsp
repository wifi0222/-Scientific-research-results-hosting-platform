<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/23
  Time: 8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String tPath = request.getContextPath();
    String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>团队管理员</title>
    <link rel="stylesheet" href="<%=tBasePath%>/css/browse.css">
    <script src="<%=tBasePath%>/js/browse.js" defer></script>
    <style>
        .submenu {
            display: none; /* 默认子菜单隐藏 */
            list-style: none;
            padding-left: 20px;
        }
        .active + .submenu {
            display: block; /* 当父项是active时，子菜单显示 */
        }
    </style>
</head>
<div class="container">
    <!-- Content -->
    <div class="content">
        <!-- Sidebar -->
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'TeamAdmin'}">
                    <ul>
                        <li>
                            <a href="javascript:void(0);">团队管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                                <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                                <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a> </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0);">科研成果管理与发布</a>
                            <ul class="submenu">
                                <li><a href="/research/submenu1">子菜单项1</a></li>
                                <li><a href="/research/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0);">文章管理</a>
                            <ul class="submenu">
                                <li><a href="/article/submenu1">子菜单项1</a></li>
                                <li><a href="/article/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0);">用户管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                                <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0);">在线交流与反馈</a>
                            <ul class="submenu">
                                <li><a href="/feedback/submenu1">子菜单项1</a></li>
                                <li><a href="/feedback/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:when test="${userRoleType == 'SuperAdmin'}">
                    <ul>
                        <li><a href="/SuperController/UserManagement" class="active">用户管理</a></li>
                        <li><a href="/SuperController/TeamAdministratorManagement">权限管理</a></li>
                        <li><a href="/user/checkReply">内容审核</a></li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul>
                        <li><a href="/login.jsp">登录</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    // 获取所有的a标签
    const menuLinks = document.querySelectorAll('ul > li > a');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // 如果是子菜单的链接，不阻止跳转
            if (this.nextElementSibling && this.nextElementSibling.classList.contains('submenu')) {
                // 这是父菜单，阻止跳转
                event.preventDefault(); // 阻止父菜单的默认跳转行为
                // 切换当前a标签的class
                this.classList.toggle('active');

                // 获取当前点击项的下一个子菜单
                const submenu = this.nextElementSibling;

                if (submenu && submenu.classList.contains('submenu')) {
                    // 切换子菜单的显示状态
                    submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
                }
            }
            // 对于子菜单项，允许跳转，不做任何处理
        });
    });
</script>

</body>
</html>