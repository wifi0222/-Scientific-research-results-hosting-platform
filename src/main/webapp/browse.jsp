<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/19
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>信息浏览</title>
</head>
<body>
<h1>欢迎来到信息浏览页面</h1>
<ul>
  <!-- 其他功能 -->
  <li><a href="/user/change-password">修改密码</a></li>
</ul>

<c:choose>
  <c:when test="${isTeamMember}">
    <div>
      <h2>团队成员功能</h2>
      <ul>
        <li><a href="/user/profile">个人信息管理</a></li>
      </ul>
    </div>
  </c:when>
  <c:otherwise>
    <p>您是普通成员，暂无更多功能。</p>
  </c:otherwise>
</c:choose>
</body>
</html>
