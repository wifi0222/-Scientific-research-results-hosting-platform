<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/19
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息管理</title>
    <link rel="stylesheet" href="/css/change-password.css">
</head>
<body>
<div class="container">
    <!-- 内容部分 -->
    <div class="content">
        <!-- 左侧边栏 -->
        <div class="sidebar">
            <ul>
                <li><a href="/browse">信息浏览</a></li>
                <li><a href="/user/profile" class="active">个人信息管理</a></li>
                <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
                <li><a href="/user/change-password">修改密码</a></li>
                <li><a href="/user/deactivate">账号注销</a></li>
                <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
            </ul>
            <div class="logout">
                <a href="/user/logout">退出登录</a>
            </div>
        </div>

        <!-- 右侧主内容 -->
        <div class="main">
            <div class="section">
                <h1>个人信息管理</h1>

                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>

                <c:if test="${not empty message}">
                    <p style="color: green;">${message}</p>
                </c:if>

                <form action="/user/profile/update" method="post">
                    <label for="name">姓名:</label>
                    <input type="text" id="name" name="name" value="${user.name}" required><br>

                    <label for="researchField">研究方向:</label>
                    <input type="text" id="researchField" name="researchField" value="${user.researchField}" required><br>

                    <label for="contactInfo">联系方式:</label>
                    <input type="text" id="contactInfo" name="contactInfo" value="${user.contactInfo}" required><br>

                    <label for="academicBackground">学术背景:</label>
                    <input type="text" id="academicBackground" name="academicBackground" value="${user.academicBackground}" required><br>

                    <label for="researchAchievements">科研成果:</label>
                    <input type="text" id="researchAchievements" name="researchAchievements" value="${user.researchAchievements}" required><br>

                    <button type="submit" class="btn-submit">保存修改</button>
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




