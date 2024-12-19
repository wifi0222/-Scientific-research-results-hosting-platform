<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
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
          } else {
            $("#message").css("color", "red").text(response.error);
          }
        },
        error: function () {
          $("#message").css("color", "red").text("发送验证码失败，请稍后重试！");
        }
      });
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
  <div>
    <button type="button" onclick="sendVerificationCode()">发送验证码</button>
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
  身份:
  <select name="roleType">
    <option value="teammember">团队成员</option>
    <option value="member">普通用户</option>
  </select><br>
  申请理由: <textarea name="reason"></textarea><br>
  验证码: <input type="text" name="verificationCode" required/><br>
  <input type="submit" value="提交注册申请"/>
</form>

<!-- 提示信息 -->
<div id="message" style="margin-top: 20px;"></div>
<c:if test="${not empty error}">
  <div style="color: red;">${error}</div>
</c:if>

<c:if test="${not empty message}">
  <div style="color: green;">${message}</div>
</c:if>

</body>
</html>
