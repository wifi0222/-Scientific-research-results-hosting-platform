<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/19
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
    <link rel="stylesheet" href="/css/change-password.css">
    <script src="/js/browse.js" defer></script>
</head>
<body>
<div class="container">
    <!-- Header -->
    <header class="header">
        <!-- 添加收起/展开按钮 -->
        <c:choose>
            <c:when test="${empty user}">
            </c:when>
            <c:otherwise>
                <button class="sidebar-toggle">☰</button>
            </c:otherwise>
        </c:choose>
        <div class="title"><a href="/browse">
  <h1>信息浏览</h1>
</a>        </div>
        <c:choose>
            <c:when test="${empty user}">
                <div class="login-btn">
                    <a href="/login.jsp" class="btn-submit">登录</a>
                </div>
            </c:when>
        </c:choose>
    </header>
    <!-- 内容部分 -->
    <div class="content">
        <!-- 左侧边栏 -->
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'TeamMember'}">
                    <ul>
                        <li><a href="/browse">信息浏览</a></li>
                        <li><a href="/user/memberProfile">个人信息</a></li>
                        <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
                        <li><a href="/user/change-password" class="active">修改密码</a></li>
                        <li><a href="/user/deactivate">账号注销</a></li>
                        <%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:when test="${userRoleType == 'Visitor'}">
                    <ul>
                        <li><a href="/browse">信息浏览</a></li>
                        <li><a href="/user/askQuestion">用户互动</a></li>
                        <li><a href="/user/checkReply">我的反馈</a></li>
                        <li><a href="/user/change-password" class="active">修改密码</a></li>
                        <li><a href="/user/deactivate">账号注销</a></li>
                        <%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
            </c:choose>
        </div>

        <!-- 右侧主内容 -->
        <div class="main">
            <div class="section">
                <h1>修改密码</h1>

                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>

                <c:if test="${not empty message}">
                    <p style="color: green;">${message}</p>
                </c:if>

                <form action="/user/change-password" method="post">
                    <label for="oldPassword">旧密码:</label><br>
                    <input type="password" id="oldPassword" name="oldPassword" required><br><br>

                    <label for="newPassword">新密码:</label><br>
                    <input type="password" id="newPassword" name="newPassword" required><br><br>

                    <label for="confirmPassword">确认新密码:</label><br>
                    <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

                    <button type="submit" class="btn-submit">提交</button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>
</body>
</html>
