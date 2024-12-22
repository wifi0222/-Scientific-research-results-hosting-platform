<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/18
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看申请状态</title>
    <style>
        /* 通用样式 */
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

        .status-container {
            width: 400px;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .status-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #444;
        }

        .form-row {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .form-row label {
            margin-bottom: 5px;
            font-size: 14px;
            color: #555;
        }

        .form-row input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        .status-container button {
            width: 100%;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .status-container button:hover {
            background-color: #2e59d9;
        }

        .status-container p {
            margin-top: 15px;
            font-size: 14px;
        }

        .status-container p.error {
            color: red;
        }

        .status-container p.success {
            color: green;
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
<div class="status-container">
    <h2>查看申请状态</h2>
    <form action="/registration/status" method="post">
        <!-- 邮箱 -->
        <div class="form-row">
            <label for="email">邮箱:</label>
            <input type="email" id="email" name="email" required/>
        </div>

        <!-- 查询状态按钮 -->
        <button type="submit">查询状态</button>
    </form>

    <!-- 显示错误或成功消息 -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>

    <!-- 返回登录和注册 -->
    <div class="options">
        <a href="/login.jsp">返回登录</a>
        <a href="/registration.jsp">注册</a>
    </div>
</div>
</body>
</html>


