<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* General reset and styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: url('/resources/login.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .container {
            width: 400px;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
            color: #444;
        }

        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-row label {
            flex: 0 0 100px;
            text-align: right;
            margin-right: 10px;
            font-size: 14px;
            color: #555;
        }

        .form-row input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        .form-row button {
            width: 100%;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-row button:hover {
            background-color: #2e59d9;
        }

        #message {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }

        .options {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            margin-top: 20px;
        }

        .options a {
            color: #4e73df;
            text-decoration: none;
        }

        .options a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>忘记密码</h2>

    <form id="forgotPasswordForm">
        <!-- 用户名 -->
        <div class="form-row">
            <label for="username">用户名：</label>
            <input type="text" id="username" name="username" required>
        </div>

        <!-- 邮箱 -->
        <div class="form-row">
            <label for="email">邮箱：</label>
            <input type="email" id="email" name="email" required>
        </div>

        <!-- 发送验证码按钮 -->
        <div class="form-row">
            <button type="button" id="sendCodeButton" onclick="sendVerificationCode()">发送验证码</button>
        </div>

        <!-- 验证码 -->
        <div class="form-row">
            <label for="verificationCode">验证码：</label>
            <input type="text" id="verificationCode" name="verificationCode" required>
        </div>

        <!-- 新密码 -->
        <div class="form-row">
            <label for="newPassword">新密码：</label>
            <input type="password" id="newPassword" name="newPassword" required>
        </div>

        <!-- 确认新密码 -->
        <div class="form-row">
            <label for="confirmPassword">确认密码：</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>

        <!-- 重置密码按钮 -->
        <div class="form-row">
            <button type="button" onclick="resetPassword()">重置密码</button>
        </div>
    </form>

    <!-- 提示信息 -->
    <div id="message"></div>

    <!-- 返回登录 -->
    <div class="options">
        <a href="/login.jsp">返回登录</a>
    </div>
</div>

<script>
    // 发送验证码
    function sendVerificationCode() {
        const username = $("#username").val();
        const email = $("#email").val();

        if (!username || !email) {
            $("#message").text("请输入用户名和邮箱！").css("color", "red");
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
                button.text("发送验证码");
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
            $("#message").text("请完整填写所有信息！").css("color", "red");
            return;
        }

        if (newPassword !== confirmPassword) {
            $("#message").text("两次密码输入不一致！").css("color", "red");
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
                        window.location.href = "/login.jsp";
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
</body>
</html>
