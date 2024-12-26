<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: 王斐--%>
<%--  Date: 2024/12/19--%>
<%--  Time: 13:06--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html; charset=UTF-8" %>--%>
<%--<%@ page isELIgnored="false" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>团队信息浏览</title>--%>
<%--  <link rel="stylesheet" href="/css/browse.css">--%>
<%--  <script src="/js/browse.js" defer></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--  <!-- Content -->--%>
<%--  <div class="content">--%>
<%--    <!-- Sidebar -->--%>
<%--    <div class="sidebar">--%>
<%--      <c:choose>--%>
<%--        <c:when test="${userRoleType == 'TeamMember'}">--%>
<%--            <ul>--%>
<%--              <li><a href="/browse" class="active">信息浏览</a></li>--%>
<%--              <li><a href="/user/memberProfile">个人信息</a></li>--%>
<%--              <li><a href="/user/profile/status">查询信息修改审核进度</a></li>--%>
<%--              <li><a href="/user/change-password">修改密码</a></li>--%>
<%--              <li><a href="/user/deactivate">账号注销</a></li>--%>
<%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
<%--            </ul>--%>
<%--            <div class="logout">--%>
<%--              <a href="/user/logout">退出登录</a>--%>
<%--            </div>--%>
<%--        </c:when>--%>
<%--        <c:when test="${userRoleType == 'Visitor'}">--%>
<%--            <ul>--%>
<%--              <li><a href="/browse" class="active">信息浏览</a></li>--%>
<%--              <li><a href="/user/askQuestion">用户互动</a></li>--%>
<%--              <li><a href="/user/checkReply">我的反馈</a></li>--%>
<%--              <li><a href="/user/change-password">修改密码</a></li>--%>
<%--              <li><a href="/user/deactivate">账号注销</a></li>--%>
<%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
<%--            </ul>--%>
<%--            <div class="logout">--%>
<%--              <a href="/user/logout">退出登录</a>--%>
<%--            </div>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--          <ul>--%>
<%--            <li><a href="/login.jsp">登录</a></li>--%>
<%--          </ul>--%>
<%--        </c:otherwise>--%>
<%--      </c:choose>--%>
<%--    </div>--%>

<%--    <!-- Main Content -->--%>
<%--    <div class="main">--%>
<%--      <!-- Carousel -->--%>
<%--      <div class="carousel">--%>
<%--        <img src="/resources/1.jpg" alt="Carousel Image 1" class="active">--%>
<%--        <img src="/resources/2.jpg" alt="Carousel Image 2">--%>
<%--        <img src="/resources/3.jpg" alt="Carousel Image 3">--%>
<%--      </div>--%>

<%--      <div class="section intro">--%>
<%--        <h2>团队简介</h2>--%>
<%--        <p>团队名称：<c:out value="${team.teamName}"/></p>--%>
<%--        <p>研究方向：<c:out value="${team.researchArea}"/></p>--%>
<%--        <p>简介：<c:out value="${team.introduction}"/></p>--%>
<%--        <a href="/team/members" class="btn-submit">查看成员</a> <!-- 添加跳转链接到成员页面 -->--%>
<%--      </div>--%>

<%--      <div class="section articles">--%>
<%--        <h2>文章</h2>--%>
<%--        <a href="/articles">查看更多</a>--%>
<%--        <ul>--%>
<%--          <c:forEach var="article" items="${articles}" begin="0" end="4">--%>
<%--            <li>--%>
<%--              <!-- 构造链接，点击后跳转到成果详情 -->--%>
<%--              <a href="/article/details?articleID=${article.articleID}">--%>
<%--                <strong>${article.title}</strong>--%>
<%--              </a>--%>
<%--              <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd" />--%>
<%--            </li>--%>
<%--          </c:forEach>--%>
<%--        </ul>--%>
<%--      </div>--%>

<%--      <div class="section soft">--%>
<%--        <h2>软著</h2>--%>
<%--        <a href="/achievements/soft">查看更多</a>--%>
<%--        <ul>--%>
<%--          <c:forEach var="achievement" items="${softAchievements}" begin="0" end="4">--%>
<%--            <li>--%>
<%--              <!-- 构造链接，点击后跳转到成果详情 -->--%>
<%--              <a href="/achievement/details?achievementID=${achievement.achievementID}">--%>
<%--                <strong>${achievement.title}</strong>--%>
<%--              </a>--%>
<%--              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />--%>
<%--            </li>--%>
<%--          </c:forEach>--%>
<%--        </ul>--%>
<%--      </div>--%>

<%--      <div class="section book">--%>
<%--        <h2>专著</h2>--%>
<%--        <a href="/achievements/book">查看更多</a>--%>
<%--        <ul>--%>
<%--          <c:forEach var="achievement" items="${bookAchievements}" begin="0" end="4">--%>
<%--            <li>--%>
<%--              <!-- 构造链接，点击后跳转到成果详情 -->--%>
<%--              <a href="/achievement/details?achievementID=${achievement.achievementID}">--%>
<%--                <strong>${achievement.title}</strong>--%>
<%--              </a>--%>
<%--              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />--%>
<%--            </li>--%>
<%--          </c:forEach>--%>
<%--        </ul>--%>
<%--      </div>--%>

<%--      <div class="section patent">--%>
<%--        <h2>专利</h2>--%>
<%--        <a href="/achievements/patent">查看更多</a>--%>
<%--        <ul>--%>
<%--          <c:forEach var="achievement" items="${patentAchievements}" begin="0" end="4">--%>
<%--            <li>--%>
<%--              <!-- 构造链接，点击后跳转到成果详情 -->--%>
<%--              <a href="/achievement/details?achievementID=${achievement.achievementID}">--%>
<%--                <strong>${achievement.title}</strong>--%>
<%--              </a>--%>
<%--              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />--%>
<%--            </li>--%>
<%--          </c:forEach>--%>
<%--        </ul>--%>
<%--      </div>--%>

<%--      <div class="section product">--%>
<%--        <h2>产品</h2>--%>
<%--        <a href="/achievements/product">查看更多</a>--%>
<%--        <ul>--%>
<%--          <c:forEach var="achievement" items="${productAchievements}" begin="0" end="4">--%>
<%--            <li>--%>
<%--              <!-- 构造链接，点击后跳转到成果详情 -->--%>
<%--              <a href="/achievement/details?achievementID=${achievement.achievementID}">--%>
<%--                <strong>${achievement.title}</strong>--%>
<%--              </a>--%>
<%--              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />--%>
<%--            </li>--%>
<%--          </c:forEach>--%>
<%--        </ul>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <footer>--%>
<%--    ABCD组 &copy; 2024--%>
<%--  </footer>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>团队信息浏览</title>
  <link rel="stylesheet" href="/css/browse.css">
  <script src="/js/browse.js" defer></script>
</head>
<body>
<div class="container">
  <!-- Header -->
  <header class="header">
    <!-- 添加收起/展开按钮 -->
    <c:choose>
      <c:when test="${empty user}">
      </c:when>
      <c:otherwise>
        <button class="sidebar-toggle">☰</button>
      </c:otherwise>
    </c:choose>
    <div class="title">
      <h1>信息浏览</h1>
    </div>
    <c:choose>
      <c:when test="${empty user}">
        <div class="login-btn">
          <a href="/login.jsp" class="btn-submit">登录</a>
        </div>
      </c:when>
    </c:choose>
  </header>

  <div class="content">
    <c:if test="${not empty user}">
      <div class="sidebar">
        <c:choose>
          <c:when test="${userRoleType == 'TeamMember'}">
            <ul>
              <li><a href="/browse" class="active">信息浏览</a></li>
              <li><a href="/user/memberProfile">个人信息</a></li>
              <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
              <li><a href="/user/change-password">修改密码</a></li>
              <li><a href="/user/deactivate">账号注销</a></li>
              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
            </ul>
            <div class="logout">
              <a href="/user/logout">退出登录</a>
            </div>
          </c:when>
          <c:when test="${userRoleType == 'Visitor'}">
            <ul>
              <li><a href="/browse" class="active">信息浏览</a></li>
              <li><a href="/user/askQuestion">用户互动</a></li>
              <li><a href="/user/checkReply">我的反馈</a></li>
              <li><a href="/user/change-password">修改密码</a></li>
              <li><a href="/user/deactivate">账号注销</a></li>
              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
            </ul>
            <div class="logout">
              <a href="/user/logout">退出登录</a>
            </div>
          </c:when>
        </c:choose>
      </div>
    </c:if>

    <!-- Main Content -->
    <div class="main">
      <!-- Carousel -->
      <div class="carousel">
        <img src="/resources/1.jpg" alt="Carousel Image 1" class="active">
        <img src="/resources/2.jpg" alt="Carousel Image 2">
        <img src="/resources/3.jpg" alt="Carousel Image 3">
      </div>

      <div class="section intro">
        <h2>团队简介</h2>
        <div class="intro-content">
          <p>团队名称：<c:out value="${team.teamName}"/></p>
          <p>研究方向：<c:out value="${team.researchArea}"/></p>
          <p>简介：<c:out value="${team.introduction}"/></p>
        </div>
        <a href="/team/members" class="btn-submit">查看成员</a> <!-- 按钮移到左侧 -->
      </div>

      <div class="section articles">
        <h2>文章</h2>
        <a href="/articles">查看更多</a>
        <ul>
          <c:forEach var="article" items="${articles}" begin="0" end="4">
            <li>
              <a href="/article/details?articleID=${article.articleID}">
                <strong>${article.title}</strong>
              </a>
              <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd" />
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="section soft">
        <h2>软著</h2>
        <a href="/achievements/soft">查看更多</a>
        <ul>
          <c:forEach var="achievement" items="${softAchievements}" begin="0" end="4">
            <li>
              <a href="/achievement/details?achievementID=${achievement.achievementID}">
                <strong>${achievement.title}</strong>
              </a>
              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="section book">
        <h2>专著</h2>
        <a href="/achievements/book">查看更多</a>
        <ul>
          <c:forEach var="achievement" items="${bookAchievements}" begin="0" end="4">
            <li>
              <a href="/achievement/details?achievementID=${achievement.achievementID}">
                <strong>${achievement.title}</strong>
              </a>
              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="section patent">
        <h2>专利</h2>
        <a href="/achievements/patent">查看更多</a>
        <ul>
          <c:forEach var="achievement" items="${patentAchievements}" begin="0" end="4">
            <li>
              <a href="/achievement/details?achievementID=${achievement.achievementID}">
                <strong>${achievement.title}</strong>
              </a>
              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="section product">
        <h2>产品</h2>
        <a href="/achievements/product">查看更多</a>
        <ul>
          <c:forEach var="achievement" items="${productAchievements}" begin="0" end="4">
            <li>
              <a href="/achievement/details?achievementID=${achievement.achievementID}">
                <strong>${achievement.title}</strong>
              </a>
              <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>

  <footer>
    ABCD组 &copy; 2024
  </footer>
</div>
</body>
</html>
