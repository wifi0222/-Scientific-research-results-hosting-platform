<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录</title>
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

        /* Container for login box */
        .login-container {
            width: 350px;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .login-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #444;
        }

        /* Form styling */
        .login-container form {
            display: flex;
            flex-direction: column;
        }

        .login-container label {
            font-size: 14px;
            color: #555;
            text-align: left;
            margin-bottom: 5px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        /* Button styling */
        .login-container button {
            padding: 10px;
            font-size: 16px;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-container button:hover {
            background-color: #4e73df;
        }

        /* Error message */
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }

        /* Additional options */
        .login-container .options {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #777;
        }

        .login-container .options a {
            color: #4e73df;
            text-decoration: none;
        }

        .login-container .options a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>用户登录</h2>

    <!-- Display error message if there is one -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="/user/login" method="post">
        <label for="usernameOrId">用户名或ID:</label>
        <input type="text" id="usernameOrId" name="usernameOrId" required placeholder="请输入用户名或ID"/>

        <label for="password">密码:</label>
        <input type="password" id="password" name="password" required placeholder="请输入密码"/>

        <div style="margin-bottom: 15px;">
            <label for="captcha" style="display: block; margin-bottom: 5px;">验证码:</label>
            <div style="display: flex; align-items: center;">
                <input type="text" id="captcha" name="captcha" required placeholder="请输入验证码"
                       style="flex: 1; height: 35px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/>
                <img src="/captcha" alt="验证码图片"
                     onclick="this.src='/captcha?'+Math.random();"
                     style="flex: 1; height: 35px; margin-left: 10px; cursor: pointer; border: 1px solid #ccc; border-radius: 5px;"/>
            </div>
            <small style="display: block; text-align: right; color: #777;">点击图片刷新验证码</small>
        </div>





        <button type="submit">登录</button>
    </form>

    <div class="options">
        <a href="/registration.jsp">注册</a>
        <a href="/forgetPassword.jsp">忘记密码</a>
    </div>
</div>
</body>
</html>
