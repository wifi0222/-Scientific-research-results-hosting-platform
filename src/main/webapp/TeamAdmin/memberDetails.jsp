<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成员详情</title>
    <link rel="stylesheet" href="/css/change-password.css">
</head>
<body>
<div class="container">
    <div class="content">
        <!-- Main Content -->
        <div class="main">
            <div class="section">
                <h1>成员详情</h1>

                <!-- 错误信息 -->
                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <!-- 成员信息 -->
                <c:if test="${not empty member}">
                    <div class="member-details">
                        <p><strong>姓名：</strong><c:out value="${member.name}" /></p>
                        <p><strong>职务：</strong>
                            <c:choose>
                                <c:when test="${member.roleType == 'TeamMember'}">团队成员</c:when>
                                <c:when test="${member.roleType == 'Visitor'}">普通用户</c:when>
                                <c:otherwise>未知角色</c:otherwise>
                            </c:choose>
                        </p>
                        <p><strong>研究方向：</strong><c:out value="${member.researchField}" /></p>
                        <p><strong>学术背景：</strong><c:out value="${member.academicBackground}" /></p>
                        <p><strong>联系方式：</strong><c:out value="${member.contactInfo}" /></p>
                        <p><strong>科研成果：</strong><c:out value="${member.researchAchievements}" /></p>
                    </div>
                </c:if>

                <div class="action-links">
                    <a href="/browse" class="btn-submit">返回</a>
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
