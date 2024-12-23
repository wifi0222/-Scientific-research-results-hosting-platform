<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 19:50
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
    <title>团队基本信息维护</title>

    <!-- 引入外部CSS库（例如Bootstrap）进行美化 -->
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">--%>
    <link rel="stylesheet" href="/css/sidebar.css">
    <style>
        h1 {
            text-align: center;
            color: #4e73df;
            margin-bottom: 20px;
        }

        /*form {*/
        /*    display: flex;*/
        /*    flex-direction: column;*/
        /*    gap: 20px;*/
        /*}*/

        label {
            font-size: 16px;
            color: #333;
        }

        input[type="text"], input[type="date"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="date"]:focus {
            border-color: #4e73df;
            box-shadow: 0 0 5px rgba(78, 115, 223, 0.5);
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4e73df;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2e59d9;
        }

        .readonly {
            background-color: #f1f1f1;
        }

    </style>
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

    <div class="content">
        <div class="main">
            <div class="section">
                <h1>团队基本信息维护</h1>

                <form action="/teamAdmin/TeamManage/Info/edit" method="get">
                    <div>
                        <label for="teamID">团队ID：</label>
                        <input type="text" id="teamID" name="teamID" value="${team.teamID}" readonly class="readonly">
                    </div>

                    <div>
                        <label for="teamName">团队名称：</label>
                        <input type="text" id="teamName" name="teamName" value="${team.teamName}">
                    </div>

                    <div>
                        <label for="researchArea">团队研究领域：</label>
                        <input type="text" id="researchArea" name="researchArea" value="${team.researchArea}">
                    </div>

                    <div>
                        <label for="introduction">团队简介：</label>
                        <input type="text" id="introduction" name="introduction" value="${team.introduction}">
                    </div>

                    <div>
                        <label for="creationTime">团队创建时间：</label>
                        <input type="date" id="creationTime" name="creationTime" value="<fmt:formatDate value="${team.creationTime}" pattern="yyyy-MM-dd" />">
                    </div>

                    <div>
                        <input type="submit" value="提交修改">
                    </div>
                </form>
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
