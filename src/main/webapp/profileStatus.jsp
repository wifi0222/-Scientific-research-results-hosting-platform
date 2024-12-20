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
    <title>修改状态</title>
</head>
<body>
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

<a href="/user/profile">修改个人信息</a>
</body>
</html>
