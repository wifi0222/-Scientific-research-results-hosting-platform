<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理用户权限</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" href="/css/Inputform.css">
</head>
<body>
<div class="container">
    <div class="sidebar">
        <c:choose>
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

    <div class="content">
        <div class="main">
            <div class="section">
                <h1>为${teamAdministrator.adminName}设置权限</h1>
                <h2>
                    <a href="/SuperController/TeamAdministrator/edit?set=1&adminID=${teamAdministrator.adminID}">
                        一键为用户设置团队管理员基本权限（包括发布权限、用户管理权限)
                    </a>
                </h2>

                <br>

                <h2>全部权限设置：</h2>
                <form action="/SuperController/TeamAdministrator/edit" method="get">
                    <input type="text" name="set" value="0" hidden="hidden">
                    <input type="text" name="adminID" value="${teamAdministrator.adminID}" hidden="hidden">
                    <!-- 发布科研成果权限 -->
                    <label>发布科研成果权限：</label>
                    <label>
                        <input type="radio" name="publishPermission" value="1" ${teamAdministrator.publishPermission == true ? 'checked' : ''}> 有权限
                    </label>
                    <label>
                        <input type="radio" name="publishPermission" value="0" ${teamAdministrator.publishPermission == false ? 'checked' : ''}> 无权限
                    </label>
                    <br>

                    <!-- 审核用户权限 -->
                    <label>审核用户权限：</label>
                    <label>
                        <input type="radio" name="userPermission" value="1" ${teamAdministrator.userPermission == true ? 'checked' : ''}> 有权限
                    </label>
                    <label>
                        <input type="radio" name="userPermission" value="0" ${teamAdministrator.userPermission == false ? 'checked' : ''}> 无权限
                    </label>
                    <br>

                    <!-- 删除科研成果权限 -->
                    <label>删除科研成果权限：</label>
                    <label>
                        <input type="radio" name="deletePermission" value="1" ${teamAdministrator.deletePermission == true ? 'checked' : ''}> 有权限
                    </label>
                    <label>
                        <input type="radio" name="deletePermission" value="0" ${teamAdministrator.deletePermission == false ? 'checked' : ''}> 无权限
                    </label>
                    <br>

                    <input type="submit" value="提交权限设置">
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
