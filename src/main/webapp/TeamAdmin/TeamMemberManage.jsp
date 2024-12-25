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
    <link rel="stylesheet" href="/css/newSidebar.css">
    <link rel="stylesheet" href="/css/teamMemberManage.css">

    <script>
        window.onload = function () {
            var errorMessage = "${information}";
            if (errorMessage) {
                alert(errorMessage);
            }
        };
    </script>

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

        .btn-add {
            margin-top: 20px;
            margin-left: 20px;
            background-color: #3e8e41;
            color: white;
            font-weight: bold;
        }

        .btn-add:hover {
            background-color: darkgreen;
        }

        .btn-add i {
            margin-right: 8px;
        }

        .btn-preview{
            padding: 6px 12px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
        }

            .search-filter input[type="text"],
            .search-filter input[type="date"],
            .search-filter select {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                outline: none;
                font-size: 14px;
            }

    </style>
</head>

<body>
<div class="container">
    <!-- Sidebar -->
    <div class="content">
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

        <div class="main">
            <!-- 这里填充主内容，例如文章、图片等 -->
            <div class="section">
                <h1>团队成员信息管理</h1>

                <!-- 搜索与筛选表单 -->
                <div class="search-filter">
                    <label for="keyword">用户名：</label>
                    <input type="text" id="keyword" placeholder="请输入用户姓名">


                    <label for="startDate">注册时间从：</label>
                    <input type="date" id="startDate">

                    <label for="endDate">到：</label>
                    <input type="date" id="endDate">

                    <button type="button" id="searchButton">搜索</button>
                    <button type="button" id="resetButton">重置</button>
                </div>

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
                        <tr class="one-row"
                            data-name="${member.name}"
                            data-creationTime="${member.registrationTime}">

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
                                <button class="btn-preview" onclick="window.location.href='/teamAdmin/ToChangeTeamMember?userID=${member.userID}'">
                                    <i class="fas fa-edit"></i> 编辑
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                    <button onclick="window.location.href='/TeamAdmin/addTeamMember.jsp'" class="btn btn-add">
                        <i class="fas fa-plus-circle"></i>添加新团队成员
                    </button>
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


<!-- 引入外部JS文件 -->
<script src="/js/teamMemberManage.js"></script>
</body>
</html>

