<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 10:55
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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>成果展示</title>
  <link rel="stylesheet" href="/css/change-password.css">
</head>
<body>
<div class="container">
  <!-- Header -->
  <header class="header">
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
    <div class="main" style="position: relative;">
      <div class="section">
        <h1>${categoryname}成果</h1> <!-- 显示当前分类名称 -->
        <!-- 筛选表单 -->
        <form action="/achievements/${category}" method="get" class="filter-form">
          <div class="form-group">
            <label for="year">选择年份：</label>
            <select name="year" id="year">
              <option value="">请选择年份</option>
              <c:forEach var="year" items="${years}">
                <option value="${year}" ${year == param.year ? 'selected' : ''}>${year}</option>
              </c:forEach>
            </select>
          </div>

          <div class="form-group">
            <label for="sortOrder">排序：</label>
            <select name="sortOrder" id="sortOrder">
              <option value="asc" ${'asc' == param.sortOrder ? 'selected' : ''}>升序</option>
              <option value="desc" ${'desc' == param.sortOrder ? 'selected' : ''}>降序</option>
            </select>
          </div>

          <button type="submit" class="btn-submit">筛选</button>
        </form>

        <!-- 成果列表 -->
        <div class="achievements-list">
          <c:if test="${empty achievements}">
            <p>暂无成果展示</p>
          </c:if>

          <c:if test="${not empty achievements}">
            <ul>
              <c:forEach var="achievement" items="${achievements}">
                <li>
                  <a href="/achievement/details?achievementID=${achievement.achievementID}" class="achievement-link">
                    <strong>${achievement.title}</strong>
                  </a>
                  <span class="achievement-date">
                                        <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" />
                                    </span>
                </li>
              </c:forEach>
            </ul>
          </c:if>
        </div>
      </div>
    </div>
  </div>

  <footer>
    ABCD组 &copy; 2024
  </footer>
</div>
</body>
</html>
