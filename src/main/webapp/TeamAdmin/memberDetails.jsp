<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>成员详情</title>
</head>
<body>
<h1>成员详情</h1>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<c:if test="${not empty member}">
    <p>姓名：<c:out value="${member.name}" /></p>
    <p>职务：
        <c:out value="${member.roleType}" />
        <c:choose>
                <c:when test="${member.roleType == 'TeamMember'}">团队成员</c:when>
                <c:when test="${member.roleType == 'Visitor'}">普通用户</c:when>
        </c:choose>
    </p>
    <p>研究方向：<c:out value="${member.researchField}" /></p>
    <p>学术背景：<c:out value="${member.academicBackground}" /></p>
    <p>联系方式：<c:out value="${member.contactInfo}" /></p>
    <p>科研成果：<c:out value="${member.researchAchievements}" /></p>
</c:if>

<a href="/browse">返回</a>
</body>
</html>

