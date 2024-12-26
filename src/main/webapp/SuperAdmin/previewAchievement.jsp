<%-- previewAchievement.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>预览科研成果</title>
    <link rel="stylesheet" type="text/css" href="/css/previewAchievement.css">
    <link rel="stylesheet" type="text/css" href="/css/zwb_sidebar.css">

    <!-- 引入Quill编辑器所需的CSS和JS -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <jsp:include page="/SuperAdmin/sidebar.jsp"/>

    <!-- 主内容 -->
    <div class="main">
        <!-- 返回按钮 -->
        <button type="button" class="return-home-btn"
                onclick="location.href='${pageContext.request.contextPath}/SuperController/auditAchievements?type=0'">
            返回
        </button>

        <%--        <h1>预览科研成果</h1>--%>

        <!-- 只读模式内容 -->
        <div>
            <!-- 成果标题 -->
            <h2 class="title">${achievement.title}</h2>

            <!-- 轮播图 -->
            <c:if test="${fn:length(achievementFiles) > 0}">
                <div class="carousel">
                    <div class="carousel-images">
                        <c:forEach var="imageFile" items="${achievementFiles}">
                            <c:if test="${imageFile.type == 1}">
                                <c:set var="encodedPath"
                                       value="${fn:replace(fn:replace(imageFile.filePath, '\\\\', '/'), ' ', '%20')}"/>
                                <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                                     class="carousel-img">
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="carousel-controls">
                        <button onclick="moveCarousel(-1)">&#10094;</button>
                        <button onclick="moveCarousel(1)">&#10095;</button>
                    </div>
                </div>
            </c:if>

            <div class="content-wrapper">
                <!-- 类别和时间 -->
                <div class="category-time">
                    <p>类别: ${achievement.category}</p>
                    <p>时间: <fmt:formatDate value="${achievement.creationTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                </div>

                <!-- 摘要 -->
                <p class="abstract-label">摘要:</p>
                <p class="abstract">${achievement.abstractContent}</p>

                <!-- 内容 -->
                <p class="contents-label">内容:</p>
                <p class="contents">${achievement.contents}</p>

                <!-- 文件列表 -->
                <div class="file-list">
                    <ul>
                        <c:forEach var="file" items="${achievementFiles}">
                            <c:if test="${file.type == 0}">
                                <li>
                                    <a href="/${file.filePath}" target="_blank"
                                       class="download-btn">${file.fileName}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 返回按钮（只读预览页面不做任何提交） -->
<button type="button" onclick="window.history.back()">返回</button>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const images = document.querySelectorAll('.carousel-img'); // 获取所有的图片元素
        let currentIndex = 0;

        // 初始化，显示第一张图片
        images[currentIndex].classList.add('active');

        // 添加类名来管理图片切换
        function showNextImage() {
            images[currentIndex].classList.remove('active');   // 移除当前显示的图片的 active 类
            currentIndex = (currentIndex + 1) % images.length; // 计算下一个图片的索引
            images[currentIndex].classList.add('active');      // 给下一张图片添加 active 类
        }

        function showPrevImage() {
            images[currentIndex].classList.remove('active');   // 移除当前显示的图片的 active 类
            currentIndex = (currentIndex - 1 + images.length) % images.length; // 计算上一张图片的索引
            images[currentIndex].classList.add('active');      // 给上一张图片添加 active 类
        }

        setInterval(showNextImage, 3000); // 每3秒切换一次图片

        // 手动控制轮播图
        window.moveCarousel = function (direction) {
            if (direction === 1) {
                showNextImage();
            } else if (direction === -1) {
                showPrevImage();
            }
        };
    });
</script>
</body>
</html>
