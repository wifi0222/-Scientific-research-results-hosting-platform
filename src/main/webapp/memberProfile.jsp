<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/23
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>成员详情</title>
  <link rel="stylesheet" href="/css/change-password.css">
  <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
  <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
  <script src="/js/browse.js" defer></script>
  <style>
    /* 页面标题 */
    .page-title {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #4e73df; /* 蓝色标题 */
      margin: 20px 0;
    }

    /* 头部背景和头像样式 */
    .profile-header {
      display: flex;
      align-items: center;
      padding: 20px;
      background: linear-gradient(to right, #4e73df, #ffffff); /* 蓝色渐变 */
      color: #ffffff;
      margin-bottom: 20px;
      position: relative;
      height: 200px; /* 背景高度 */
    }

    .profile-header img {
      position: absolute;
      top: -60px; /* 头像上端超出背景 */
      left: 20px;
      width: 160px;
      height: 240px;
      object-fit: cover;
      border: none;
    }

    .profile-header .profile-info {
      margin-left: 200px; /* 为头像预留空间 */
    }

    .profile-header h1 {
      color: #ffffff;
      margin: 0;
      font-size: 28px; /* 更大的字体 */
      font-weight: bold;
    }

    .profile-header p {
      margin: 5px 0;
      font-size: 18px; /* 增大字体 */
    }

    /* Section Title 样式 */
    .section-title {
      font-size: 22px;
      font-weight: bold;
      color: #4e73df;
      margin-bottom: 15px;
      border-bottom: 2px solid #4e73df;
      padding-bottom: 5px;
      display: inline-block;
    }

    /* 内容样式 */
    .content-section {
      margin-bottom: 20px;
    }

    .content-section p {
      font-size: 16px;
      margin: 5px 0;
      color: #333;
    }

    /* 返回按钮样式 */
    .action-links a {
      display: inline-block;
      background-color: #4e73df;
      color: #ffffff;
      text-decoration: none;
      padding: 10px 15px;
      border-radius: 5px;
      transition: background-color 0.3s;
    }

    .action-links a:hover {
      background-color: #3758c8;
    }

    footer {
      text-align: center;
      padding: 10px;
      background-color: #e1effd;
      font-size: 14px;
      color: #555;
      margin-top: 20px;
      border-top: 1px solid #ddd;
    }

    .content-section img{
      width: 80%; /* 设置为容器的80%宽度 */
    }

  </style>
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
      <a href="/browse">
        <h1>信息浏览</h1>
      </a>
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
    <!-- 左侧边栏 -->
  <c:if test="${not empty user}">
      <div class="sidebar">
        <ul>
          <li><a href="/browse">信息浏览</a></li>
          <li><a href="/user/memberProfile" class="active">个人信息</a></li>
          <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
          <li><a href="/user/change-password">修改密码</a></li>
          <li><a href="/user/deactivate">账号注销</a></li>
          <%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
        </ul>
        <div class="logout">
          <a href="/user/logout">退出登录</a>
        </div>
      </div>
  </c:if>
    <!-- Main Content -->
    <div class="main">
      <div class="page-title">个人详情</div>
      <!-- 头部个人信息展示 -->
      <c:if test="${not empty user}">
        <div class="profile-header">
          <c:choose>
            <c:when test="${not empty user.avatarFile}">
              <!-- 如果头像存在，显示头像 -->
              <c:set var="encodedPath"
                     value="${fn:replace(fn:replace(user.avatarFile, '\\\\', '/'), ' ', '%20')}"/>
              <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="头像"/>
            </c:when>
            <c:otherwise>
              <!-- 如果没有头像，显示默认头像 -->
              <img src="/resources/OIP.jpg" alt="默认头像"/>
            </c:otherwise>
          </c:choose>
          <div class="profile-info">
            <h1><c:out value="${user.name}" /></h1>
            <p>职务：<c:choose>
              <c:when test="${user.roleType == 'TeamMember'}">团队成员</c:when>
              <c:when test="${user.roleType == 'Visitor'}">普通用户</c:when>
              <c:otherwise>未知角色</c:otherwise>
            </c:choose>
            </p>
            <p><strong>联系方式：</strong><c:out value="${user.contactInfo}" /></p>
            <p><strong>Email：</strong><c:out value="${user.email}" /></p>
          </div>
        </div>
      </c:if>

      <!-- 研究方向 -->
      <div class="content-section">
        <h2 class="section-title">研究方向</h2>
        <p><c:out value="${user.researchField}" /></p>
      </div>

      <div class="content-section">
        <h2 class="section-title">学术背景</h2>
        <p><c:out value="${user.academicBackground}" /></p>
      </div>

      <div class="content-section">
        <h2 class="section-title">科研成果</h2>
        <p><c:out value="${user.researchAchievements}" escapeXml="false" /></p>
      </div>

      <div class="action-links">
        <a href="/user/profile" class="btn-submit">修改</a>
      </div>
    </div>
  </div>

  <footer>
    ABCD组 &copy; 2024
  </footer>

</div>
</body>
</html>
