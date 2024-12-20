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
      <a href="/member/details?teamMembersID=${member.userID}">查看详情</a>
    </li>
  </c:forEach>
</ul>
<h2>软著</h2>
<ul>
<!-- 检查列表是否为空 -->
<c:if test="${empty softAchievements}">
  <p>暂无成果展示</p >
</c:if>

<!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty softAchievements}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="achievement" items="${softAchievements}" begin="0" end="4">
        <li>
          <strong>${achievement.title}</strong> - ${achievement.creationTime}
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>
<h2>专著</h2>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty bookAchievements}">
    <p>暂无成果展示</p >
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty bookAchievements}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="achievement" items="${bookAchievements}" begin="0" end="4">
        <li>
          <strong>${achievement.title}</strong> - ${achievement.creationTime}
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>专利</h2>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty patentAchievements}">
    <p>暂无成果展示</p >
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty patentAchievements}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="achievement" items="${patentAchievements}" begin="0" end="4">
        <li>
          <strong>${achievement.title}</strong> - ${achievement.creationTime}
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>产品</h2>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty productAchievements}">
    <p>暂无成果展示</p >
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty productAchievements}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="achievement" items="${productAchievements}" begin="0" end="4">
        <li>
          <strong>${achievement.title}</strong> - ${achievement.creationTime}
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>文章</h2>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty articles}">
    <p>暂无成果展示</p >
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty articles}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="articles" items="${articles}" begin="0" end="4">
        <li>
          <strong>${articles.title}</strong> - ${articles.publishDate}
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>
<%--<!-- 模块化复用 -->--%>
<%--<h2>成果模块</h2>--%>

<%--<!-- 软著列表 -->--%>
<%--<jsp:include page="achievementListModule.jsp">--%>
<%--  <jsp:param name="achievementTitle" value="软著列表" />--%>
<%--  <jsp:param name="achievementList" value="${softAchievements}" />--%>
<%--</jsp:include>--%>

<%--<!-- 专著列表 -->--%>
<%--<jsp:include page="achievementListModule.jsp">--%>
<%--  <jsp:param name="achievementTitle" value="专著列表" />--%>
<%--  <jsp:param name="achievementList" value="${bookAchievements}" />--%>
<%--</jsp:include>--%>

<%--<!-- 专利列表 -->--%>
<%--<jsp:include page="achievementListModule.jsp">--%>
<%--  <jsp:param name="achievementTitle" value="专利列表" />--%>
<%--  <jsp:param name="achievementList" value="${patentAchievements}" />--%>
<%--</jsp:include>--%>

<%--<!-- 产品列表 -->--%>
<%--<jsp:include page="achievementListModule.jsp">--%>
<%--  <jsp:param name="achievementTitle" value="产品列表" />--%>
<%--  <jsp:param name="achievementList" value="${productAchievements}" />--%>
<%--</jsp:include>--%>

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
