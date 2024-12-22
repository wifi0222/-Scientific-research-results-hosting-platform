<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>超级用户进行权限管理</title>
</head>
<body>
    <h1>超级用户权限管理</h1>
    <table border="1">
        <thead>
            <tr>
                <th>用户ID</th>
                <th>用户名</th>
                <th>管理员姓名</th>
                <th>发布权限</th>
                <th>用户权限</th>
                <th>删除权限</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${teamAdministrators}" var="teamAdmin">
                <tr>
                    <td>${teamAdmin.adminID}</td>
                    <td>${teamAdmin.adminUsername}</td>
                    <td>${teamAdmin.adminName}</td>
                    <td>
                            <c:choose>
                                <c:when test="${teamAdmin.publishPermission}">有权限</c:when>
                                <c:when test="${not teamAdmin.publishPermission}">无权限</c:when>
                            </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${teamAdmin.userPermission}">有权限</c:when>
                            <c:when test="${not teamAdmin.userPermission}">无权限</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${teamAdmin.deletePermission}">有权限</c:when>
                            <c:when test="${not teamAdmin.deletePermission}">无权限</c:when>
                        </c:choose>
                    </td>
                    <td><a href="/SuperController/ToEditTA?adminID=${teamAdmin.adminID}">编辑权限</a> </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        // 检查信息并弹出提示框
        window.onload = function() {
            var Message = "${message}";
            if (Message) {
                alert(Message);
            }
        };
    </script>
</body>
</html>
