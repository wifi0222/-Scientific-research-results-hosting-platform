<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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

      // 在发送验证码之前进行用户名验证
      if (!validateUsername()) {
        return; // 如果用户名无效，直接返回，不发送验证码
      }

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

    // 用户名检查函数，检查是否是纯数字
    function validateUsername() {
      const username = $("#username").val();
      const numericPattern = /^\d+$/; // 正则表达式，匹配纯数字

      if (numericPattern.test(username)) {
        $("#message").css("color", "red").text("用户名不能是纯数字！");
        return false;
      }
      return true;
    }

    // 提交表单前验证
    function validateForm() {
      if (!validateUsername()) {
        return false; // 阻止表单提交
      }
      return true; // 允许表单提交
    }
  </script>
</head>
<body>
<h2>注册页面</h2>

<form action="/registration/submit" method="post" onsubmit="return validateForm()">
  <!-- 用户名 -->
  <div>
    <label for="username">用户名：</label>
    <input type="text" id="username" name="username" required
           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
  </div>

  <!-- 邮箱 -->
  <div>
    <label for="email">邮箱：</label>
    <input type="email" id="email" name="email" required
           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
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
    <option value="teammember" <%= "teammember".equals(request.getAttribute("roleType")) ? "selected" : "" %>>团队成员</option>
    <option value="member" <%= "member".equals(request.getAttribute("roleType")) ? "selected" : "" %>>普通用户</option>
  </select><br>

  <!-- 申请理由 -->
  申请理由:
  <textarea name="reason"><%= request.getAttribute("reason") != null ? request.getAttribute("reason") : "" %></textarea><br>

  <!-- 验证码输入 -->
  验证码: <input type="text" name="verificationCode" required/><br>

  <!-- 提交注册 -->
  <input type="submit" value="提交注册申请"/>
</form>

<!-- 提示信息 -->
<div id="message" style="margin-top: 20px;">
  <%-- 显示消息 --%>
  <%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");

    if (message != null) {
  %>
  <span style="color: green"><%= message %></span>
  <%
  } else if (error != null) {
  %>
  <span style="color: red"><%= error %></span>
  <%
    }
  %>
</div>
<ul>
  <!-- 其他功能 -->
  <li><a href="/login.jsp">登录</a></li>
  <li><a href="/status.jsp">查询注册状态</a></li>

</ul>
</body>
</html>
