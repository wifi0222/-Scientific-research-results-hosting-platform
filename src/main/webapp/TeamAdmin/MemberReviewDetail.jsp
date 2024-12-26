<%--
  Created by IntelliJ IDEA.
  User: 86136
  Date: 2024/12/25
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>团队成员信息修改详情</title>
<%--    <link rel="stylesheet" href="/css/newSidebar.css">--%>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <style>
        /* 新增：父容器使用flex布局，使Toptitle和back-btn并列展示 */
        .header-container {
            display: flex;
            justify-content: center;  /* 水平居中对齐 */
            align-items: center;      /* 垂直居中对齐 */
            gap: 20px;                /* 在标题和按钮之间添加间距 */
        }

        /* 使Toptitle居中 */
        .Toptitle {
            color: #4e73df;
            margin-bottom: 20px;
            font-size: 28px;
            padding-bottom: 10px;
            text-align: center;
            flex-grow: 1;             /* 使标题占据可用空间 */
        }

        /* 按钮样式 */
        .back-btn {
            background-color: #4e73df; /* 按钮背景色 */
            border: none;
            border-radius: 5px; /* 圆角边框 */
            padding: 12px 20px;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
        }

        .back-btn a {
            text-decoration: none;
            color: white;
            display: flex;  /* 使用flex布局使图标居中 */
            align-items: center;
            justify-content: center;
        }

        /* 隐藏链接中的文字，只显示图标 */
        .back-btn a i {
            font-size: 20px; /* 设置图标大小 */
        }

        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }

        /* 头像和个人信息 */
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }


        .profile-avatar img{
            margin-right: 20px;
            width: 250px;
            height: 300px;
        }

        .avatar-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }

        .profile-info h1 {
            font-size: 24px;
            color: #333;
            margin: 0;
        }

        .profile-info p {
            font-size: 16px;
            color: #555;
        }

        .profile-info strong {
            color: #333;
        }

        /* 内容部分 */
        .content-section {
            margin: 20px 0;
            padding: 15px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #4e73df;
            margin-bottom: 10px;
        }

        .content-section p {
            font-size: 16px;
            color: #333;
            line-height: 1.6;
        }

        /* 提示信息 */
        .content-section p {
            word-wrap: break-word; /* 防止长文本溢出 */
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .profile-avatar {
                margin-bottom: 20px;
            }

            .avatar-img {
                width: 100px;
                height: 100px;
            }

            .profile-info h1 {
                font-size: 20px;
            }

            .profile-info p {
                font-size: 14px;
            }
        }

    </style>
</head>
<body>
<div class="container">
    <div class="content">
        <!-- Sidebar -->
<%--        <div class="sidebar">--%>
<%--            <c:choose>--%>
<%--                <c:when test="${userRoleType == 'TeamAdmin'}">--%>
<%--                    <ul>--%>
<%--                        <li><a href="javascript:void(0);">团队管理</a>--%>
<%--                            <ul class="submenu">--%>
<%--                                <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>--%>
<%--                                <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>--%>
<%--                                <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>--%>
<%--                            </ul>--%>
<%--                        </li>--%>
<%--                        <li><a href="javascript:void(0);">科研成果管理与发布</a>--%>
<%--                            <ul class="submenu">--%>
<%--                                <li><a href="/research/submenu1">子菜单项1</a></li>--%>
<%--                                <li><a href="/research/submenu2">子菜单项2</a></li>--%>
<%--                            </ul>--%>
<%--                        </li>--%>
<%--                        <li><a href="javascript:void(0);">文章管理</a>--%>
<%--                            <ul class="submenu">--%>
<%--                                <li><a href="/article/submenu1">子菜单项1</a></li>--%>
<%--                                <li><a href="/article/submenu2">子菜单项2</a></li>--%>
<%--                            </ul>--%>
<%--                        </li>--%>
<%--                        <li><a href="javascript:void(0);">用户管理</a>--%>
<%--                            <ul class="submenu">--%>
<%--                                <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>--%>
<%--                                <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>--%>
<%--                            </ul>--%>
<%--                        </li>--%>
<%--                        <li><a href="javascript:void(0);">在线交流与反馈</a>--%>
<%--                            <ul class="submenu">--%>
<%--                                <li><a href="/feedback/submenu1">子菜单项1</a></li>--%>
<%--                                <li><a href="/feedback/submenu2">子菜单项2</a></li>--%>
<%--                            </ul>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                    <div class="logout">--%>
<%--                        <a href="/user/logout">退出登录</a>--%>
<%--                    </div>--%>
<%--                </c:when>--%>
<%--                <c:otherwise>--%>
<%--                    <!-- 普通用户的菜单项，若有的话 -->--%>
<%--                    <a href="user/ManagementLogin">管理员登录</a>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>
<%--        </div>--%>
        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>

        <div class="main">
            <!-- 这里填充主内容，例如文章、图片等 -->
            <div class="section">
                <div class="header-container">
                    <button class="back-btn">
                        <a href="/teamAdmin/ToMemberInfoReview">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">成员信息修改详情</h1>
                </div>

                <c:if test="${not empty member}">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <c:choose>
                                <c:when test="${not empty member.avatarFile}">
                                    <!-- 如果头像存在，显示头像 -->
                                    <c:set var="encodedPath"
                                           value="${fn:replace(fn:replace(member.avatarFile, '\\\\', '/'), ' ', '%20')}"/>
                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="头像"/>
                                </c:when>
                                <c:otherwise>
                                    <!-- 如果没有头像，显示默认头像 -->
                                    <img src="../resources/OIP.jpg" alt="默认头像"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="profile-info">
                            <h1><c:out value="${member.name}" /></h1>
                            <p><strong>联系方式：</strong><c:out value="${member.contactInfo}" /></p>
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
