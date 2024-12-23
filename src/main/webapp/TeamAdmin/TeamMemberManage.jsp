<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 20:27
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
    <title>团队成员管理</title>

    <!-- 引入外部CSS库（例如Bootstrap）进行美化 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: row;
            padding: 20px;
            gap: 20px;
        }

        /* 侧边栏样式 */
        .sidebar {
            width: 250px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .sidebar a {
            text-decoration: none;
            color: #333;
            display: block;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
            font-size: 16px;
        }

        .sidebar a:hover {
            background-color: #4e73df;
            color: white;
        }

        .submenu {
            display: none;
            list-style: none;
            padding-left: 20px;
        }

        .active + .submenu {
            display: block;
        }

        .content {
            flex-grow: 1;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4e73df;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .logout {
            text-align: center;
            margin-top: 20px;
        }

        .logout a {
            padding: 10px 20px;
            background-color: #e74a3b;
            color: white;
            border-radius: 5px;
            text-decoration: none;
        }

        .logout a:hover {
            background-color: #c0392b;
        }

        .add-member {
            display: block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
        }

        .add-member:hover {
            background-color: #218838;
        }

    </style>
    <script>
        // 检查错误信息并弹出提示框
        window.onload = function() {
            var errorMessage = "${information}";
            if (errorMessage) {
                alert(errorMessage);
            }
        };
    </script>
</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <c:choose>
            <c:when test="${userRoleType == 'TeamAdmin'}">
                <ul>
                    <li><a href="javascript:void(0);">团队管理</a>
                        <ul class="submenu">
                            <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                            <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                            <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">科研成果管理与发布</a>
                        <ul class="submenu">
                            <li><a href="/research/submenu1">子菜单项1</a></li>
                            <li><a href="/research/submenu2">子菜单项2</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">文章管理</a>
                        <ul class="submenu">
                            <li><a href="/article/submenu1">子菜单项1</a></li>
                            <li><a href="/article/submenu2">子菜单项2</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">用户管理</a>
                        <ul class="submenu">
                            <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                            <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">在线交流与反馈</a>
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

    <!-- Content -->
    <div class="content">
        <h1>团队成员管理</h1>
        <table>
            <thead>
            <tr>
                <th>用户ID</th>
                <th>用户名</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>注册时间</th>
                <th>账号状态</th>
                <th>研究方向</th>
                <th>联系方式</th>
                <th>学术背景</th>
                <th>科研成果</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${members}" var="member">
                <tr>
                    <td>${member.userID}</td>
                    <td>${member.username}</td>
                    <td>${member.name}</td>
                    <td>${member.email}</td>
                    <td>
                        <fmt:formatDate value="${member.registrationTime}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${member.status == 1}">正常</c:when>
                            <c:when test="${member.status == 0}">禁用</c:when>
                        </c:choose>
                    </td>
                    <td>${member.researchField}</td>
                    <td>${member.contactInfo}</td>
                    <td>${member.academicBackground}</td>
                    <td>${member.researchAchievements}</td>
                    <td>
                        <a href="/teamAdmin/ToChangeTeamMember?userID=${member.userID}">编辑</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <a href="/TeamAdmin/addTeamMember.jsp" class="add-member">添加新团队成员</a>
    </div>
</div>

</body>
</html>
