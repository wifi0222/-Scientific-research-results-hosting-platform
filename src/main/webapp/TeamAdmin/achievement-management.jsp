<%--
  Created by IntelliJ IDEA.
  User: zwb
  Date: 2024/12/19
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
    <title>科研成果管理</title>
    <!-- 引入外部CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">
</head>
<body>
<h1>科研成果管理</h1>

<div class="tabs">
    <a href="javascript:void(0)" id="publishedTab" class="active">已发布的成果</a>
    <a href="javascript:void(0)" id="reviewTab">正在审核的成果</a>
    <!-- 修改新增成果链接，指向控制器的路径 -->
    <a href="${pageContext.request.contextPath}/TeamAdmin/addAchievement.jsp" style="margin-left:20px;">新增成果</a>
</div>

<!-- 定义类别列表 -->
<c:set var="categories" value="${fn:split('专著,专利,软著,产品', ',')}" />

<!-- 已发布的成果（status=1） -->
<div id="publishedSection" class="section active">
    <h2>已发布的成果 (status = 1)</h2>
    <c:forEach var="cat" items="${categories}">
        <h3>${cat}</h3>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
            <tr>
                <th>成果ID</th>
                <th>标题</th>
                <th>类别</th>
                <th>摘要</th>
                <th>内容</th>
                <th>附件链接</th>
                <th>展示图片</th> <!-- 新增展示图片列 -->
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="achievement" items="${achievements}">
                <c:if test="${achievement.status == 1 and achievement.category eq cat}">
                    <tr>
                        <td>${achievement.achievementID}</td>
                        <td>${achievement.title}</td>
                        <td>${achievement.category}</td>
                        <td>${achievement.abstractText}</td>
                        <td>${achievement.contents}</td> <!-- 修改为 contents -->
                        <td>
                            <c:if test="${not empty achievement.attachmentLink}">
                                <a href="${pageContext.request.contextPath}/${achievement.attachmentLink}" target="_blank">下载附件</a>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${not empty achievement.coverImage}">
                                <img src="${pageContext.request.contextPath}/${achievement.coverImage}" alt="封面图片" width="100">
                            </c:if>
                        </td>
                        <td>${achievement.creationTime}</td>
                        <td>
                            <button onclick="editAchievement(${achievement.achievementID})">编辑</button>
                            <button onclick="deleteAchievement(${achievement.achievementID})">删除</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>

<!-- 正在审核的成果（status=0） -->
<div id="reviewSection" class="section">
    <h2>正在审核的成果 (status = 0)</h2>
    <c:forEach var="cat" items="${categories}">
        <h3>${cat}</h3>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
            <tr>
                <th>成果ID</th>
                <th>标题</th>
                <th>类别</th>
                <th>摘要</th>
                <th>内容</th>
                <th>附件链接</th>
                <th>展示图片</th> <!-- 新增展示图片列 -->
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="achievement" items="${achievements}">
                <c:if test="${achievement.status == 0 and achievement.category eq cat}">
                    <tr>
                        <td>${achievement.achievementID}</td>
                        <td>${achievement.title}</td>
                        <td>${achievement.category}</td>
                        <td>${achievement.abstractText}</td>
                        <td>${achievement.contents}</td> <!-- 修改为 contents -->
                        <td>
                            <c:if test="${not empty achievement.attachmentLink}">
                                <a href="${pageContext.request.contextPath}/${achievement.attachmentLink}" target="_blank">下载附件</a>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${not empty achievement.coverImage}">
                                <img src="${pageContext.request.contextPath}/${achievement.coverImage}" alt="封面图片" width="100">
                            </c:if>
                        </td>
                        <td>${achievement.creationTime}</td>
                        <td>
                            <button onclick="editAchievement(${achievement.achievementID})">编辑</button>
                            <button onclick="deleteAchievement(${achievement.achievementID})">删除</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>

<!-- 引入外部JS文件，确保标签切换功能 -->
<script src="../js/achievement-management.js"></script>

</body>
</html>
