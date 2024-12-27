<%--
  Created by IntelliJ IDEA.
  User: 86136
  Date: 2024/12/27
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>团队信息查看</title>
    <link rel="stylesheet" href="/css/change-password.css">
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <script src="/js/browse.js" defer></script>
    <style>
        /* 按钮样式 */
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .btn-edit {
            background-color: #4e73df;
            color: white;
            font-weight: bold;
        }

        .btn-edit:hover {
            background-color: #355db3;
        }

        .title{
            color: black;
        }

        .mtitle{
            color: #4e73df;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>

            <!-- Main Content -->
            <div class="main">
                <div class="section">
                    <h1 style="color: black" class="title">团队简介</h1>
                    <div class="intro-content">
                        <p>团队名称：<c:out value="${team.teamName}"/></p>
                        <p>研究方向：<c:out value="${team.researchArea}"/></p>
                        <p>简介：<c:out value="${team.introduction}" escapeXml="false"/></p>
                    </div>


                </div>
                <h1 class="mtitle">团队成员</h1>
                <div class="members-list">
                    <c:forEach var="member" items="${teamMembers}">
                        <div class="member-card">
                            <c:choose>
                                <c:when test="${not empty member.avatarFile}">
                                    <a href="/memberManage/details?teamMembersID=${member.userID}">
                                        <c:set var="encodedPath"
                                               value="${fn:replace(fn:replace(member.avatarFile, '\\\\', '/'), ' ', '%20')}"/>
                                        <img src="<c:url value='/getImage?filePath=${encodedPath}' />" class="member-avatar">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/memberManage/details?teamMembersID=${member.userID}">
                                        <img src="/resources/OIP.jpg" class="member-avatar">
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <div class="member-name">
                                <a href="/memberManage/details?teamMembersID=${member.userID}">
                                    <c:out value="${member.name}" />
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div>
                    <button class="btn btn-edit" onclick="window.location.href='/teamAdmin/TeamManage/ToEdit'">修改团队信息</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
