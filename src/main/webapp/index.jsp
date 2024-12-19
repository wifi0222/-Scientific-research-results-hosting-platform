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
<form action="UserManagement" method="get">
    <input type="submit" value="超级管理员用户管理">
</form>

<form action="TeamAdministratorManagement" method="get">
    <input type="submit" value="超级管理员权限管理">
</form>

</body>
</html>