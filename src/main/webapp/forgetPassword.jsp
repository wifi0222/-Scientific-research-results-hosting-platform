<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>忘记密码</h2>
<form id="forgotPasswordForm">
    <!-- 用户名 -->
    <div>
        <label for="username">用户名：</label>
        <input type="text" id="username" name="username" required>
    </div>

    <!-- 邮箱 -->
    <div>
        <label for="email">邮箱：</label>
        <input type="email" id="email" name="email" required>
    </div>

    <!-- 发送验证码按钮 -->
    <div>
        <button type="button" id="sendCodeButton" onclick="sendVerificationCode()">发送验证码</button>
    </div>

    <!-- 验证码 -->
    <div>
        <label for="verificationCode">验证码：</label>
        <input type="text" id="verificationCode" name="verificationCode" required>
    </div>

    <!-- 新密码 -->
    <div>
        <label for="newPassword">新密码：</label>
        <input type="password" id="newPassword" name="newPassword" required>
    </div>

    <!-- 确认新密码 -->
    <div>
        <label for="confirmPassword">确认新密码：</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
    </div>

    <!-- 重置密码按钮 -->
    <div>
        <button type="button" onclick="resetPassword()">重置密码</button>
    </div>
</form>

<!-- 提示信息 -->
<div id="message" style="color: red; margin-top: 20px;"></div>

<script>
    // 发送验证码
    function sendVerificationCode() {
        const username = $("#username").val();
        const email = $("#email").val();

        if (!username || !email) {
            $("#message").text("请输入用户名和邮箱！");
            return;
        }

        $.ajax({
            url: "/forgot-password/sendVerificationCode",
            type: "POST",
            data: { username, email },
            success: function (response) {
                if (response.success) {
                    $("#message").css("color", "green").text(response.message);

                    // 禁用按钮并开始倒计时
                    $("#sendCodeButton").prop("disabled", true);
                    startCountdown();
                } else {
                    $("#message").css("color", "red").text(response.error);
                }
            },
            error: function () {
                $("#message").css("color", "red").text("发送验证码失败，请稍后重试！");
            }
        });
    }

    // 倒计时函数
    function startCountdown() {
        let countdownTime = 300; // 5分钟倒计时（300秒）
        const button = $("#sendCodeButton");
        button.text(`重新发送（${countdownTime}s）`);

        const countdownInterval = setInterval(function () {
            countdownTime--;
            button.text(`重新发送（${countdownTime}s）`);

            if (countdownTime <= 0) {
                clearInterval(countdownInterval);
                button.text("重新发送");
                button.prop("disabled", false); // 启用按钮
            }
        }, 1000);
    }

    // 重置密码
    function resetPassword() {
        const username = $("#username").val();
        const verificationCode = $("#verificationCode").val();
        const newPassword = $("#newPassword").val();
        const confirmPassword = $("#confirmPassword").val();

        if (!username || !verificationCode || !newPassword || !confirmPassword) {
            $("#message").text("请完整填写所有信息！");
            return;
        }

        $.ajax({
            url: "/forgot-password/resetPassword",
            type: "POST",
            data: { username, verificationCode, newPassword, confirmPassword },
            success: function (response) {
                if (response.success) {
                    $("#message").css("color", "green").text(response.message);
                    // 密码重置成功后可以跳转到登录页面
                    setTimeout(function () {
                        window.location.href = "/user/login";
                    }, 2000);
                } else {
                    $("#message").css("color", "red").text(response.error);
                }
            },
            error: function () {
                $("#message").css("color", "red").text("重置密码失败，请稍后重试！");
            }
        });
    }
</script>
<ul>
    <!-- 其他功能 -->
    <li><a href="/login.jsp">返回登录</a></li>

</ul>
</body>
</html>
