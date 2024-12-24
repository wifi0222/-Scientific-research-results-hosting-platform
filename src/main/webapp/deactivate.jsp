<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/19
  Time: 14:04
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
    <title>注销账户</title>
    <link rel="stylesheet" href="/css/change-password.css">
</head>
<body>
<div class="container">
    <!-- 内容部分 -->
    <!-- Header -->
    <header class="header">
        <div class="title">
                  <a href="/browse">
        <h1>信息浏览</h1>
      </a>
        </div>
        <c:choose>
            <c:when test="${empty user}">
                <div class="login-btn">
                    <a href="/login.jsp" class="btn-submit">登录</a>
                </div>
            </c:when>
        </c:choose>
    </header>
    <div class="content">
        <!-- 左侧边栏 -->
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'TeamMember'}">
                    <ul>
                        <li><a href="/browse">信息浏览</a></li>
                        <li><a href="/user/memberProfile">个人信息</a></li>
                        <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
                        <li><a href="/user/change-password">修改密码</a></li>
                        <li><a href="/user/deactivate" class="active">账号注销</a></li>
                        <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
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
                        <li><a href="/user/change-password">修改密码</a></li>
                        <li><a href="/user/deactivate" class="active">账号注销</a></li>
                        <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
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
                <h1>注销账户申请</h1>

                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>

                <c:if test="${not empty message}">
                    <p style="color: green;">${message}</p>
                </c:if>

                <form action="/user/deactivate" method="post">
                    <label for="password">请输入密码:</label>
                    <input type="password" id="password" name="password" required><br>
                    <button type="submit" class="btn-submit" onclick="return confirmDeactivation()">提交申请</button>
                </form>

                <script>
                    function confirmDeactivation() {
                        return confirm("确认提交注销申请？");
                    }
                </script>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>
</body>
</html>


