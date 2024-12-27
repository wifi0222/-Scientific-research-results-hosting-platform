<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>超级用户进行权限管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/administrator.css">
    <style>
        /* 权限状态的颜色和图标 */
        .has {
            color: #28a745;
            font-weight: bold;
        }

        .no {
            color: #dc3545;
            font-weight: bold;
        }

        .has::before {
            content: "\f00c"; /* FontAwesome check icon */
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            margin-right: 5px;
        }

        .no::before {
            content: "\f00d"; /* FontAwesome times icon */
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            margin-right: 5px;
        }

        /* 编辑按钮样式 */
        .btn-edit {
            background-color: #4e73df;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn-edit i {
            margin-right: 8px;
        }

        .btn-edit:hover {
            background-color: #3578f3;
        }

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

        .btn-pass {
            margin-top: 20px;
            margin-left: 20px;
            background-color: #3e8e41;
            color: white;
            font-weight: bold;
        }

        .btn-pass:hover {
            background-color: darkgreen;
        }

        .main h1 {
            text-align: center;
            color: #4a4a4a;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/SuperAdmin/sidebar.jsp"/>

        <div class="main">
<%--            <div class="section">--%>
                <h1>管理团队管理员操作权限</h1>
                <!-- 搜索与筛选表单 -->
                <div class="search-filter">
                    <label for="keyword">姓名：</label>
                    <input type="text" id="keyword" placeholder="请输入姓名">

                    <button type="button" id="searchButton">搜索</button>
                    <button type="button" id="resetButton">重置</button>
                </div>

                <div class="section-active">

                    <!-- 权限管理表格 -->
                    <table class="styled-table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAllCheckbox"/>
                                全选
                            </th>
<%--                            <th>ID</th>--%>
                            <th>用户名</th>
<%--                            <th>姓名</th>--%>
                            <th>用户管理</th>
                            <th>成果发布</th>
                            <th>成果删除</th>
                            <th>成果编辑</th>
                            <th>成果状态</th>
                            <th>文章发布</th>
                            <th>文章删除</th>
                            <th>文章编辑</th>
                            <th>文章状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${teamAdministrators}" var="teamAdmin">
                            <tr class="one-row"
                                data-name="${teamAdmin.adminName}">
                                <td>
                                    <input type="checkbox"
                                           class="rowCheckbox"
                                           name="selectedRows"
                                           value="${teamAdmin.adminID}">
                                </td>
<%--                                <td>${teamAdmin.adminID}</td>--%>
                                <td>${teamAdmin.adminUsername}</td>
<%--                                <td>${teamAdmin.adminName}</td>--%>
                                <td class="permission">
                                            <span class="${teamAdmin.userPermission ? 'has' : 'no'}">
<%--                                                    ${teamAdmin.userPermission ? '有权限' : '无权限'}--%>
                                            </span>
                                </td>
                                <td class="permission">
                                            <span class="${teamAdmin.publishAchievement ? 'has' : 'no'}">
<%--                                                    ${teamAdmin.publishAchievement ? '有权限' : '无权限'}--%>
                                            </span>
                                </td>
                                <td class="permission">
                                            <span class="${teamAdmin.deleteAchievement ? 'has' : 'no'}">
<%--                                                    ${teamAdmin.deleteAchievement ? '有权限' : '无权限'}--%>
                                            </span>
                                </td>
                                <td class="permission">
                                    <span class="${teamAdmin.editAchievement ? 'has':'no'}">
<%--                                        ${teamAdmin.editAchievement ? '有权限' : '无权限'}--%>
                                    </span>
                                </td>
                                <td class="permission">
                                    <span class="${teamAdmin.setAchievementStatus ? 'has':'no'}">
<%--                                            ${teamAdmin.setAchievementStatus ? '有权限' : '无权限'}--%>
                                    </span>
                                </td>

                                <td class="permission">
                                            <span class="${teamAdmin.publishArticle ? 'has' : 'no'}">
<%--                                                    ${teamAdmin.publishArticle ? '有权限' : '无权限'}--%>
                                            </span>
                                </td>
                                <td class="permission">
                                            <span class="${teamAdmin.deleteArticle ? 'has' : 'no'}">
<%--                                                    ${teamAdmin.deleteArticle ? '有权限' : '无权限'}--%>
                                            </span>
                                </td>
                                <td class="permission">
                                    <span class="${teamAdmin.editArticle ? 'has':'no'}">
<%--                                            ${teamAdmin.editArticle ? '有权限' : '无权限'}--%>
                                    </span>
                                </td>
                                <td class="permission">
                                    <span class="${teamAdmin.setArticleStatus ? 'has':'no'}">
<%--                                            ${teamAdmin.setArticleStatus ? '有权限' : '无权限'}--%>
                                    </span>
                                </td>

                                <td>
    <%--                                <a href="/SuperController/ToEditTA?adminID=${teamAdmin.adminID}" class="btn-edit">--%>
    <%--                                    <i class="fas fa-edit"></i> 编辑权限--%>
    <%--                                </a>--%>
                                        <button onclick="window.location.href='/SuperController/ToEditTA?adminID=${teamAdmin.adminID}'" class="btn-edit">
                                            <i class="fas fa-edit"></i> 编辑
                                        </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <button type="button" id="batchUserButton" class="btn btn-pass">
                        设置用户权限
                    </button>

                    <button type="button" id="batchResearchButton" class="btn btn-pass">
                        设置科研成果权限
                    </button>

                    <button type="button" id="batchArticleButton" class="btn btn-pass">
                        设置文章权限
                    </button>
                </div>
        </div>
    </div>
</div>

<!-- 用户权限设置模态框 -->
<div id="UserModal" class="modal">
    <div class="modal-content">
        <span class="close-user">&times;</span>
        <p>确定要为选中的管理员设置用户管理权限吗？</p>
        <button id="userButton" class="modal-button">确定</button>
    </div>
</div>

<!-- 科研成果设置模态框 -->
<div id="researchModal" class="modal">
    <div class="modal-content">
        <span class="close-research">&times;</span>
        <p>确定要为选中的管理员设置科研成果的全部权限吗？</p>
        <button id="researchButton" class="modal-button">确定</button>
    </div>
</div>

<!-- 文章设置模态框 -->
<div id="articleModal" class="modal">
    <div class="modal-content">
        <span class="close-article">&times;</span>
        <p>确定要为选中的管理员设置文章的全部权限吗？</p>
        <button id="articleButton" class="modal-button">确定</button>
    </div>
</div>
<script>
    // 检查信息并弹出提示框
    window.onload = function() {
        var Message = "${message}";
        if (Message) {
            alert(Message);
        }
    };
</script>

<script src="../js/administrator.js"></script>
</body>
</html>
