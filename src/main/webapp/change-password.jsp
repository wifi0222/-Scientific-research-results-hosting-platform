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
    <title>修改密码</title>
</head>
<body>
<h1>修改密码</h1>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<c:if test="${not empty message}">
    <p style="color: green;">${message}</p>
</c:if>

<form action="/user/change-password" method="post">
    <label for="oldPassword">旧密码:</label>
    <input type="password" id="oldPassword" name="oldPassword" required><br>

    <label for="newPassword">新密码:</label>
    <input type="password" id="newPassword" name="newPassword" required><br>

    <label for="confirmPassword">确认新密码:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br>

    <button type="submit">提交</button>
</form>
<p><a href="/browse">返回主页</a></p>
</body>
</html>
