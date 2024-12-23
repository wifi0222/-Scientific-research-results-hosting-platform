<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>团队基本信息维护</title>
</head>
<body>
        <form action="/teamAdmin/TeamManage/Info/edit" method="get">
            团队ID：<input type="text" name="teamID" value="${team.teamID}" readonly>
            <br>
            团队名称：<input type="text" name="teamName" value="${team.teamName}">
            <br>
            团队研究领域：<input type="text" name="researchArea" value="${team.researchArea}">
            <br>
            团队简介：<input type="text" name="introduction" value="${team.introduction}">
            <br>
            团队创建时间：
            <input type="date" name="creationTime" value="<fmt:formatDate value="${team.creationTime}" pattern="yyyy-MM-dd" />">
            <br>
            <input type="submit" value="提交修改">
        </form>
</body>
</html>
