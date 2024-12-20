<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/20
  Time: 12:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录</title>
</head>
<body>
<h2>用户登录</h2>
<!-- 显示错误信息 -->
<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>
<form action="/user/ManagementLogin" method="get">
    用户名或ID: <input type="text" name="usernameOrId" required/><br>
    密码: <input type="password" name="password" required/><br>
    <input type="submit" value="登录"/>
</form>

</body>
</html>
</body>
</html>
