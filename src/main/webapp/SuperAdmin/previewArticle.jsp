<%-- previewArticle.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>预览科研成果</title>
    <link rel="stylesheet" type="text/css" href="../css/editAchievement.css">

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
<h1>预览科研成果</h1>
<!-- 只读模式，不需要提交表单，所以可以去掉 form -->
<div>
    <label>成果标题：</label><br>
    <!-- 标题只读 -->
    <input type="text" name="title" value="${article.title}" readonly="readonly"/><br><br>

    <label>成果类别：</label><br>
    <!-- 类别禁用 -->
    <select name="category" disabled="disabled">
        <option value="SCI" ${article.category == 'SCI' ? 'selected' : ''}>SCI</option>
        <option value="EI" ${article.category == 'EI' ? 'selected' : ''}>EI</option>
        <option value="核心" ${article.category == '核心' ? 'selected' : ''}>核心</option>
    </select><br><br>

    <label>摘要：</label><br>
    <!-- 文本框只读 -->
    <textarea name="abstractContent" rows="3" readonly="readonly">
        ${article.abstractContent}
    </textarea><br><br>

    <label>内容：</label><br>
    <!-- Quill编辑器容器，只读模式 -->
    <div id="editor-container" style="height: 300px;">
        ${article.contents}
    </div>

    <label>附件：</label><br>
    <c:forEach var="file" items="${articleFiles}">
        <c:if test="${file.type == 0}">
            <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>
        </c:if>
    </c:forEach>
    <br>

    <label>展示图片：</label><br>
    <c:forEach var="file" items="${articleFiles}">
        <c:if test="${file.type == 1}">
            <c:set var="encodedPath"
                   value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
            <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片" width="100"/>
        </c:if>
    </c:forEach>
    <br>

    <label>发布日期：</label><br>
    <fmt:formatDate value="${article.publishDate}" pattern="yyyy-MM-dd HH:mm"/>
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
    quill.root.innerHTML = `${article.contents}`;
</script>

<!-- 返回按钮（只读预览页面不做任何提交） -->
<button type="button" onclick="window.history.back()">返回</button>

</body>
</html>
