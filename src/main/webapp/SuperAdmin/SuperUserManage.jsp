<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/17
  Time: 18:46
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
    <title>超级管理员用户管理</title>
    <!-- 引入基本样式 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/superuserManage.css">

    <script type="text/javascript">
        // 在删除按钮点击时，弹出确认框
        function confirmDelete(userID) {
            showConfirmModal(userID);
        }

        // 弹出通过审核模态框函数
        function showConfirmModal(userID) {
            var modal = document.getElementById("deleteModal");
            var modalContent = document.querySelector("#deleteModal .modal-content");
            modal.style.display = "block";

            // 添加显示动画
            setTimeout(function() {
                modalContent.classList.add("show");
            }, 10);

            // 关闭按钮事件
            var closeBtn = document.getElementsByClassName("close-approve")[0];
            closeBtn.onclick = function() {
                closeConfirmModal();
            };

            // 确定按钮事件
            var approveButton = document.getElementById("approveButton");
            approveButton.onclick = function() {
                // 通过审核，跳转并传递审核结果
                window.location.href = "/SuperController/TeamAdminManage/delete?userID=" + userID;
            };
        }

        // 关闭模态框的函数
        function closeConfirmModal() {
            var modal = document.getElementById("deleteModal");
            var modalContent = document.querySelector("#deleteModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        }
    </script>
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

                <!-- 搜索与筛选表单 -->
                <div class="search-filter">
                    <label for="keyword">姓名：</label>
                    <input type="text" id="keyword" placeholder="请输入姓名">

                    <label for="startDate">申请时间从：</label>
                    <input type="date" id="startDate">

                    <label for="endDate">到：</label>
                    <input type="date" id="endDate">

                    <button type="button" id="searchButton">搜索</button>
                    <button type="button" id="resetButton">重置</button>
                </div>

                <%-- 展示团队管理员列表 --%>
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>

                <!-- 如果存在error属性，显示弹窗提示 -->
                <div th:if="${AddTeamAdminRemind}" th:text="${AddTeamAdminRemind}" class="alert alert-error"></div>

                <h1 class="page-title">团队管理员</h1>
                <div class="section">
                    <table class="styled-table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAllCheckbox"/>
                                全选
                            </th>
                            <th>用户ID</th>
                            <th>用户名</th>
                            <th>姓名</th>
                            <th>邮箱</th>
                            <th>管理团队</th>
                            <th>注册时间</th>
                            <th>账号状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr class="one-row"
                                data-name="${user.name}"
                                data-creationTime="${user.registrationTime}">
                                <td>
                                    <input type="checkbox"
                                           class="rowCheckbox"
                                           name="selectedRows"
                                           value="${user.username}">
                                </td>
                                <td>${user.userID}</td>
                                <td>${user.username}</td>
                                <td>${user.name}</td>
                                <td>${user.email}</td>
                                <td>团队名称</td>
                                <td>
                                    <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status == 1}">正常</c:when>
                                        <c:when test="${user.status == 0}">禁用</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="/SuperController/ToChangeTeamAdmin?userID=${user.userID}" class="btn-preview">
                                            <i class="fas fa-edit"></i> 编辑
                                        </a>
                                        <a href="javascript:void(0);" onclick="confirmDelete(${user.userID})" class="btn-reject">
                                            <i class="fas fa-trash-alt"></i> 删除
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <a href="/SuperController/ToAddTeamAdmin" class="btn btn-add">添加团队管理员</a>
            </div>
        </div>
    </div>
</div>

<!-- 删除确认模态框 -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="close-approve">&times;</span>
        <p>确定要删除该管理员吗？</p>
        <button id="approveButton" class="modal-button">确定</button>
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

<%-- 显示添加团队管理员是否成功 --%>
<script>
    // 检查错误信息并弹出提示框
    window.onload = function() {
        var errorMessage = "${AddTeamAdminRemind}";
        if (errorMessage) {
            alert(errorMessage);
        } else {
            errorMessage = "${ChangeTeamAdminRemind}";
            if (errorMessage) {
                alert(errorMessage);
            }
        }
    };

</script>

<script src="/js/superUserManage.js"></script>

</body>
</html>
