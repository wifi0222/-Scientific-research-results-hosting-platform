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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title>成果详情</title>
  <link rel="stylesheet" href="/css/detail.css">
  <script src="/js/detail.js" defer></script>
</head>
<body>

<!-- 轮播图 -->
<c:if test="${fn:length(files) > 0}">
  <div class="carousel">
    <div class="carousel-images">
      <c:forEach var="imageFile" items="${files}">
        <c:if test="${imageFile.type == 1}">
          <!-- 显示图片 -->
          <%--          <div style="text-align: center;">--%>
          <%--            <img src="${file.filePath}" style="width:auto; height:30%;" />--%>
          <%--          </div>--%>
          <c:set var="encodedPath"
                 value="${fn:replace(fn:replace(imageFile.filePath, '\\\\', '/'), ' ', '%20')}"/>
          <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片" class="carousel-img">
        </c:if>
      </c:forEach>
    </div>
    <div class="carousel-controls">
      <button onclick="moveCarousel(-1)">&#10094;</button>
      <button onclick="moveCarousel(1)">&#10095;</button>
    </div>
  </div>
</c:if>

<h2 class="title">${article.title}</h2>

<div class="content-wrapper">
   <!-- 类别和时间居中显示 -->
  <div class="category-time">
    <p>类别: ${article.category}</p>
    <p>时间: <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd" /></p>
  </div>

   <!-- 摘要 -->
  <p class="abstract-label">摘要:</p>
  <p class="abstract">${article.abstractContent}</p>

  <!-- 内容 -->
  <p class="contents-label">内容:</p>
  <p class="contents">${article.contents}</p>

  <!-- 文件列表 -->
  <div class="file-list">
    <ul>
      <c:forEach var="file" items="${files}">
        <li>
          <c:choose>
            <c:when test="${file.type == 0}">
              <!-- 附件下载按钮 -->
              <!-- 显示附件下载 -->
              <%--                    <a href="/download?filePath=${fn:escapeXml(file.filePath)}" target="_blank">--%>
              <%--                        下载附件：<c:out value="${file.fileName}" />--%>
              <%--                    </a>--%>
              <a href="/${file.filePath}" target="_blank" class="download-btn">${file.fileName}</a>
            </c:when>
          </c:choose>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>
<!-- 对所有链接进行统一编码处理 -->
<%--<script>--%>
<%--  document.querySelectorAll('a').forEach(link => {--%>
<%--    const href = link.getAttribute('href');--%>
<%--    if (href && href.includes('filePath=')) {--%>
<%--      const encodedHref = href.replace(/filePath=.*$/, match => {--%>
<%--        const filePath = match.split('=')[1];--%>
<%--        return 'filePath=' + encodeURIComponent(filePath);--%>
<%--      });--%>
<%--      link.setAttribute('href', encodedHref);--%>
<%--    }--%>
<%--  });--%>
<%--</script>--%>

</body>
</html>

