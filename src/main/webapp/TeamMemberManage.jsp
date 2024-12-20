<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>团队成员管理</title>
</head>
<body>
<h1>团队成员</h1>
<table border="1">
    <thead>
    <tr>
        <th>用户ID</th>
        <th>用户名</th>
        <th>姓名</th>
        <th>邮箱</th>
        <th>注册时间</th>
        <th>账号状态</th>
        <th>研究方向</th>
        <th>联系方式</th>
        <th>学术背景</th>
        <th>科研成果</th>
        <th>操作</th>
        <!-- 这里可以根据实际需要增加更多的列 -->
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${members}" var="member">
        <tr>
            <td>${member.userID}</td>
            <td>${member.username}</td>
            <td>${member.name}</td>
            <td>${member.email}</td>
            <td>
                <fmt:formatDate value="${member.registrationTime}" pattern="yyyy-MM-dd" />
            </td>
            <td>${member.status}</td>
            <td>${member.researchField}</td>
            <td>${member.contactInfo}</td>
            <td>${member.academicBackground}</td>
            <td>${member.researchAchievements}</td>
            <td>
                <div>
                    <!-- 修改链接，传递 userID 作为查询参数-->
                    <a href="/ToChangeTeamMember?userID=${member.userID}">编辑</a>
                </div>
            </td>
            <!-- 这里根据用户对象的属性输出信息 -->
        </tr>
    </c:forEach>
    <a href="addTeamMember.jsp">添加新团队成员</a>
    </tbody>
</table>
</body>
</html>
