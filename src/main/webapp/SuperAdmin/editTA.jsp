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
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" href="/css/TaEdit.css">
    <style>
        /* 新增：父容器使用flex布局，使Toptitle和back-btn并列展示 */
        .header-container {
            display: flex;
            justify-content: center;  /* 水平居中对齐 */
            align-items: center;      /* 垂直居中对齐 */
            gap: 20px;                /* 在标题和按钮之间添加间距 */
        }

        /* 使Toptitle居中 */
        .Toptitle {
            color: #4e73df;
            margin-bottom: 20px;
            font-size: 28px;
            padding-bottom: 10px;
            text-align: center;
            flex-grow: 1;             /* 使标题占据可用空间 */
        }

        /* 按钮样式 */
        .back-btn {
            background-color: #4e73df; /* 按钮背景色 */
            border: none;
            border-radius: 5px; /* 圆角边框 */
            padding: 12px 20px;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
        }

        .back-btn a {
            text-decoration: none;
            color: white;
            display: flex;  /* 使用flex布局使图标居中 */
            align-items: center;
            justify-content: center;
        }

        /* 隐藏链接中的文字，只显示图标 */
        .back-btn a i {
            font-size: 20px; /* 设置图标大小 */
        }

        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }

        .perm{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/SuperAdmin/sidebar.jsp"/>

        <div class="main">
            <div class="section">
                <div class="header-container">
                    <button class="back-btn">
                        <a href="/SuperController/TeamAdministratorManagement">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">修改<span class="admin-name">${teamAdministrator.adminName}</span> 权限</h1>
                </div>

                <div class="perm">
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
</div>
</body>
</html>

