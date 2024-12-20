<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核用户注册</title>
    <script type="text/javascript">
        // 通过审核的函数
        function approveReview(username) {
            if (confirm("确定通过审核吗？")) {
                // 通过审核，跳转并传递审核结果
                window.location.href = "SubmitRegisterReview?username=" + username + "&status=1";
            }
        }

        // 不通过审核的函数
        function rejectReview(username) {
            // 弹出框让用户输入拒绝理由
            var refuseReason = prompt("请输入拒绝理由：");
            if (refuseReason != null && refuseReason != "") {
                // 不通过审核，跳转并传递审核结果及拒绝理由
                window.location.href = "SubmitRegisterReview?username=" + username + "&status=0"+"&refuseReason=" + encodeURIComponent(refuseReason);
            } else {
                alert("拒绝理由不能为空！");
            }
        }
    </script>
</head>
<body>
<h1>待审核用户列表</h1>
<table border="1">
    <thead>
    <tr>
        <th>用户名</th>
        <th>注册时间</th>
        <th></th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.username}</td>
            <td>
                <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>${user.applicationReason}</td>
            <td>
                <!-- 详情按钮 -->
                <a href="RegisterDetails?username=${user.username}">详情</a>
                <a href="javascript:void(0);" onclick="approveReview(${user.username})">通过</a> |
                <a href="javascript:void(0);" onclick="rejectReview(${user.username})">不通过</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
