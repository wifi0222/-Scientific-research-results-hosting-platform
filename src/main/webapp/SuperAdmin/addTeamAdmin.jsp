<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/18
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加团队管理员</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/newSidebar.css">
    <style>
        /* 表单整体样式 */
        form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
        }

        /* 表单字段容器 */
        .form-group {
            margin-bottom: 20px;
        }

        /* 标签样式 */
        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        /* 输入框样式 */
        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: border-color 0.3s ease;
        }

        /* 聚焦效果 */
        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #4e73df;
            outline: none;
        }

        /* 下拉框样式 */
        select {
            background-image: url('https://cdn.jsdelivr.net/npm/bootstrap-icons/font/fonts/bootstrap-icons.svg#caret-down'); /* 使用向下箭头 */
            background-repeat: no-repeat;
            background-position: right 10px center;
            -webkit-appearance: none; /* 去除默认样式 */
            -moz-appearance: none; /* 去除默认样式 */
            appearance: none; /* 去除默认样式 */
        }

        /* 提交按钮样式 */
        .btn-submit {
            background-color: #4e73df;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        /* 提交按钮悬停效果 */
        .btn-submit:hover {
            background-color: #355db3;
        }

        /* 返回按钮样式 */
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
            position: relative; /* 相对定位，为了放置箭头 */
            text-align: center; /* 按钮内文字居中 */
            margin: 0 auto; /* 将按钮本身居中 */
            display: block; /* 让按钮成为块级元素，支持居中 */
        }

        .back-btn a{
            font-size: 16px;
            color: white;
            text-align: center;
            text-decoration: none; /* 去掉下划线 */
            font-weight: bold; /* 设置字体加粗 */
        }

        /* 按钮悬停时 */
        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }

        /* 在悬停时显示箭头 */
        .back-btn:hover::after {
            font-size: 20px;
            margin-left: 10px; /* 箭头和文字之间的间距 */
            position: absolute;
            right: -25px; /* 箭头位于按钮的右侧 */
            top: 50%;
            transform: translateY(-50%); /* 垂直居中 */
            transition: transform 0.3s ease-in-out; /* 平滑过渡 */
        }

        /* 下拉框容器样式 */
        .select-wrapper {
            position: relative;
            width: 100%;
        }

        /* 自定义的下拉框 */
        .select-wrapper select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            font-size: 16px;
            cursor: pointer;
            -webkit-appearance: none; /* 去除默认样式 */
            -moz-appearance: none; /* 去除默认样式 */
            appearance: none; /* 去除默认样式 */
            color: #333;
        }

        /* 自定义箭头 */
        .select-wrapper::after {
            content: '\f0d7'; /* FontAwesome 下拉箭头 */
            font-family: 'FontAwesome';
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none; /* 防止箭头影响点击 */
        }

        /* 高亮悬停效果 */
        .select-wrapper select:hover {
            border-color: #4e73df;
        }

        /* 高亮选中的项 */
        .select-wrapper select option:hover {
            background-color: #e0e0e0;
        }

        /* 优化下拉列表的文本对齐和行高 */
        .select-wrapper select option {
            padding: 10px;
            font-size: 16px;
            line-height: 1.5;
        }

        /* 优化下拉框的选项宽度 */
        .select-wrapper select {
            width: 100%;
        }

        /* 优化选项的间距 */
        .select-wrapper select option {
            padding: 10px 15px;
            font-size: 16px;
        }

        /* 选中项的样式 */
        .select-wrapper select option:checked {
            background-color: #4e73df;
            color: white;
        }

        h1{
            text-align: center;
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

        <div class="main">
            <div class="section">

                <h1>添加团队管理员</h1>

                <button class="back-btn">
                    <a href="/SuperController/UserManagement">返回用户管理</a>
                </button>

                <form action="/SuperController/TeamAdminManage/add" method="get">

                    <div class="form-group">
                        <label for="username">账号：</label>
                        <input type="text" id="username" name="username" placeholder="请输入账号" required>
                    </div>

                    <div class="form-group">
                        <label for="password">密码：</label>
                        <input type="password" id="password" name="password" placeholder="请输入密码" required>
                    </div>

                    <div class="form-group">
                        <label for="teamId">选择管理团队：</label>
                        <div class="select-wrapper">
                            <select id="teamId" name="teamId" required>
                                <option value="">请选择团队</option>
                                <c:forEach var="team" items="${teams}">
                                    <option value="${team.teamID}">
                                        ${team.teamName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>


                    <input type="submit" value="提交" class="btn-submit"/>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
