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
    <title>注销账户</title>
</head>
<body>
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
    <button type="submit" onclick="return confirmDeactivation()">提交申请</button>
</form>

<script>
    function confirmDeactivation() {
        return confirm("确认提交注销申请？");
    }
</script>
</body>
</html>
