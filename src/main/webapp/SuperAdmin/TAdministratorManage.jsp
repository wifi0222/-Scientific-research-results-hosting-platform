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
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/superuserManage.css">
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

    </style>
</head>
<body>
<div class="container">
    <div class="sidebar">
        <c:choose>
            <c:when test="${userRoleType == 'SuperAdmin'}">
                <ul>
                    <li><a href="/SuperController/UserManagement" class="active">用户管理</a></li>
                    <li><a href="/SuperController/TeamAdministratorManagement">权限管理</a></li>
                    <li><a href="/user/checkReply">内容审核</a></li>
                </ul>
                <div class="logout">
                    <a href="/user/logout">退出登录</a>
                </div>
            </c:when>
            <c:otherwise>
                <ul>
                    <li><a href="/login.jsp">登录</a></li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="content">
        <div class="main">
            <div class="section">

                <h1>超级用户权限管理</h1>

                <%-- 提示信息 --%>
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>


                <!-- 权限管理表格 -->
                <table class="styled-table">
                    <thead>
                    <tr>
                        <th>用户ID</th>
                        <th>用户名</th>
                        <th>管理员姓名</th>
                        <th>发布权限</th>
                        <th>用户权限</th>
                        <th>删除权限</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${teamAdministrators}" var="teamAdmin">
                        <tr class="one-row"
                            data-name="${teamAdmin.adminName}">
                            <td>${teamAdmin.adminID}</td>
                            <td>${teamAdmin.adminUsername}</td>
                            <td>${teamAdmin.adminName}</td>
                            <td class="permission">
                                        <span class="${teamAdmin.publishPermission ? 'has' : 'no'}">
                                                ${teamAdmin.publishPermission ? '有权限' : '无权限'}
                                        </span>
                            </td>
                            <td class="permission">
                                        <span class="${teamAdmin.userPermission ? 'has' : 'no'}">
                                                ${teamAdmin.userPermission ? '有权限' : '无权限'}
                                        </span>
                            </td>
                            <td class="permission">
                                        <span class="${teamAdmin.deletePermission ? 'has' : 'no'}">
                                                ${teamAdmin.deletePermission ? '有权限' : '无权限'}
                                        </span>
                            </td>
                            <td>
                                <a href="/SuperController/ToEditTA?adminID=${teamAdmin.adminID}" class="btn-edit">
                                    <i class="fas fa-edit"></i> 编辑权限
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
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
</body>
</html>
