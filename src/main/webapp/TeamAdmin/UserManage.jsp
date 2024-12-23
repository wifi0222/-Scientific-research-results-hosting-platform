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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 确认注销的对话框
        function confirmLogout(userId) {
            if (confirm("确定注销此账户吗？注销后该用户将无法登录。")) {
                // 向后端发送注销请求
                window.location.href = "/teamAdmin/UserManage/logoutUser?userID=" + userId;
            }
        }

        //确认重置密码
        function confirmReset(userId) {
            if (confirm("是否为用户生成新密码？系统将发送临时密码至注册邮箱。")) {
                window.location.href = "/teamAdmin/UserManage/ResetPassword?userID=" + userId;
            }
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
<h1>全部团队成员和普通用户</h1>
    <!-- 搜索框 -->
    <form action="/teamAdmin/UserManage/searchUsers" method="get">
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

        <label for="registrationTime">注册时间</label>
        <input type="date" id="registrationTime" name="registrationTime">

        <label for="email">邮箱地址</label>
        <input type="text" id="email" name="email" placeholder="请输入邮箱地址">

        <button type="submit">搜索</button>
    </form>
    <br>
    <form action="/teamAdmin/ToUserManage">
        <button type="submit">查看全部</button>
    </form>
    <br>
    <form action="/teamAdmin/UserManage/ToLogoutList">
        <button type="submit">查看申请注销的用户</button>
    </form>

    <table border="1">
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>姓名</th>
            <th>用户角色</th>
            <th>邮箱</th>
            <th>注册时间</th>
            <th>账号状态</th>
            <th>联系方式</th>
            <th>研究方向</th>
            <th>学术背景</th>
            <th>科研成果</th>
            <th>操作</th>
            <!-- 这里可以根据实际需要增加更多的列 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
        <tr>
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
            <td>
                <c:choose>
                    <c:when test="${empty user.researchField}">无</c:when>
                    <c:otherwise>${user.researchField}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${empty user.academicBackground}">无</c:when>
                    <c:otherwise>${user.academicBackground}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${empty user.researchAchievements}">无</c:when>
                    <c:otherwise>${user.researchAchievements}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <div>
                    <!-- 注销用户-->
                    <button type="button" onclick="confirmLogout(${user.userID})">注销</button>
                    <!-- 重置密码 -->
                    <button type="button" onclick="confirmReset(${user.userID})">重置密码</button>
                </div>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>
