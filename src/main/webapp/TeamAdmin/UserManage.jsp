<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/20
  Time: 8:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>注销账号、重置密码</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/userManage.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        /* ======== 搜索与筛选区域 ======== */
        .search-filter {
            display: flex;
            flex-wrap: wrap; /* 当空间不足时换行 */
            align-items: center;
            gap: 20px; /* 增加间距 */
            margin: 20px;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .search-filter label {
            font-weight: bold;
            margin-right: 10px;
        }

        .search-filter input[type="text"],
        .search-filter input[type="date"],
        .search-filter select {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px; /* 控制输入框宽度 */
            transition: border-color 0.3s ease;
        }

        .search-filter input[type="text"]:focus,
        .search-filter input[type="date"]:focus,
        .search-filter select:focus {
            border-color: #3e8e41; /* 聚焦时边框变绿色 */
            outline: none;
        }

        .search-filter button {
            background-color: #4e73df;
            color: #ffffff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .search-filter button:hover {
            background-color: #355db3;
        }

        /* 将前三个条件放在同一行，后三个条件放在下一行 */
        .search-filter .first-row,
        .search-filter .second-row {
            display: flex;
            gap: 20px;
            width: 100%;
        }

        .search-filter .first-row input,
        .search-filter .first-row select {
            width: auto;
        }

        .search-filter .second-row input,
        .search-filter .second-row select {
            width: auto;
        }

        /* 搜索按钮与“查看全部”和“查看申请注销”按钮并列显示 */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn-view-all {
            background-color: #4e73df;
            color: white;
            font-weight: bold;
        }

        .btn-view-all:hover {
            background-color: #355db3;
        }

        .btn-view-cancel {
            background-color: #f0ad4e;
            color: white;
            font-weight: bold;
        }

        .btn-view-cancel:hover {
            background-color: #ec971f;
        }

        /* 响应式布局 */
        @media (max-width: 768px) {
            .search-filter .first-row,
            .search-filter .second-row {
                flex-direction: column;
            }
        }


    </style>
    <script type="text/javascript">
        //确认注销
        function confirmLogout(userId) {
            showLogoutModal(userId);
        }

        //确认重置
        function confirmReset(userId) {
            showResetModal(userId);
        }
    </script>

    <script>
        // 弹出注销模态框函数
        function showLogoutModal(userId) {
            var modal = document.getElementById("LogoutModal");
            var modalContent = document.querySelector("#LogoutModal .modal-content");
            modal.style.display = "block";

            // 添加显示动画
            setTimeout(function() {
                modalContent.classList.add("show");
            }, 10);

            // 关闭按钮事件
            var closeBtn = document.getElementsByClassName("close-logout")[0];
            closeBtn.onclick = function() {
                closeLogoutModal();
            };

            // 确定按钮事件
            var approveLogoutButton = document.getElementById("approve-logout-Button");
            approveLogoutButton.onclick = function() {
                // 注销用户
                window.location.href = "/teamAdmin/UserManage/logoutUser?userID=" + userId;
            };
        }

        // 关闭模态框的函数
        function closeLogoutModal() {
            var modal = document.getElementById("LogoutModal");
            var modalContent = document.querySelector("#LogoutModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        }

        // 弹出通过重置模态框函数
        function showResetModal(userId) {
            var modal = document.getElementById("ResetModal");
            var modalContent = document.querySelector("#ResetModal .modal-content");
            modal.style.display = "block";

            // 添加显示动画
            setTimeout(function() {
                modalContent.classList.add("show");
            }, 10);

            // 关闭按钮事件
            var closeBtn = document.getElementsByClassName("close-reset")[0];
            closeBtn.onclick = function() {
                closeResetModal();
            };

            // 确定按钮事件
            var approveButton = document.getElementById("approveButton");
            approveButton.onclick = function() {
                // 重置密码
                window.location.href = "/teamAdmin/UserManage/ResetPassword?userID=" + userId;
            };
        }

        // 关闭模态框的函数
        function closeResetModal() {
            var modal = document.getElementById("ResetModal");
            var modalContent = document.querySelector("#ResetModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        }

    </script>

    <script>
        // 检查错误信息并弹出提示框
        window.onload = function() {
            var errorMessage = "${message}";
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

    <div class="content">
        <div class="main">
            <div class="section">
                <h1>全部团队成员和普通用户</h1>

                    <!-- 搜索框 -->
                    <form action="/teamAdmin/UserManage/searchUsers" method="get" class="search-filter">
                        <div class="first-row">
                            <label for="username">用户名：</label>
                            <input type="text" id="username" name="username" placeholder="请输入用户名"/>

                            <label for="roleType">用户角色：</label>
                            <select name="roleType" id="roleType">
                                <option value="">选择角色</option>
                                <option value="TeamMember">团队成员</option>
                                <option value="Visitor">普通用户</option>
                            </select>

                            <label for="status">账号状态：</label>
                            <select name="status" id="status">
                                <option value="">选择状态</option>
                                <option value=1>正常</option>
                                <option value=0>禁用</option>
                            </select>
                        </div>

                        <br>

                        <div class="second-row">
                            <label for="registrationTime">注册时间</label>
                            <input type="date" id="registrationTime" name="registrationTime">

                            <label for="email">邮箱地址</label>
                            <input type="text" id="email" name="email" placeholder="请输入邮箱地址">

                            <button type="submit">搜索</button>
                        </div>
                    </form>
                    <br>

                <div class="button-group">
                    <form action="/teamAdmin/ToUserManage">
                        <button type="submit" class="btn btn-view-all">查看全部</button>
                    </form>

                    <form action="/teamAdmin/UserManage/ToLogoutList">
                        <button type="submit" class="btn btn-view-cancel">查看申请注销的用户</button>
                    </form>
                </div>

                    <table border="1" class="styled-table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAllCheckbox"/>
                                全选
                            </th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>姓名</th>
                            <th>用户角色</th>
                            <th>邮箱</th>
                            <th>注册时间</th>
                            <th>账号状态</th>
                            <th>联系方式</th>
<%--                            <th>研究方向</th>--%>
<%--                            <th>学术背景</th>--%>
<%--                            <th>科研成果</th>--%>
                            <th>操作</th>
                            <!-- 这里可以根据实际需要增加更多的列 -->
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${users}" var="user">
                        <tr class="one-row">
                            <td>
                                <input type="checkbox"
                                       class="rowCheckbox"
                                       name="selectedRows"
                                       value="${user.userID}">
                            </td>
                            <td>${user.userID}</td>
                            <td>${user.username}</td>
                            <td>${user.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.roleType == 'TeamMember'}">团队成员</c:when>
                                    <c:when test="${user.roleType == 'Visitor'}">普通用户</c:when>
                                </c:choose>
                            </td>
                            <td>${user.email}</td>
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
                                    <c:choose>
                                        <c:when test="${empty user.contactInfo}">无</c:when>
                                        <c:otherwise>${user.contactInfo}</c:otherwise>
                                    </c:choose>
                            </td>
<%--                            <td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${empty user.researchField}">无</c:when>--%>
<%--                                    <c:otherwise>${user.researchField}</c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${empty user.academicBackground}">无</c:when>--%>
<%--                                    <c:otherwise>${user.academicBackground}</c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${empty user.researchAchievements}">无</c:when>--%>
<%--                                    <c:otherwise>${user.researchAchievements}</c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
                            <td>
                                <div>
                                    <!-- 注销用户-->
                                    <button class="btn-reject" type="button" onclick="confirmLogout(${user.userID})">注销</button>
                                    <!-- 重置密码 -->
                                    <button class="btn-preview" type="button" onclick="confirmReset(${user.userID})">重置密码</button>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                <button type="button" id="batchLogoutButton" class="btn btn-pass">批量注销</button>

                <button type="button" id="batchResetButton" class="btn btn-pass">批量重置</button>

            </div>
        </div>
    </div>
</div>

<!-- 模态框 -->
<div id="LogoutModal" class="modal">
    <div class="modal-content">
        <span class="close-logout">&times;</span>
        <h3>注销用户</h3>
        <p>确定注销此账户吗？注销后该用户将无法登录。</p>
        <button id="approve-logout-Button" class="modal-button">确定</button>
    </div>
</div>

<div id="ResetModal" class="modal">
    <div class="modal-content">
        <span class="close-reset">&times;</span>
        <h3>重置用户密码</h3>
        <p>是否为用户生成新密码？系统将发送临时密码至注册邮箱。</p>
        <button id="approveButton" class="modal-button">确定</button>
    </div>
</div>

<!-- 批量-->
<div id="BatchLogoutModal" class="modal">
    <div class="modal-content">
        <span class="batch-close-logout">&times;</span>
        <h3>注销用户</h3>
        <p>确定注销选中的全部用户吗？注销后将无法登录。</p>
        <button id="batch-logout-Button" class="modal-button">确定</button>
    </div>
</div>

<div id="BatchResetModal" class="modal">
    <div class="modal-content">
        <span class="batch-close-reset">&times;</span>
        <h3>重置用户密码</h3>
        <p>是否为选中的用户生成新密码？系统将发送临时密码至注册邮箱。</p>
        <button id="batch-reset-button" class="modal-button">确定</button>
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

<script src="../js/userManage.js?v21"></script>
</body>
</html>
