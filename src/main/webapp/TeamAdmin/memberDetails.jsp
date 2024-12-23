<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: 王斐--%>
<%--  Date: 2024/12/20--%>
<%--  Time: 09:25--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%--<%@ page isELIgnored="false" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>成员详情</title>--%>
<%--    <link rel="stylesheet" href="/css/change-password.css">--%>
<%--    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">--%>
<%--    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <div class="content">--%>
<%--        <!-- Main Content -->--%>
<%--        <div class="main">--%>
<%--            <div class="section">--%>
<%--                <h1>成员详情</h1>--%>

<%--                <!-- 错误信息 -->--%>
<%--                <c:if test="${not empty error}">--%>
<%--                    <p class="error-message">${error}</p>--%>
<%--                </c:if>--%>

<%--                <!-- 成员信息 -->--%>
<%--                <c:if test="${not empty member}">--%>
<%--                    <div class="member-details">--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${not empty member.avatarFile}">--%>
<%--                                <!-- 如果头像存在，显示头像 -->--%>
<%--                                <c:set var="encodedPath"--%>
<%--                                       value="${fn:replace(fn:replace(member.avatarFile, '\\\\', '/'), ' ', '%20')}"/>--%>
<%--                                <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="头像" style="max-width: 150px; height: auto;"/>--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                <!-- 如果没有头像，显示默认头像 -->--%>
<%--                                <img src="/resources/OIP.jpg" alt="默认头像" style="max-width: 150px; height: auto;"/>--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>
<%--                        <p><strong>姓名：</strong><c:out value="${member.name}" /></p>--%>
<%--                        <p><strong>职务：</strong>--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${member.roleType == 'TeamMember'}">团队成员</c:when>--%>
<%--                                <c:when test="${member.roleType == 'Visitor'}">普通用户</c:when>--%>
<%--                                <c:otherwise>未知角色</c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </p>--%>
<%--                        <p><strong>研究方向：</strong><c:out value="${member.researchField}" /></p>--%>
<%--                        <p><strong>学术背景：</strong><c:out value="${member.academicBackground}" /></p>--%>
<%--                        <p><strong>联系方式：</strong><c:out value="${member.contactInfo}" /></p>--%>
<%--                        <p><strong>科研成果：</strong><c:out value="${member.researchAchievements}" escapeXml="false" /></p>--%>
<%--                    </div>--%>
<%--                </c:if>--%>

<%--                <div class="action-links">--%>
<%--                    <a href="/browse" class="btn-submit">返回</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <footer>--%>
<%--        ABCD组 &copy; 2024--%>
<%--    </footer>--%>

<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成员详情</title>
    <link rel="stylesheet" href="/css/change-password.css">
    <style>
        /* 页面标题 */
        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #4e73df; /* 蓝色标题 */
            margin: 20px 0;
        }

        /* 头部背景和头像样式 */
        .profile-header {
            display: flex;
            align-items: center;
            padding: 20px;
            background: linear-gradient(to right, #4e73df, #ffffff); /* 蓝色渐变 */
            color: #ffffff;
            margin-bottom: 20px;
            position: relative;
            height: 200px; /* 背景高度 */
        }

        .profile-header img {
            position: absolute;
            top: -60px; /* 头像上端超出背景 */
            left: 20px;
            width: 160px;
            height: 240px;
            object-fit: cover;
            border: none;
        }

        .profile-header .profile-info {
            margin-left: 200px; /* 为头像预留空间 */
        }

        .profile-header h1 {
            color: #ffffff;
            margin: 0;
            font-size: 28px; /* 更大的字体 */
            font-weight: bold;
        }

        .profile-header p {
            margin: 5px 0;
            font-size: 18px; /* 增大字体 */
        }

        /* Section Title 样式 */
        .section-title {
            font-size: 22px;
            font-weight: bold;
            color: #4e73df;
            margin-bottom: 15px;
            border-bottom: 2px solid #4e73df;
            padding-bottom: 5px;
            display: inline-block;
        }

        /* 内容样式 */
        .content-section {
            margin-bottom: 20px;
        }

        .content-section p {
            font-size: 16px;
            margin: 5px 0;
            color: #333;
        }

        /* 返回按钮样式 */
        .action-links a {
            display: inline-block;
            background-color: #4e73df;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .action-links a:hover {
            background-color: #3758c8;
        }

    </style>
</head>
<body>
<div class="container">
    <!-- 页面标题 -->
    <div class="page-title">成员详情</div>

    <div class="content">
        <!-- Main Content -->
        <div class="main">
            <!-- 头部个人信息展示 -->
            <c:if test="${not empty member}">
                <div class="profile-header">
                    <c:choose>
                        <c:when test="${not empty member.avatarFile}">
                            <!-- 如果头像存在，显示头像 -->
                            <c:set var="encodedPath"
                                   value="${fn:replace(fn:replace(member.avatarFile, '\\\\', '/'), ' ', '%20')}"/>
                            <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="头像"/>
                        </c:when>
                        <c:otherwise>
                            <!-- 如果没有头像，显示默认头像 -->
                            <img src="/resources/OIP.jpg" alt="默认头像"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="profile-info">
                        <h1><c:out value="${member.name}" /></h1>
                        <p>职务：<c:choose>
                            <c:when test="${member.roleType == 'TeamMember'}">团队成员</c:when>
                            <c:when test="${member.roleType == 'Visitor'}">普通用户</c:when>
                            <c:otherwise>未知角色</c:otherwise>
                        </c:choose>
                        </p>
                        <p><strong>联系方式：</strong><c:out value="${member.contactInfo}" /></p>
                        <p><strong>Email：</strong><c:out value="${member.email}" /></p>
                    </div>
                </div>
            </c:if>

            <!-- 研究方向 -->
            <div class="content-section">
                <h2 class="section-title">研究方向</h2>
                <p><c:out value="${member.researchField}" /></p>
            </div>

            <div class="content-section">
                <h2 class="section-title">学术背景</h2>
                <p><c:out value="${member.academicBackground}" /></p>
            </div>

            <div class="content-section">
                <h2 class="section-title">科研成果</h2>
                <p><c:out value="${member.researchAchievements}" escapeXml="false" /></p>
            </div>

            <!-- 返回按钮 -->
            <div class="action-links">
                <a href="/browse" class="btn-submit">返回</a>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>
</body>
</html>
