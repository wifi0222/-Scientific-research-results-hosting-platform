<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
Welcome!!
<%--<jsp:include   page="Yanzheng.jsp" flush="true"/>--%>
<form action="/SuperController/UserManagement" method="get">
    <input type="submit" value="超级管理员用户管理">
</form>

<form action="/SuperController/TeamAdministratorManagement" method="get">
    <input type="submit" value="超级管理员权限管理">
</form>

<h2>团队管理员团队管理</h2>
<form action="/teamAdmin/TeamManage/Info">
    <input type="submit" value="团队简介">
</form>

<form action="/teamAdmin/TeamManage/Member">
    <input type="submit" value="成员管理">
</form>

<form action="/teamAdmin/ToMemberInfoReview">
    <input type="submit" value="成员审核">
</form>

<h2>用户管理</h2>
<form action="/teamAdmin/ToUserRegisterManage">
    <input type="submit" value="用户注册审核">
</form>

<form action="/teamAdmin/ToUserManage">
    <input type="submit" value="注销和重置密码">
</form>

</body>
</html>