<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>修改团队成员信息</title>
</head>
<body>
<h2>修改用户信息</h2>
<form action="TeamMemberEdit" method="post">
    <!-- 用户ID (只读) -->
    用户ID：<input type="text" name="userID" value="${user.userID}" readonly><br>

    <!-- 用户名 -->
    用户名：<input type="text" name="username" value="${user.username}" readonly><br>

<%--    <!-- 密码 -->--%>
<%--    密码：<input type="password" name="password" value="${user.password}"><br>--%>

<%--    <!-- 角色类型 -->--%>
<%--    角色类型：<input type="text" name="roleType" value="${user.roleType}"><br>--%>

    <!-- 邮箱 -->
    邮箱：
    <input type="text" id="email" name="email" value="${user.email}" required>
    <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span>

<%--    <!-- 状态 -->--%>
<%--    状态：--%>
<%--    <select name="status">--%>
<%--        <option value="1" ${user.status == 1 ? 'selected' : ''}>可用</option>--%>
<%--        <option value="0" ${user.status == 0 ? 'selected' : ''}>禁用</option>--%>
<%--    </select><br>--%>

    <!-- 姓名 -->
    姓名：<input type="text" name="name" value="${user.name}"><br>

    <!-- 研究方向 -->
    研究方向：<input type="text" name="researchField" value="${user.researchField}"><br>

    <!-- 联系方式 -->
    联系方式：<input type="text" name="contactInfo" value="${user.contactInfo}"><br>

    <!-- 学术背景 -->
    学术背景：<input type="text" name="academicBackground" value="${user.academicBackground}"><br>

    <!-- 研究成果 -->
    研究成果：<input type="text" name="researchAchievements" value="${user.researchAchievements}"><br>

    <!-- 提交按钮 -->
    <input type="submit" value="提交修改">
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

