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
<h1>团队简介</h1>
<p>团队名称：<c:out value="${team.teamName}"/></p>
<p>研究方向：<c:out value="${team.researchArea}"/></p>
<p>简介：<c:out value="${team.introduction}"/></p>

<h2>团队成员</h2>
<ul>
  <c:forEach var="member" items="${teamMembers}">
    <li>
      姓名：<c:out value="${member.name}"/>，
      研究方向：<c:out value="${member.researchField}"/>
      <a href="${pageContext.request.contextPath}/member/details?userID=${member.userID}">查看详情</a>
    </li>
  </c:forEach>
</ul>

<!-- 模块化复用 -->
<h2>成果模块</h2>

<!-- 软著列表 -->
<jsp:include page="achievementListModule.jsp">
  <jsp:param name="achievementTitle" value="软著列表" />
  <jsp:param name="achievementList" value="${softAchievements}" />
</jsp:include>

<!-- 专著列表 -->
<jsp:include page="achievementListModule.jsp">
  <jsp:param name="achievementTitle" value="专著列表" />
  <jsp:param name="achievementList" value="${bookAchievements}" />
</jsp:include>

<!-- 专利列表 -->
<jsp:include page="achievementListModule.jsp">
  <jsp:param name="achievementTitle" value="专利列表" />
  <jsp:param name="achievementList" value="${patentAchievements}" />
</jsp:include>

<!-- 产品列表 -->
<jsp:include page="achievementListModule.jsp">
  <jsp:param name="achievementTitle" value="产品列表" />
  <jsp:param name="achievementList" value="${productAchievements}" />
</jsp:include>
<c:choose>
  <c:when test="${isTeamMember}">
    <div>
      <ul>
        <li><a href="/user/profile">个人信息管理</a></li>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
      </ul>
    </div>
  </c:when>
  <c:when test="${isMember}">
    <div>
      <ul>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
      </ul>
    </div>
  </c:when>
  <c:otherwise>
    <ul>
      <li><a href="/login.jsp">登录</a></li>
    </ul>
  </c:otherwise>
</c:choose>

</body>
</html>
