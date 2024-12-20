<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/18
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加团队管理员</title>
</head>
<body>
    <form action="AddTeamAdmin" method="get">
        账号：<input type="text" name="username">
        密码：<input type="text" name="password">

        选择管理团队：
        <select id="teamId" name="teamId">
            <c:forEach var="team" items="${teams}">
                <option value="${team.teamID}">${team.teamName}</option>
            </c:forEach>
<%--            <option value="团队名称">团队名称</option>--%>
        </select><br><br>
        <input type="submit" value="提交">
    </form>
        <a href="UserManagement">返回用户管理界面</a>
</body>
</html>
