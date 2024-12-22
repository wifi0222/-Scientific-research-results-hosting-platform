<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>成员信息审核</title>
    <script type="text/javascript">
        // 通过审核的函数
        function approveReview(memberID) {
            if (confirm("确定通过审核吗？")) {
                // 通过审核，跳转并传递审核结果
                window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=1";
            }
        }

        // 不通过审核的函数
        function rejectReview(memberID) {
            // 弹出框让用户输入拒绝理由
            var refuseReason = prompt("请输入拒绝理由：");
            if (refuseReason != null && refuseReason != "") {
                // 不通过审核，跳转并传递审核结果及拒绝理由
                window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=0"+"&refuseReason=" + encodeURIComponent(refuseReason);
            } else {
                alert("拒绝理由不能为空！");
            }
        }
    </script>
</head>
<body>
<h2>用户信息审核</h2>
<table border="1">
    <thead>
    <tr>
        <th>用户ID</th>
        <th>姓名</th>
        <th>研究方向</th>
        <th>联系方式</th>
        <th>学术背景</th>
        <th>科研成果</th>
        <th>审核操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="review" items="${memberReviews}">
        <tr>
            <td>${review.memberID}</td>
            <td>${review.name}</td>
            <td>${review.researchField}</td>
            <td>${review.contactInfo}</td>
            <td>${review.academicBackground}</td>
            <td>${review.researchAchievements}</td>
            <td>
                <a href="javascript:void(0);" onclick="approveReview(${review.memberID})">通过</a> |
                <a href="javascript:void(0);" onclick="rejectReview(${review.memberID})">不通过</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    // 检查错误信息并弹出提示框
    window.onload = function() {
        var errorMessage = "${message}";
        if (errorMessage) {
            alert(errorMessage);
        }else{
            errorMessage="${message}";
            if (errorMessage){
                alert(errorMessage);
            }
        }
    };
</script>
</body>
</html>


