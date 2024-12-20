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

<c:choose>
  <c:when test="${isTeamMember}">
    <div>
      <ul>
        <li><a href="/user/profile">个人信息管理</a></li>
        <li><a href="/questions/ans-all-questions">反馈管理</a></li>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
      </ul>
    </div>
  </c:when>
  <c:when test="${isMember}">
    <div>
      <ul>
        <li><a href="/user/askQuestion">用户互动</a></li>
        <li><a href="/user/checkReply">我的反馈</a></li>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
      </ul>
    </div>
  </c:when>
  <c:otherwise>
    <ul>
      <!-- 其他功能 -->
      <li><a href="/login.jsp">登录</a></li>
    </ul>
  </c:otherwise>
</c:choose>

</body>
</html>
