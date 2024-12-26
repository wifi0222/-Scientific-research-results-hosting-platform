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

    <style>
        /* 根据需要，你可以在这里对只读状态的元素做特殊样式处理 */
        input[readonly], textarea[readonly], select[disabled] {
            background-color: #f2f2f2; /* 灰底，表示不可编辑 */
        }
    </style>
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
            <c:if test="${fn:length(files) > 0}">
                <div class="carousel">
                    <div class="carousel-images">
                        <c:forEach var="imageFile" items="${files}">
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
                        <c:forEach var="file" items="${files}">
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


<script>
    // 初始化 Quill 编辑器为只读模式
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        readOnly: true, // 关键：只读
        modules: {
            toolbar: false // 隐藏工具栏
        }
    });

    // 设置编辑器内容
    quill.root.innerHTML = `${achievement.contents}`;
</script>

<!-- 返回按钮（只读预览页面不做任何提交） -->
<button type="button" onclick="window.history.back()">返回</button>

</body>
</html>
