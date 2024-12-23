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

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>团队成员管理</title>

    <!-- 引入外部CSS库（例如Bootstrap）进行美化 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* 页面基础样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #eaf4fc;
            color: #333;
        }

        .container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content {
            display: flex;
            flex: 1;
        }

        /* 左侧导航栏样式 */
        .sidebar {
            width: 250px;
            background-color: #ffffff;
            border-right: 1px solid #e3e6f0;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            flex-shrink: 0;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar ul li {
            display: block;
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #333;
            display: block;
            padding: 10px 15px;
            border-radius: 10px;
            transition: background-color 0.3s, color 0.3s;
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #4e73df;
            color: #ffffff;
            border: 2px solid #4e73df;
            width: 100%;
            box-sizing: border-box;
            display: inline-block;
            border-radius: 10px;
        }

        .logout {
            margin-top: auto;
        }

        .logout a {
            text-decoration: none;
            background-color: #ff6f61;
            color: #ffffff;
            display: block;
            text-align: center;
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .logout a:hover {
            background-color: #e55d50;
        }

        /* 主体内容样式 */
        .main {
            flex-grow: 1;
            padding: 20px;
            display: grid;
            grid-template-areas:
            "carousel carousel"
            "intro articles"
            "soft book"
            "patent product";
            grid-gap: 20px;
        }

        .carousel {
            grid-area: carousel;
            width: 100%;
            height: 300px;
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .carousel img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 100%;
            transition: left 0.5s ease;
        }

        .carousel img.active {
            left: 0;
        }

        .carousel img.prev {
            left: -100%;
        }

        /* 各模块样式 */
        .section {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .section h2 {
            margin-top: 0;
            color: #4e73df;
            display: inline-block;
        }

        .section a {
            float: right;
            color: #4e73df;
            text-decoration: none;
            margin-top: 5px;
        }

        .section a:hover {
            text-decoration: underline;
        }

        /* 列表样式 */
        ul {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        ul li {
            margin: 5px 0;
            display: flex;
            justify-content: space-between;
        }

        ul li span {
            color: #666;
        }

        /* 页脚样式 */
        footer {
            text-align: center;
            padding: 10px;
            background-color: #e1effd;
            font-size: 14px;
            color: #555;
        }

        /* 侧边栏和页面布局 */
        .container {
            display: flex;
            flex-direction: row;
            padding: 20px;
            gap: 20px;
        }

        .content {
            flex-grow: 1;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .submenu {
            display: none; /* 默认子菜单隐藏 */
            list-style: none;
            padding-left: 20px;
            margin: 0;
        }

        .submenu.active {
            display: block; /* 显示子菜单 */
        }

        /* 父菜单 active 时样式 */
        .sidebar > ul > li > a.active {
            background-color: #4e73df;
            color: white;
        }

        .sidebar > ul > li > a.active + .submenu {
            display: block;
        }

        /* 表格样式 */
        .styled-table {
            border-collapse: collapse;
            width: 100%;
            margin: 25px 0;
            font-size: 16px;
            text-align: left;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .styled-table thead tr {
            background-color: #4e73df;
            color: #ffffff;
            text-align: left;
            font-weight: bold;
        }

        .styled-table th,
        .styled-table td {
            padding: 12px 15px;
        }

        .styled-table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .styled-table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .styled-table tbody tr:hover {
            background-color: #eaf4fc;
        }

        .edit-button {
            padding: 6px 12px;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .edit-button:hover {
            background-color: #355db3;
        }


        /* 按钮样式 */
        .add-member {
            display: inline-block;
            background-color: #28a745; /* 绿色背景 */
            color: white; /* 白色字体 */
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .add-member  font{
            color: white;
        }

    </style>

    <script>
        window.onload = function () {
            var errorMessage = "${information}";
            if (errorMessage) {
                alert(errorMessage);
            }
        };
    </script>
</head>

<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <c:choose>
            <c:when test="${userRoleType == 'TeamAdmin'}">
                <ul>
                    <li><a href="javascript:void(0);">团队管理</a>
                        <ul class="submenu">
                            <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                            <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                            <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">科研成果管理与发布</a>
                        <ul class="submenu">
                            <li><a href="/research/submenu1">子菜单项1</a></li>
                            <li><a href="/research/submenu2">子菜单项2</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">文章管理</a>
                        <ul class="submenu">
                            <li><a href="/article/submenu1">子菜单项1</a></li>
                            <li><a href="/article/submenu2">子菜单项2</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">用户管理</a>
                        <ul class="submenu">
                            <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                            <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);">在线交流与反馈</a>
                        <ul class="submenu">
                            <li><a href="/feedback/submenu1">子菜单项1</a></li>
                            <li><a href="/feedback/submenu2">子菜单项2</a></li>
                        </ul>
                    </li>
                </ul>
                <div class="logout">
                    <a href="/user/logout">退出登录</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 普通用户的菜单项，若有的话 -->
                <a href="user/ManagementLogin">管理员登录</a>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="main">
            <!-- 这里填充主内容，例如文章、图片等 -->
            <div class="section">
                <h1>团队成员管理</h1>
                <table class="styled-table">
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
                        <th>操作</th>
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
                            <td>
                                <c:choose>
                                    <c:when test="${member.status == 1}">正常</c:when>
                                    <c:when test="${member.status == 0}">禁用</c:when>
                                </c:choose>
                            </td>
                            <td>${member.researchField}</td>
                            <td>${member.contactInfo}</td>
                            <td>
                                <form action="/teamAdmin/ToChangeTeamMember" method="get">
                                    <input type="hidden" name="userID" value="${member.userID}">
                                    <input type="submit" value="编辑" class="edit-button">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <a href="/TeamAdmin/addTeamMember.jsp" class="add-member">添加新团队成员</a>
            </div>
            </div>
        </div>
    </div>
</div>

<footer>
    ABCD组 &copy; 2024
</footer>

<script>
    // 获取所有的a标签
    const menuLinks = document.querySelectorAll('ul > li > a');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // 如果是子菜单的链接，不阻止跳转
            if (this.nextElementSibling && this.nextElementSibling.classList.contains('submenu')) {
                // 这是父菜单，阻止跳转
                event.preventDefault(); // 阻止父菜单的默认跳转行为
                // 切换当前a标签的class
                this.classList.toggle('active');

                // 获取当前点击项的下一个子菜单
                const submenu = this.nextElementSibling;

                if (submenu && submenu.classList.contains('submenu')) {
                    // 切换子菜单的显示状态
                    submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
                }
            }
            // 对于子菜单项，允许跳转，不做任何处理
        });
    });
</script>

</body>
</html>

