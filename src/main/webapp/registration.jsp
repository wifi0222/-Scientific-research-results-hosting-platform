<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--<%@ page isELIgnored="false" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
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
  </script>
</head>
<body>
<h2>注册页面</h2>

<form action="/registration/submit" method="post">
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

  <!-- 新密码 -->
  <div>
    <label for="password">新密码：</label>
    <input type="password" id="password" name="password" required>
  </div>

  <!-- 确认新密码 -->
  <div>
    <label for="confirmpassword">确认新密码：</label>
    <input type="password" id="confirmpassword" name="confirmpassword" required>
  </div>

  <!-- 身份选择 -->
  身份:
  <select name="roleType">
    <option value="teammember">团队成员</option>
    <option value="member">普通用户</option>
  </select><br>

  <!-- 申请理由 -->
  申请理由: <textarea name="reason"></textarea><br>

  <!-- 验证码输入 -->
  验证码: <input type="text" name="verificationCode" required/><br>

  <!-- 提交注册 -->
  <input type="submit" value="提交注册申请"/>
</form>

<!-- 提示信息 -->
<div id="message" style="margin-top: 20px;"></div>

</body>
</html>
