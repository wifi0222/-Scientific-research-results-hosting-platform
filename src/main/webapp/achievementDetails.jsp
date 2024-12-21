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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<%--                    <div style="text-align: center;">--%>
<%--                        <img src="${file.filePath}" style="width:auto; height:30%;" />--%>
<%--                    </div>--%>
                    <c:set var="encodedPath"
                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                         width="100"/>

                </c:when>
                <c:otherwise>
                    <!-- 显示附件下载 -->
<%--                    <a href="/download?filePath=${fn:escapeXml(file.filePath)}" target="_blank">--%>
<%--                        下载附件：<c:out value="${file.fileName}" />--%>
<%--                    </a>--%>
                    <a href="/${file.filePath}" target="_blank">${file.fileName} </a><br/>
                </c:otherwise>
            </c:choose>
        </li>
    </c:forEach>
</ul>

<h2>成果详情</h2>

<!-- 标题、类别、创建时间等展示 -->
<p>标题: ${achievement.title}</p>
<p>类别: ${achievement.category}</p>
<p>时间: <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd" /></p>
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

</html>

