<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>团队基本信息维护</title>

    <!-- 引入外部CSS库（例如Bootstrap）进行美化 -->
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">--%>
<%--    <link rel="stylesheet" href="/css/newSidebar.css">--%>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <!-- 引入Quill编辑器所需的CSS和JS -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

    <style>
        .main h1 {
            text-align: center;
            color: #4e73df;
            margin-bottom: 30px;
        }

        /* 表单样式 */
        .main form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: 0 auto;
        }

        .main label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333333;
        }

        .main input[type="text"],
        .main input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .main input[type="text"]:focus,
        .main input[type="date"]:focus {
            border-color: #4e73df;
            outline: none;
        }

        /* 提交按钮样式 */
        .InButton {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #4e73df;
            color: #ffffff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .InButton:hover {
            background-color: #2e59d9;
            box-shadow: 0 4px 8px rgba(46, 89, 217, 0.2);
        }

        .InButton[type="button"] {
            background-color: #6c757d;
            margin-left: 10px;
        }

        .InButton[type="button"]:hover {
            background-color: #5a6268;
            box-shadow: 0 4px 8px rgba(106, 115, 122, 0.2);
        }

        /* 屏幕较小时的响应式设计 */
        @media (max-width: 768px) {
            .content {
                padding: 15px;
            }

            .main form {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .main label {
                font-size: 14px;
            }

            .main input[type="submit"] {
                font-size: 14px;
                padding: 10px 18px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>

        <div class="main">
            <div class="section">
                <h1>团队基本信息维护</h1>

                <form action="/teamAdmin/TeamManage/Info/edit" method="post">
                    <div>
                        <label for="teamID">团队ID：</label>
                        <input type="text" id="teamID" name="teamID" value="${team.teamID}" readonly class="readonly">
                    </div>

                    <div>
                        <label for="teamName">团队名称：</label>
                        <input type="text" id="teamName" name="teamName" value="${team.teamName}">
                    </div>

                    <div>
                        <label for="researchArea">团队研究领域：</label>
                        <input type="text" id="researchArea" name="researchArea" value="${team.researchArea}">
                    </div>


                    <div>
                        <label>团队简介：</label><br>
                        <!-- 隐藏字段，用于提交编辑器内容 -->
                        <div id="introductionEditor" style="height: 300px;"></div>
                        <input type="hidden" name="introduction" id="introduction" ><br>
                    </div>

                    <div>
                        <label for="creationTime">团队创建时间：</label>
                        <input type="date" id="creationTime" name="creationTime" value="<fmt:formatDate value="${team.creationTime}" pattern="yyyy-MM-dd" />">
                    </div>

                    <div>
                        <button type="submit" class="InButton">提交修改</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    // 初始化 Quill 编辑器
    var quill = new Quill('#introductionEditor', {
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
    var initialContent = `${team.introduction}`;
    quill.root.innerHTML = initialContent;

    // 表单提交前，将编辑器内容同步到隐藏字段
    document.querySelector('form').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容
        document.getElementById('introduction').value = content;
    };

    function displayFileName() {
        var fileInput = document.getElementById('avatarFile');
        var fileName = fileInput.files[0] ? fileInput.files[0].name : ''; // 获取文件名
        document.getElementById('fileName').textContent = fileName; // 显示文件名
    }
</script>

</body>
</html>
