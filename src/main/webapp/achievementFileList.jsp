<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title>成果文件列表</title>
</head>
<body>
<h1>成果文件列表</h1>
<ul>
  <c:forEach var="file" items="${files}">
    <li>
      <c:choose>
        <c:when test="${file.type == 1}">
          <!-- 显示图片 -->
          <img src="${file.filePath}" alt="${file.fileName}" style="width:100%; height:auto;" />
        </c:when>
        <c:otherwise>
          <!-- 显示附件下载 -->
          <a href="/download?filePath=${fn:escapeXml(file.filePath)}" target="_blank">
            下载附件：<c:out value="${file.fileName}" />
          </a>
        </c:otherwise>
      </c:choose>
      <p>上传时间：<c:out value="${file.uploadTime}" /></p>
    </li>
  </c:forEach>
</ul>

<!-- 对所有链接进行统一编码处理 -->
<script>
  document.querySelectorAll('a').forEach(link => {
    const href = link.getAttribute('href');
    if (href && href.includes('filePath=')) {
      const encodedHref = href.replace(/filePath=.*$/, match => {
        const filePath = match.split('=')[1];
        return 'filePath=' + encodeURIComponent(filePath);
      });
      link.setAttribute('href', encodedHref);
    }
  });
</script>
</body>
</html>
