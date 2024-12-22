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
    <form action="/SuperController/TeamAdminManage/edit" method="GET">
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
                邮箱：
                <input type="text" id="email" name="email" value="${user.email}">
                <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span>
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
    <script>
        // 获取邮箱输入框和提示信息元素
        var emailInput = document.getElementById('email');
        var emailError = document.getElementById('emailError');

        // 定义正则表达式用于验证邮箱格式
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        // 监听用户输入事件
        emailInput.addEventListener('input', function() {
            var emailValue = emailInput.value;

            // 检查输入的邮箱是否符合格式
            if (emailPattern.test(emailValue)) {
                // 如果格式正确，隐藏错误提示
                emailError.style.display = 'none';
                emailInput.style.borderColor = '';  // 恢复输入框边框颜色
            } else {
                // 如果格式错误，显示错误提示
                emailError.style.display = 'inline';
                emailInput.style.borderColor = 'red';  // 设置红色边框提醒用户
            }
        });
    </script>
</body>
</html>
