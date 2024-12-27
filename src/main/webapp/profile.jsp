<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: 王斐--%>
<%--  Date: 2024/12/19--%>
<%--  Time: 13:07--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html; charset=UTF-8" %>--%>
<%--<%@ page isELIgnored="false" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>个人信息管理</title>--%>
<%--    <link rel="stylesheet" href="/css/change-password.css">--%>
<%--    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">--%>
<%--    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <!-- 内容部分 -->--%>
<%--    <div class="content">--%>
<%--        <!-- 左侧边栏 -->--%>
<%--        <div class="sidebar">--%>
<%--            <ul>--%>
<%--                <li><a href="/browse">信息浏览</a></li>--%>
<%--                <li><a href="/user/profile" class="active">个人信息管理</a></li>--%>
<%--                <li><a href="/user/profile/status">查询信息修改审核进度</a></li>--%>
<%--                <li><a href="/user/change-password">修改密码</a></li>--%>
<%--                <li><a href="/user/deactivate">账号注销</a></li>--%>
<%--              <li><a href="/user/deactivate/status">查询账号注销进度</a></li>--%>
<%--            </ul>--%>
<%--            <div class="logout">--%>
<%--                <a href="/user/logout">退出登录</a>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!-- 右侧主内容 -->--%>
<%--        <div class="main">--%>
<%--            <div class="section">--%>
<%--                <h1>个人信息管理</h1>--%>

<%--                <c:if test="${not empty error}">--%>
<%--                    <p style="color: red;">${error}</p>--%>
<%--                </c:if>--%>

<%--                <c:if test="${not empty message}">--%>
<%--                    <p style="color: green;">${message}</p>--%>
<%--                </c:if>--%>

<%--                <form action="/user/profile/update" method="post">--%>
<%--                    <label for="name">姓名:</label>--%>
<%--                    <input type="text" id="name" name="name" value="${user.name}" required><br>--%>

<%--                    <label for="researchField">研究方向:</label>--%>
<%--                    <input type="text" id="researchField" name="researchField" value="${user.researchField}" required><br>--%>

<%--                    <label for="contactInfo">联系方式:</label>--%>
<%--                    <input type="text" id="contactInfo" name="contactInfo" value="${user.contactInfo}" required><br>--%>

<%--                    <label for="academicBackground">学术背景:</label>--%>
<%--                    <input type="text" id="academicBackground" name="academicBackground" value="${user.academicBackground}" required><br>--%>

<%--                    <label for="researchAchievements">科研成果:</label>--%>
<%--                    <input type="text" id="researchAchievements" name="researchAchievements" value="${user.researchAchievements}" required><br>--%>

<%--                    <button type="submit" class="btn-submit">保存修改</button>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <footer>--%>
<%--        ABCD组 &copy; 2024--%>
<%--    </footer>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息管理</title>
    <link rel="stylesheet" href="/css/change-password.css">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <script src="/js/browse.js" defer></script>
</head>
<body>
<div class="container">
    <!-- Header -->
    <header class="header">
        <c:choose>
            <c:when test="${empty user}">
            </c:when>
            <c:otherwise>
                <button class="sidebar-toggle">☰</button>
            </c:otherwise>
        </c:choose>
        <div class="title"><a href="/browse">
            <h1>信息浏览</h1>
        </a></div>
        <c:choose>
            <c:when test="${empty user}">
                <div class="login-btn">
                    <a href="/login.jsp" class="btn-submit">登录</a>
                </div>
            </c:when>
        </c:choose>
    </header>
    <!-- 内容部分 -->
    <div class="content">
        <c:if test="${not empty user}">
            <!-- 左侧边栏 -->
            <div class="sidebar">
                <ul>
                    <li><a href="/browse">信息浏览</a></li>
                    <li><a href="/user/memberProfile" class="active">个人信息</a></li>
                    <li><a href="/user/profile/status">查询信息修改审核进度</a></li>
                    <li><a href="/user/change-password">修改密码</a></li>
                    <li><a href="/user/deactivate">账号注销</a></li>
                </ul>
                <div class="logout">
                    <a href="/user/logout">退出登录</a>
                </div>
            </div>
        </c:if>

        <!-- 右侧主内容 -->
        <div class="main">
            <div class="section">
                <h1>个人信息管理</h1>

                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>

                <c:if test="${not empty message}">
                    <p style="color: green;">${message}</p>
                </c:if>

                <form action="/user/profile/update" method="post" enctype="multipart/form-data" class="biao">
                    <!-- 上传头像 -->
                    <label for="avatarFile" class="file-upload-label">上传头像:</label>
                    <input type="file" id="avatarFile" name="avatarFile" class="file-upload-input" onchange="displayFileName()">

                    <!-- 显示当前头像 -->
                    <c:choose>
                        <c:when test="${not empty user.avatarFile}">
                            <c:set var="encodedPath" value="${fn:replace(fn:replace(user.avatarFile, '\\\\', '/'), ' ', '%20')}"/>
                            <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="头像" class="current-avatar" id="current-avatar"/>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>

                    <span id="fileName" style="margin-left: 10px;"></span><br>

                    <label for="name">姓名:</label>
                    <input type="text" id="name" name="name" value="${user.name}" required><br>

                    <label for="researchField">研究方向:</label>
                    <input type="text" id="researchField" name="researchField" value="${user.researchField}" required><br>

                    <label for="contactInfo">联系方式:</label>
                    <input type="text" id="contactInfo" name="contactInfo" value="${user.contactInfo}" required><br>

                    <label for="academicBackground">学术背景:</label>
                    <input type="text" id="academicBackground" name="academicBackground" value="${user.academicBackground}" required><br>

                    <label for="researchAchievements">科研成果:</label>
                    <div id="researchAchievementsEditor" style="height: 300px;"></div>
                    <input type="hidden" name="researchAchievements" id="researchAchievements"><br>

                    <label>内容：</label><br>
                    <!-- Quill编辑器的容器 -->
                    <div id="editor-container" style="height: 300px;"></div>
                    <!-- 隐藏字段，用于提交编辑器内容 -->
                    <input type="hidden" name="contents" id="hiddenInput" required>

                    <button type="submit" class="btn-submit">保存修改</button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>

<script>
    // 显示文件名
    function displayFileName() {
        var fileInput = document.getElementById('avatarFile');
        var fileName = fileInput.files[0] ? fileInput.files[0].name : ''; // 获取文件名
        document.getElementById('fileName').textContent = fileName; // 显示文件名

        // 显示选择的头像
        var reader = new FileReader();
        reader.onload = function (e) {
            var avatarImage = document.getElementById('current-avatar');
            avatarImage.src = e.target.result; // 设置为选中的图片
        };
        reader.readAsDataURL(fileInput.files[0]); // 读取文件为 Data URL
    }

    // 初始化 Quill 编辑器
    var quill = new Quill('#researchAchievementsEditor', {
        theme: 'snow',
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'], // 加粗、斜体、下划线等
                ['blockquote', 'code-block'],
                [{ 'header': 1 }, { 'header': 2 }], // 标题
                [{ 'list': 'ordered' }, { 'list': 'bullet' }], // 列表
                [{ 'script': 'sub' }, { 'script': 'super' }], // 上标/下标
                [{ 'indent': '-1' }, { 'indent': '+1' }], // 缩进
                ['image'], // 插入图片
                ['clean'] // 清除格式
            ]
        }
    });

    // 将服务器端传递的已有内容加载到 Quill 编辑器
    var initialContent = `${user.researchAchievements}`;
    quill.root.innerHTML = initialContent;

    // 表单提交前，将编辑器内容同步到隐藏字段
    document.querySelector('form').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容
        document.getElementById('researchAchievements').value = content;
    };
</script>

</body>
</html>
