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
  <script>
    // 发送验证码
    function sendVerificationCode() {
      const username = document.getElementById("username").value;
      const email = document.getElementById("email").value;

      if (!username || !email) {
        alert("请先填写用户名和邮箱！");
        return;
      }

      // 使用 Ajax 请求发送验证码
      fetch('/registration/sendVerificationCode', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `username=${username}&email=${email}`
      })
              .then(response => response.json())
              .then(data => {
                if (data.success) {
                  alert("验证码已发送至邮箱，请查收！");
                } else {
                  alert(data.error || "验证码发送失败，请稍后重试！");
                }
              })
              .catch(error => {
                alert("发送验证码时出现错误，请稍后重试！");
                console.error("Error:", error);
              });
    }
  </script>
</head>
<body>
<h2>注册页面</h2>

<form action="/registration/submit" method="post">
  用户名: <input type="text" id="username" name="username" required/><br>
  邮箱: <input type="email" id="email" name="email" required/><br>
  <button type="button" onclick="sendVerificationCode()">发送验证码</button><br><br>

  密码: <input type="password" name="password" required/><br>
  身份:
  <select name="roleType">
    <option value="teammember">团队成员</option>
    <option value="member">普通用户</option>
  </select><br>
  申请理由: <textarea name="reason"></textarea><br>
  验证码: <input type="text" name="verificationCode" required/><br>
  <input type="submit" value="提交注册申请"/>
</form>

<c:if test="${not empty error}">
  <p style="color:red;">${error}</p>
</c:if>
<c:if test="${not empty message}">
  <p style="color:green;">${message}</p>
</c:if>
</body>
</html>
