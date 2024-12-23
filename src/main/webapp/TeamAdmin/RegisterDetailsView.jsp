<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核用户注册查看详情</title>
</head>
<body>
    <h1>待审核用户详情</h1>
    用户名：<span>${registrationReview.username}</span>
    用户类型：
    <span>
      <c:choose>
          <c:when test="${registrationReview.roleType == 'TeamMember'}">团队成员</c:when>
          <c:when test="${registrationReview.roleType == 'Visitor'}">普通用户</c:when>
      </c:choose>
    </span>
    用户邮箱：<span>${registrationReview.email}</span>
    用户注册时间：<span><fmt:formatDate value="${registrationReview.registrationTime}" pattern="yyyy-MM-dd" /></span>
    用户申请理由：<span>${registrationReview.applicationReason}</span>
    <a href="/teamAdmin/ToUserRegisterManage">返回审核注册页面</a>
</body>
</html>
