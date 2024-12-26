<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>我的问题</title>
    <link rel="stylesheet" href="/css/change-password.css">
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
        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="/browse">信息浏览</a></li>
                <li><a href="/user/askQuestion">用户互动</a></li>
                <li><a href="/user/checkReply" class="active">我的反馈</a></li>
                <li><a href="/user/change-password">修改密码</a></li>
                <li><a href="/user/deactivate">账号注销</a></li>
                <%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
            </ul>
            <div class="logout">
                <a href="/user/logout">退出登录</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="section">
                <h1>我的问题</h1>
                <table class="styled-table">
                    <thead>
                    <tr>
                        <th>问题 ID</th>
                        <th>标题</th>
                        <th>状态</th>
                        <th>提问时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="question" items="${questions}">
                        <tr>
                            <td>${question.questionID}</td>
                            <td>${question.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${question.status == 0}">待处理</c:when>
                                    <c:when test="${question.status == 1}">已回答</c:when>
                                    <c:otherwise>已关闭</c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value='${question.askTime}'
                                                pattern='yyyy-MM-dd HH:mm'/></td>
                            <td>
                                <a href="/questions/ask-details/${question.questionID}" class="btn-view">查看详情</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>
</body>
</html>
