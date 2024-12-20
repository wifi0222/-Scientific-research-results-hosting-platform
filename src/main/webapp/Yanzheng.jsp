<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/16
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="SendEmail" method="GET">
            <label for="email">邮箱：</label>
            <input type="text" id="email" name="email" placeholder="请输入邮箱" required>
            <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span>
            <input type="submit" value="提交">

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

    </form>
</body>
</html>
