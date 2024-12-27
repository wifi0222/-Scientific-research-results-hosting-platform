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

  <style>
    .comment-section {
      margin-top: 50px;
      padding: 20px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    .comment-section h3 {
      margin-bottom: 15px;
      color: #333;
    }

    .comment-section textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      margin-bottom: 10px;
    }

    .comment-section button {
      padding: 10px 20px;
      background-color: #4e73df;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .comment-section button:hover {
      background-color: #375abd;
    }

    .comments-list h4 {
      margin-top: 20px;
    }

    .comments-list ul {
      list-style-type: none;
      padding: 0;
    }

    .comments-list li {
      margin-bottom: 15px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      background-color: #fff;
    }
  </style>
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


<!-- 返回按钮 -->
<button style="background-color: transparent; border: none; font-size: 30px; color: #4e73df; position: fixed; top: 20px; left: 20px; cursor: pointer; z-index: 1000;" onclick="goBack()">&#10094;</button>

<!-- 评论功能 -->
<div class="comment-section">
  <h3>评论</h3>

  <c:if test="${not empty user}">
    <!-- 评论输入框 -->
    <form action="/questions/comment" method="post" id="commentForm">
      <textarea name="commentContent" id="commentContent" rows="4" placeholder="在此输入评论..." required></textarea>
      <input type="hidden" name="objectID" value="${article.articleID}">
      <input type="hidden" name="type" value="${article.category}">
      <input type="hidden" name="title" value="${article.title}">
      <button type="submit">提交评论</button>
    </form>
  </c:if>

  <!-- 评论列表 -->
  <div class="comments-list">
    <h4>查看评论：</h4>
    <c:if test="${not empty comments}">
      <ul>
        <c:forEach var="comment" items="${comments}">
          <li>
            <p><strong>${comment.userName}</strong> 发表评论：</p>
            <p>${comment.questionContent}</p>
            <p style="color: #5a6268"><fmt:formatDate value="${comment.askTime}" pattern="yyyy-MM-dd HH:mm:ss" /></p>

            <!-- 查看回复功能 -->
            <c:if test="${not empty comment.replyContent}">
              <button class="toggle-reply-btn" data-reply-id="reply-${comment.questionID}">查看回复</button>
              <div id="reply-${comment.questionID}" class="reply-content" style="display: none; margin-top: 10px; padding: 10px; background-color: #f9f9f9; border-left: 4px solid #4e73df;">
                <p><strong>${comment.teamAdminName}</strong> 回复了： ${comment.replyContent}</p>
                <p style="color: #5a6268"><fmt:formatDate value="${comment.replyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
              </div>
            </c:if>
          </li>
        </c:forEach>
      </ul>
    </c:if>
    <c:if test="${empty comments}">
      <p>暂无评论。</p>
    </c:if>
  </div>


</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    // 获取所有“查看回复”按钮
    const toggleButtons = document.querySelectorAll(".toggle-reply-btn");

    // 为每个按钮绑定点击事件
    toggleButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const replyId = button.getAttribute("data-reply-id"); // 获取对应的 replyContent 的 ID
        const replyContent = document.getElementById(replyId); // 获取 replyContent 元素

        if (replyContent.style.display === "none") {
          // 如果当前隐藏，显示内容并切换按钮文本
          replyContent.style.display = "block";
          button.textContent = "收起";
        } else {
          // 如果当前显示，隐藏内容并切换按钮文本
          replyContent.style.display = "none";
          button.textContent = "查看回复";
        }
      });
    });
  });
</script>


</body>
</html>

