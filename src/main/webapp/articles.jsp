<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>文章列表</title>
</head>
<body>

<h2>文章列表</h2>

<!-- 筛选表单 -->
<form action="/articles" method="get">
    <label for="year">选择年份：</label>
    <select name="year" id="year">
        <option value="">请选择年份</option>
        <c:forEach var="year" items="${years}">
            <option value="${year}" ${year == param.year ? 'selected' : ''}>${year}</option>
        </c:forEach>
    </select>

    <label for="category">选择类别：</label>
    <select name="category" id="category">
        <option value="">请选择类别</option>
        <c:forEach var="category" items="${categories}">
            <option value="${category}" ${category == param.category ? 'selected' : ''}>${category}</option>
        </c:forEach>
    </select>

    <label for="sortOrder">排序：</label>
    <select name="sortOrder" id="sortOrder">
        <option value="asc" ${'asc' == param.sortOrder ? 'selected' : ''}>升序</option>
        <option value="desc" ${'desc' == param.sortOrder ? 'selected' : ''}>降序</option>
    </select>

    <button type="submit">筛选</button>
</form>

<!-- 文章列表 -->
<ul>
    <c:if test="${empty articles}">
        <p>暂无文章展示</p>
    </c:if>

    <c:if test="${not empty articles}">
        <ul>
            <c:forEach var="article" items="${articles}">
                <li>
                    <a href="/article/details?articleID=${article.articleID}">
                        <strong>${article.title}</strong>
                    </a>
                    <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd" />
                </li>
            </c:forEach>
        </ul>
    </c:if>
</ul>
<!-- 返回主页或其他分类的链接 -->
<p><a href="/browse">返回主页</a></p>
</body>
</html>
