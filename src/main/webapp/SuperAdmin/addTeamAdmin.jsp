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

                <button class="back-btn">
                    <a href="/SuperController/UserManagement">返回用户管理</a>
                </button>

                <form action="/SuperController/TeamAdminManage/add" method="get">
                    <h2>管理员添加</h2>

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
                        <select id="teamId" name="teamId" required>
                            <option value="">请选择团队</option>
                            <c:forEach var="team" items="${teams}">
                                <option value="${team.teamID}">${team.teamName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="提交" class="btn-submit"/>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
