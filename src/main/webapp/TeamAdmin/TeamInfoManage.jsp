<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>团队基本信息维护</title>

    <!-- 引入外部CSS库（例如Bootstrap）进行美化 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #4e73df;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-size: 16px;
            color: #333;
        }

        input[type="text"], input[type="date"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="date"]:focus {
            border-color: #4e73df;
            box-shadow: 0 0 5px rgba(78, 115, 223, 0.5);
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4e73df;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2e59d9;
        }

        .readonly {
            background-color: #f1f1f1;
        }

    </style>
</head>
<body>

<div class="container">
    <h1>团队基本信息维护</h1>

    <form action="/teamAdmin/TeamManage/Info/edit" method="get">
        <div>
            <label for="teamID">团队ID：</label>
            <input type="text" id="teamID" name="teamID" value="${team.teamID}" readonly class="readonly">
        </div>

        <div>
            <label for="teamName">团队名称：</label>
            <input type="text" id="teamName" name="teamName" value="${team.teamName}">
        </div>

        <div>
            <label for="researchArea">团队研究领域：</label>
            <input type="text" id="researchArea" name="researchArea" value="${team.researchArea}">
        </div>

        <div>
            <label for="introduction">团队简介：</label>
            <input type="text" id="introduction" name="introduction" value="${team.introduction}">
        </div>

        <div>
            <label for="creationTime">团队创建时间：</label>
            <input type="date" id="creationTime" name="creationTime" value="<fmt:formatDate value="${team.creationTime}" pattern="yyyy-MM-dd" />">
        </div>

        <div>
            <input type="submit" value="提交修改">
        </div>
    </form>
</div>

</body>
</html>
