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
    <link rel="stylesheet" href="/css/newSidebar.css">
    <link rel="stylesheet" href="/css/TaEdit.css">
    <style>
        .t1{
            /*background-color: red;*/
            width: 200px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="content">
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'SuperAdmin'}">
                    <ul>
                        <li><a href="/SuperController/UserManagement">用户管理</a></li>
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

        <div class="main">
            <div class="section">
                <h1 class="admin-title">为 <span class="admin-name">${teamAdministrator.adminName}</span> 设置权限</h1>
<%--                <h2 class="permission-link">--%>
<%--                    <a href="/SuperController/TeamAdministrator/edit?set=1&adminID=${teamAdministrator.adminID}" class="one-click-btn">--%>
<%--                        一键为用户设置团队管理员基本权限（包括发布权限、用户管理权限)--%>
<%--                    </a>--%>
<%--                </h2>--%>

                <form action="/SuperController/TeamAdministrator/edit" method="get" class="permissions-form">
<%--                    <input type="text" name="set" value="0" hidden="hidden">--%>
                    <input type="text" name="adminID" value="${teamAdministrator.adminID}" hidden="hidden">

                    <!-- 审核用户权限 -->
                    <div class="permission-option">
                        <label class="t1">审核用户权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="userPermission" value="1" ${teamAdministrator.userPermission == true ? 'checked' : ''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="userPermission" value="0" ${teamAdministrator.userPermission == false ? 'checked' : ''}> 无权限
                        </label>
                    </div>

                    <!-- 发布科研成果权限 -->
                    <div class="permission-option">
                        <label class="t1">发布科研成果权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="publishAchievement" value="1" ${teamAdministrator.publishAchievement == true ? 'checked' : ''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="publishAchievement" value="0" ${teamAdministrator.publishAchievement == false ? 'checked' : ''}> 无权限
                        </label>
                    </div>

                    <!-- 删除科研成果权限 -->
                    <div class="permission-option">
                        <label class="t1">删除科研成果权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="deleteAchievement" value="1" ${teamAdministrator.deleteAchievement == true ? 'checked' : ''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="deleteAchievement" value="0" ${teamAdministrator.deleteAchievement == false ? 'checked' : ''}> 无权限
                        </label>
                    </div>

                    <!-- 编辑科研成果权限 -->
                    <div class="permission-option">
                        <label class="t1">编辑科研成果权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="editAchievement" value="1" ${teamAdministrator.editAchievement == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="editAchievement" value="0" ${teamAdministrator.editAchievement == false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <!-- 公开/隐藏科研成果权限 -->
                    <div class="permission-option">
                        <label class="t1">公开/隐藏科研成果权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="setAchievementStatus" value="1" ${teamAdministrator.setAchievementStatus == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="setAchievementStatus" value="0" ${teamAdministrator.setAchievementStatus == false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <!-- 发布文章权限 -->
                    <div class="permission-option">
                        <label class="t1">发布文章权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="publishArticle" value="1" ${teamAdministrator.publishArticle == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="publishArticle" value="0" ${teamAdministrator.publishArticle == false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <!-- 删除文章权限 -->
                    <div class="permission-option">
                        <label class="t1">删除文章权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="deleteArticle" value="1" ${teamAdministrator.deleteArticle == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="deleteArticle" value="0" ${teamAdministrator.deleteArticle == false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <!-- 编辑文章权限 -->
                    <div class="permission-option">
                        <label class="t1">编辑文章权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="editArticle" value="1" ${teamAdministrator.editArticle == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="editArticle" value="0" ${teamAdministrator.editArticle== false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <!-- 公开/隐藏文章权限 -->
                    <div class="permission-option">
                        <label class="t1">公开/隐藏文章权限：</label>
                        <label class="radio-label">
                            <input type="radio" name="setArticleStatus" value="1" ${teamAdministrator.setArticleStatus == true ? 'checked':''}> 有权限
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="setArticleStatus" value="0" ${teamAdministrator.setArticleStatus == false ? 'checked':''}> 无权限
                        </label>
                    </div>

                    <input type="submit" value="提交权限设置" class="submit-btn">
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

