<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>成果详情</title>
</head>
<body>
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
        </li>
    </c:forEach>
</ul>
<h2>成果详情</h2>

<!-- 标题、类别、创建时间等展示 -->
<p>标题: ${achievement.title}</p>
<p>类别: ${achievement.category}</p>
<p>创建时间: ${achievement.creationTime}</p>
<p>摘要: ${achievement.abstractContent}</p>
<p>内容: ${achievement.contents}</p>


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
<!-- 如果有附件，显示下载链接 -->
<%--<p>附件:--%>
<%--    <c:choose>--%>
<%--        <c:when test="${not empty achievement.attachmentLink}">--%>
<%--            <a href="${achievement.attachmentLink}" target="_blank">下载附件</a>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--            <span>无附件</span>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
<%--</p>--%>

<%--<!-- 如果有封面图片，显示图片 -->--%>
<%--<p>封面图片:--%>
<%--    <c:choose>--%>
<%--        <c:when test="${not empty achievement.coverImage}">--%>
<%--            <img src="data:image/jpeg;base64,${achievement.coverImage}" alt="封面图片" />--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--            <span>无封面图片</span>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
<%--</p>--%>

</html>

