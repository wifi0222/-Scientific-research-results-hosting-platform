<%--
  Created by IntelliJ IDEA.
  User: 86136
  Date: 2024/12/26
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>权限不足</title>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
  <style>
    .main h1{
      margin-top: 30px;
      text-align: center;
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="container">
  <!-- Content -->
  <div class="content">
    <!-- Sidebar -->
    <jsp:include page="/TeamAdmin/sidebar.jsp"/>

    <div class="main">
      <h1>${error}</h1>
    </div>
  </div>
</div>
</body>
</html>
