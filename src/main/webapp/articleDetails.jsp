<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>成果详情</title>
</head>
<body>
<h2>成果详情</h2>

<!-- 标题、类别、创建时间等展示 -->
<p>标题: ${article.title}</p>
<p>类别: ${article.category}</p>
<p>创建时间: ${article.publishDate}</p>
<p>摘要: ${article.abstractContent}</p>
<p>内容: ${article.contents}</p>

<!-- 如果有附件，显示下载链接 -->
<p>附件:
  <c:choose>
    <c:when test="${not empty article.attachmentLink}">
      <a href="${article.attachmentLink}" target="_blank">下载附件</a>
    </c:when>
    <c:otherwise>
      <span>无附件</span>
    </c:otherwise>
  </c:choose>
</p>

<%--<!-- 如果有封面图片，显示图片 -->--%>
<%--<p>封面图片:--%>
<%--    <c:choose>--%>
<%--        <c:when test="${not empty article.coverImage}">--%>
<%--            <img src="data:image/jpeg;base64,${article.coverImage}" alt="封面图片" />--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--            <span>无封面图片</span>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
<%--</p>--%>

</body>
</html>

