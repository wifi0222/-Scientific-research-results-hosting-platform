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
    <title>个人信息管理</title>
</head>
<body>
<h1>个人信息管理</h1>
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

    <button type="submit">保存修改</button>
</form>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<c:if test="${not empty message}">
    <p style="color: green;">${message}</p>
</c:if>
</body>
</html>

