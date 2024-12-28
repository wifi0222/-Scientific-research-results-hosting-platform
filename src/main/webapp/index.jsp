<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
</head>
<body>

<!-- 主内容区域 -->
<div class="content">
    <h2>欢迎页面</h2>
    <p>欢迎来到管理系统！</p>

    <a href="browse" style="text-decoration: none;">
        <button style="padding: 10px 20px; background-color: #4e73df; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;">
            前台
        </button>
    </a>

    <br/><br/>


    <a href="ManagementLogin.jsp" style="text-decoration: none;">
        <button style="padding: 10px 20px; background-color: #4e73df; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;">
            后台
        </button>
    </a>



</div>
</body>
</html>
