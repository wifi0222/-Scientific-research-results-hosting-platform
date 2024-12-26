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
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
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
                        <a href="/SuperController/UserManagement">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">添加团队管理员</h1>
                </div>

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
