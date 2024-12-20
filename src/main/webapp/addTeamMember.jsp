<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加团队成员</title>
</head>
<body>
    <form action="addTeamMember" method="get">
        <!-- 用户名 -->
        用户名：<input type="text" name="username"><br>

        <!-- 密码 -->
        密码：<input type="password" name="password"><br>

       <input type="text" name="roleType" value="TeamMember" hidden="hidden">

        <!-- 邮箱 -->
        邮箱：
        <input type="text" id="email" name="email" value="${user.email}" required>
        <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span>

        <!-- 姓名 -->
        姓名：<input type="text" name="name"><br>

        <!-- 研究方向 -->
        研究方向：<input type="text" name="researchField"><br>

        <!-- 联系方式 -->
        联系方式：<input type="text" name="contactInfo"><br>

        <!-- 学术背景 -->
        学术背景：<input type="text" name="academicBackground"><br>

        <!-- 研究成果 -->
        研究成果：<input type="text" name="researchAchievements"><br>

        <!-- 提交按钮 -->
        <input type="submit" value="增加用户">

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
