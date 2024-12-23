<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/17
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>超级管理员用户管理</title>
    <!-- 引入基本样式 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* 页面基础样式 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            color: #333;
        }

        /* 容器样式 */
        .container {
            display: flex;
            height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #ffffff;
            border-right: 1px solid #e3e6f0;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .main {
            flex-grow: 1;
            padding: 30px;
            background-color: #fff;
            overflow-y: auto;
        }

        h1.page-title {
            color: #4e73df;
            margin-bottom: 20px;
        }

        .section {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* 表格样式 */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #4e73df;
            color: #ffffff;
        }

        td {
            border-top: 1px solid #f1f1f1;
        }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            margin-right: 10px;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-edit {
            background-color: #4e73df;
        }

        .btn-edit:hover {
            background-color: #2e59d9;
        }

        .btn-delete {
            background-color: #e74a3b;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .btn-add {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            text-decoration: none;
            background-color: #28a745;
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-add:hover {
            background-color: #218838;
        }

        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .action-links {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 侧边栏区域 -->
<%--    <div class="sidebar">--%>
<%--        <jsp:include page="../HomePage.jsp"/>--%>
<%--    </div>--%>

    <!-- 主体内容区域 -->
    <div class="main">
        <%-- 展示团队管理员列表 --%>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
        </c:if>

        <!-- 如果存在error属性，显示弹窗提示 -->
        <div th:if="${AddTeamAdminRemind}" th:text="${AddTeamAdminRemind}" class="alert alert-error"></div>

        <h1 class="page-title">团队管理员</h1>
        <div class="section">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>邮箱</th>
                    <th>管理团队</th>
                    <th>注册时间</th>
                    <th>账号状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.userID}</td>
                        <td>${user.username}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>团队名称</td>
                        <td>
                            <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.status == 1}">正常</c:when>
                                <c:when test="${user.status == 0}">禁用</c:when>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-links">
                                <a href="/SuperController/ToChangeTeamAdmin?userID=${user.userID}" class="btn btn-edit">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="javascript:void(0);" onclick="confirmDelete(${user.userID})" class="btn btn-delete">
                                    <i class="fas fa-trash-alt"></i> 删除
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="/SuperController/ToAddTeamAdmin" class="btn btn-add">添加团队管理员</a>
    </div>
</div>

<%-- 显示添加团队管理员是否成功 --%>
<script>
    // 检查错误信息并弹出提示框
    window.onload = function() {
        var errorMessage = "${AddTeamAdminRemind}";
        if (errorMessage) {
            alert(errorMessage);
        } else {
            errorMessage = "${ChangeTeamAdminRemind}";
            if (errorMessage) {
                alert(errorMessage);
            }
        }
    };

    // 在删除按钮点击时，弹出确认框
    function confirmDelete(userID) {
        var result = confirm("确定要删除该管理员吗？");
        if (result) {
            // 如果确认删除，跳转到删除链接
            window.location.href = "/SuperController/TeamAdminManage/delete?userID=" + userID;
        }
    }
</script>
</body>
</html>
