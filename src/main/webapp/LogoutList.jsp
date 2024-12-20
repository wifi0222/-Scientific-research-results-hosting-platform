<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/20
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>申请注销用户</title>
    <script>
        // 确认注销的对话框
        function confirmLogout(userId) {
            if (confirm("确定注销此账户吗？注销后该用户将无法登录。")) {
                // 向后端发送注销请求
                window.location.href = "/logoutUser?userID=" + userId;
            }
        }
    </script>
</head>
<body>
    <h1>申请注销用户列表</h1>
    <table border="1">
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>姓名</th>
            <th>用户角色</th>
            <th>邮箱</th>
            <th>注册时间</th>
            <th>账号状态</th>
            <th>联系方式</th>
            <th>研究方向</th>
            <th>学术背景</th>
            <th>科研成果</th>
            <th>操作</th>
            <!-- 这里可以根据实际需要增加更多的列 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.userID}</td>
                <td>${user.username}</td>
                <td>${user.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.roleType == 'TeamMember'}">团队成员</c:when>
                        <c:when test="${user.roleType == 'Visitor'}">普通用户</c:when>
                    </c:choose>
                </td>
                <td>${user.email}</td>
                <td>
                    <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.status == 1}">正常</c:when>
                        <c:when test="${user.status == 0}">禁用</c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.contactInfo}">无</c:when>
                        <c:otherwise>${user.contactInfo}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.researchField}">无</c:when>
                        <c:otherwise>${user.researchField}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.academicBackground}">无</c:when>
                        <c:otherwise>${user.academicBackground}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.researchAchievements}">无</c:when>
                        <c:otherwise>${user.researchAchievements}</c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <div>
                        <!-- 注销用户-->
                        <button type="button" onclick="confirmLogout(${user.userID})">注销</button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <form action="ToUserManage">
        <button>返回用户管理界面</button>
    </form>
</body>
</html>
