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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<h2>软著</h2> <a href="/achievements/soft">查看更多</a>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty softAchievements}">
    <p>暂无成果展示</p>
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty softAchievements}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="achievement" items="${softAchievements}" begin="0" end="4">
        <li>
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/achievement/details?achievementID=${achievement.achievementID}">
            <strong>${achievement.title}</strong>
          </a>
          <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
        </li>
      </c:forEach>
    </ul>
  </c:if>
</ul>

<h2>专著</h2> <a href="/achievements/book">查看更多</a>
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
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/achievement/details?achievementID=${achievement.achievementID}">
            <strong>${achievement.title}</strong>
          </a>
          <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>专利</h2> <a href="/achievements/patent">查看更多</a>
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
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/achievement/details?achievementID=${achievement.achievementID}">
            <strong>${achievement.title}</strong>
          </a>
          <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>产品</h2> <a href="/achievements/product">查看更多</a>
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
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/achievement/details?achievementID=${achievement.achievementID}">
            <strong>${achievement.title}</strong>
          </a>
          <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
        </li>
      </c:forEach>
    </ul>
  </c:if>

</ul>

<h2>文章</h2> <a href="/articles">查看更多</a>
<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty articles}">
    <p>暂无成果展示</p >
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty articles}">
    <ul>
      <!-- 只取最新的五个 -->
      <c:forEach var="article" items="${articles}" begin="0" end="4">
        <li>
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/article/details?articleID=${article.articleID}">
            <strong>${article.title}</strong>
          </a>
          <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd" />
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
  <c:when test="${userRoleType == 'TeamMember'}">
    <div>
      <ul>
        <li><a href="/user/profile">个人信息管理</a></li>
        <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
        <li><a href="/questions/ans-all-questions">反馈管理</a></li>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
        <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
        <form action="/user/logout" method="post">
          <button type="submit">退出登录</button>
        </form>

      </ul>
    </div>
  </c:when>
  <c:when test="${userRoleType == 'Visitor'}">
    <div>
      <ul>
        <li><a href="/user/askQuestion">用户互动</a></li>
        <li><a href="/user/checkReply">我的反馈</a></li>
        <li><a href="/user/change-password">修改密码</a></li>
        <li><a href="/user/deactivate">账号注销</a></li>
        <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
        <form action="/user/logout" method="post">
          <button type="submit">退出登录</button>
        </form>

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
