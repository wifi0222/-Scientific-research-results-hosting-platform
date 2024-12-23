<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>超级用户进行权限管理</title>

    <!-- 引入一些基础样式 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
        }

        h1 {
            text-align: center;
            color: #4e73df;
            margin-bottom: 30px;
        }

        /* 表格样式 */
        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #4e73df;
            color: white;
        }

        td {
            border-top: 1px solid #f1f1f1;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* 权限列的显示 */
        .permission {
            text-align: center;
            font-weight: bold;
        }

        .permission span {
            padding: 4px 8px;
            border-radius: 5px;
        }

        .permission .has {
            background-color: #28a745;
            color: white;
        }

        .permission .no {
            background-color: #e74a3b;
            color: white;
        }

        /* 编辑按钮 */
        a.btn-edit {
            display: inline-block;
            padding: 8px 16px;
            margin: 5px;
            color: #fff;
            background-color: #4e73df;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        a.btn-edit:hover {
            background-color: #2e59d9;
        }

        /* 警告框样式 */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

    </style>
</head>
<body>
<div class="container">
    <h1>超级用户权限管理</h1>

    <%-- 提示信息 --%>
    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <!-- 权限管理表格 -->
    <table>
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>管理员姓名</th>
            <th>发布权限</th>
            <th>用户权限</th>
            <th>删除权限</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${teamAdministrators}" var="teamAdmin">
            <tr>
                <td>${teamAdmin.adminID}</td>
                <td>${teamAdmin.adminUsername}</td>
                <td>${teamAdmin.adminName}</td>
                <td class="permission">
                            <span class="${teamAdmin.publishPermission ? 'has' : 'no'}">
                                    ${teamAdmin.publishPermission ? '有权限' : '无权限'}
                            </span>
                </td>
                <td class="permission">
                            <span class="${teamAdmin.userPermission ? 'has' : 'no'}">
                                    ${teamAdmin.userPermission ? '有权限' : '无权限'}
                            </span>
                </td>
                <td class="permission">
                            <span class="${teamAdmin.deletePermission ? 'has' : 'no'}">
                                    ${teamAdmin.deletePermission ? '有权限' : '无权限'}
                            </span>
                </td>
                <td>
                    <a href="/SuperController/ToEditTA?adminID=${teamAdmin.adminID}" class="btn-edit">
                        <i class="fas fa-edit"></i> 编辑权限
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    // 检查信息并弹出提示框
    window.onload = function() {
        var Message = "${message}";
        if (Message) {
            alert(Message);
        }
    };
</script>
</body>
</html>
