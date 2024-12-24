<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改状态</title>
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

    <!-- 内容部分 -->
    <div class="content">
        <!-- 左侧边栏 -->
        <c:if test="${not empty user}">
            <div class="sidebar">
                <ul>
                    <li><a href="/browse">信息浏览</a></li>
                    <li><a href="/user/memberProfile">个人信息</a></li>
                    <li><a href="/user/profile/status" class="active">查询信息修改审核进度</a></li>

                    <li><a href="/user/change-password">修改密码</a></li>
                    <li><a href="/user/deactivate">账号注销</a></li>
                    <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
                </ul>
                <div class="logout">
                    <a href="/user/logout">退出登录</a>
                </div>
            </div>
        </c:if>
        <!-- 右侧主内容 -->
        <div class="main">
            <div class="section">
                <h1>修改状态查询</h1>

                <c:choose>
                    <c:when test="${modificationStatus == 0}">
                        <p>您的修改信息正在审核中，请耐心等待。</p>
                    </c:when>
                    <c:when test="${modificationStatus == -1}">
                        <p style="color:red;">您的修改申请未通过审核。</p>
                        <p>拒绝原因：<c:out value="${refuseReason}" /></p>
                    </c:when>
                    <c:otherwise>
                        <p>您的修改审核已通过或暂未提交修改。</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>
</body>
</html>
