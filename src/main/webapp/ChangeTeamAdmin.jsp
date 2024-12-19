<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改团队管理员的信息</title>
</head>
<body>
    <form action="ChangeTeamAdminInfo" method="GET">
            <div>
                用户ID(无法修改)：<input type="text" name="userID" value="${user.userID}" readonly>
            </div>
            <div>
                用户名（无法修改)：<input type="text" name="username" value="${user.username}" readonly>
            </div>
            <div>
                密码：<input type="text" name="password" value="${user.password}">
            </div>

            <!-- 角色类型单选框 -->
            <div>
                角色类型：
                <input type="radio" id="roleTypeTeamAdmin" name="roleType" value="TeamAdmin" ${user.roleType == 'TeamAdmin' ? 'checked' : ''}>
                <label for="roleTypeTeamAdmin">团队管理员</label>

                <input type="radio" id="roleTypeTeamMember" name="roleType" value="TeamMember" ${user.roleType == 'TeamMember' ? 'checked' : ''}>
                <label for="roleTypeTeamMember">团队成员</label>

                <input type="radio" id="roleTypeVisitor" name="roleType" value="Visitor" ${user.roleType == 'Visitor' ? 'checked' : ''}>
                <label for="roleTypeVisitor">普通用户</label>
            </div>

            <div>
                邮箱：<input type="text" name="email" value="${user.email}">
            </div>

            <div>
                <label for="registrationTime">注册时间（无法修改）：
                    <input type="text" id="registrationTime" name="registrationTime"
                           value="${user.registrationTime}" readonly />
                </label>
            </div>

            <!-- 账号状态单选框 -->
            <div>
                账号状态：
                <input type="radio" id="statusActive" name="status" value="1" ${user.status == 1 ? 'checked' : ''}>
                <label for="statusActive">正常使用</label>

                <input type="radio" id="statusInactive" name="status" value="0" ${user.status == 0 ? 'checked' : ''}>
                <label for="statusInactive">禁用</label>
            </div>

            <div>
                姓名：<input type="text" name="name" value="${user.name}">
            </div>
            <div>
                研究方向：<input type="text" name="researchField" value="${user.researchField}">
            </div>
            <div>
                联系方式：<input type="text" name="contactInfo" value="${user.contactInfo}">
            </div>
            <div>
                科研成果：<input type="text" name="researchAchievements" value="${user.researchAchievements}">
            </div>
            <div>
                学术背景：<input type="text" name="academicBackground" value="${user.academicBackground}">
            </div>

            <input type="submit" value="提交">
        </form>

</body>
</html>
