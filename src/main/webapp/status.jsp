<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>查看申请状态</title>
</head>
<body>
<h2>查看申请状态</h2>
<form action="/registration/status" method="post">
    邮箱: <input type="email" name="email" required/><br><br>
    <input type="submit" value="查询状态"/>
</form>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>
<c:if test="${not empty message}">
    <p>${message}</p>
</c:if>

</body>
</html>

