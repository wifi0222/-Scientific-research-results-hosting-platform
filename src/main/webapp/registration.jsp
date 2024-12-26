<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>用户注册</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        url: "/registration/sendVerificationCode",
        type: "POST",
        data: { username, email },
        success: function (response) {
          if (response.success) {
            $("#message").css("color", "green").text(response.message);
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

    // 倒计时
    function startCountdown() {
      let countdownTime = 300;
      const button = $("#sendCodeButton");
      button.text(`重新发送（${countdownTime}s）`);

      const interval = setInterval(() => {
        countdownTime--;
        button.text(`重新发送（${countdownTime}s）`);

        if (countdownTime <= 0) {
          clearInterval(interval);
          button.text("发送验证码");
          button.prop("disabled", false);
        }
      }, 1000);
    }
  </script>

  <style>
    /* General styling */
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

    .registration-container {
      width: 400px;
      padding: 30px;
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 10px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    }

    .registration-container h2 {
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
      flex: 0 0 80px;
      text-align: right;
      margin-right: 10px;
      font-size: 14px;
      color: #555;
    }

    .form-row input,
    .form-row select,
    .form-row textarea {
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
<div class="registration-container">
  <h2>用户注册</h2>

  <form action="/registration/submit" method="post">
    <!-- 用户名 -->
    <div class="form-row">
      <label for="username">用户名：</label>
      <input type="text" id="username" name="username" required
             value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
    </div>

    <!-- 邮箱 -->
    <div class="form-row">
      <label for="email">邮箱：</label>
      <input type="email" id="email" name="email" required
             value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
    </div>

    <!-- 发送验证码按钮 -->
    <div class="form-row">
      <button type="button" id="sendCodeButton" onclick="sendVerificationCode()">发送验证码</button>
    </div>

    <!-- 验证码输入框 -->
    <div class="form-row">
      <label for="verificationCode">验证码：</label>
      <input type="text" name="verificationCode" required>
    </div>

    <!-- 身份选择 -->
    <div class="form-row">
      <label for="roleType">身份：</label>
      <select name="roleType">
        <option value="TeamMember" <%= "TeamMember".equals(request.getAttribute("roleType")) ? "selected" : "" %>>团队成员</option>
        <option value="Visitor" <%= "Visitor".equals(request.getAttribute("roleType")) ? "selected" : "" %>>普通用户</option>
      </select>
    </div>

    <!-- 申请理由 -->
    <div class="form-row">
      <label for="reason">申请理由：</label>
      <textarea name="reason" rows="3"><%= request.getAttribute("reason") != null ? request.getAttribute("reason") : "" %></textarea>
    </div>

    <!-- 新密码 -->
    <div class="form-row">
      <label for="password">设置密码：</label>
      <input type="password" id="password" name="password" required>
    </div>

    <!-- 确认密码 -->
    <div class="form-row">
      <label for="confirmpassword">确认密码：</label>
      <input type="password" id="confirmpassword" name="confirmpassword" required>
    </div>

    <!-- 提交注册 -->
    <div class="form-row">
      <button type="submit">提交注册申请</button>
    </div>
  </form>

  <!-- 提示信息 -->
  <div id="message">
    <% String message = (String) request.getAttribute("message");
      String error = (String) request.getAttribute("error");
      if (message != null) { %>
    <span style="color: green"><%= message %></span>
    <% } else if (error != null) { %>
    <span style="color: red"><%= error %></span>
    <% } %>
  </div>

  <!-- 其他功能 -->
  <div class="options">
    <a href="/login.jsp">登录</a>
    <a href="/status.jsp">查询注册状态</a>
  </div>
</div>
</body>
</html>
