<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/20
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>申请注销用户</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/newSidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/userManage.css">

    <style>
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
            position: relative; /* 相对定位，为了放置箭头 */

            font-size: 16px;
            color: white;
            text-align: center;
        }

        /* 按钮悬停时 */
        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }

        /* 在悬停时显示箭头 */
        .back-btn:hover::after {
            font-size: 20px;
            margin-left: 10px; /* 箭头和文字之间的间距 */
            position: absolute;
            right: -25px; /* 箭头位于按钮的右侧 */
            top: 50%;
            transform: translateY(-50%); /* 垂直居中 */
            transition: transform 0.3s ease-in-out; /* 平滑过渡 */
        }

    </style>
    <script type="text/javascript">
        //确认注销
        function confirmLogout(userId) {
            showLogoutModal(userId);
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
    </script>
</head>
<body>
<div class="container">
    <div class="content">
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


        <div class="main">
            <div class="section">
                <h1>申请注销用户列表</h1>

                <button type="button" id="batchLogoutButton" class="btn btn-pass">批量注销</button>


                <table border="1" class="styled-table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllCheckbox"/>
                            全选
                        </th>
                        <th>用户ID</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>用户角色</th>
                        <th>邮箱</th>
                        <th>注册时间</th>
                        <th>账号状态</th>
                        <th>联系方式</th>
            <%--            <th>研究方向</th>--%>
            <%--            <th>学术背景</th>--%>
            <%--            <th>科研成果</th>--%>
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
            <%--                <td>--%>
            <%--                    <c:choose>--%>
            <%--                        <c:when test="${empty user.researchField}">无</c:when>--%>
            <%--                        <c:otherwise>${user.researchField}</c:otherwise>--%>
            <%--                    </c:choose>--%>
            <%--                </td>--%>
            <%--                <td>--%>
            <%--                    <c:choose>--%>
            <%--                        <c:when test="${empty user.academicBackground}">无</c:when>--%>
            <%--                        <c:otherwise>${user.academicBackground}</c:otherwise>--%>
            <%--                    </c:choose>--%>
            <%--                </td>--%>
            <%--                <td>--%>
            <%--                    <c:choose>--%>
            <%--                        <c:when test="${empty user.researchAchievements}">无</c:when>--%>
            <%--                        <c:otherwise>${user.researchAchievements}</c:otherwise>--%>
            <%--                    </c:choose>--%>
            <%--                </td>--%>
                            <td>
                                <div>
                                    <!-- 注销用户-->
                                    <button  class="btn-reject" type="button" onclick="confirmLogout(${user.userID})">注销</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <form action="/teamAdmin/ToUserManage">
                    <button class="back-btn">返回用户管理界面</button>
                </form>
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

<script src="/js/userManage.js"></script>
</body>
</html>
