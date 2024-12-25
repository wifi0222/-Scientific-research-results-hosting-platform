<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>提问页面</title>
    <link rel="stylesheet" href="/css/change-password.css">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

</head>
<body>
<div class="container">
    <!-- Header -->
    <header class="header">
        <div class="title">
                  <a href="/browse">
        <h1>信息浏览</h1>
      </a>
        </div>
        <c:choose>
            <c:when test="${empty user}">
                <div class="login-btn">
                    <a href="/login.jsp" class="btn-submit">登录</a>
                </div>
            </c:when>
        </c:choose>
    </header>
    <div class="content">
        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="/browse">信息浏览</a></li>
                <li><a href="/user/askQuestion" class="active">用户互动</a></li>
                <li><a href="/user/checkReply">我的反馈</a></li>
                <li><a href="/user/change-password">修改密码</a></li>
                <li><a href="/user/deactivate">账号注销</a></li>
                <li><a href="/user/deactivate/status">查询账号注销进度</a></li>
            </ul>
            <div class="logout">
                <a href="/user/logout">退出登录</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="section">
                <h1>提问页面</h1>

                <!-- 提问标题 -->
                <div class="form-group">
                    <label for="title">标题:</label>
                    <input type="text" id="title" name="title" placeholder="请输入问题标题">
                </div>

                <!-- 编辑器 -->
                <div class="form-group">
                    <label for="editor-container">问题描述:</label>
                    <div id="editor-container" style="height: 300px;"></div>
                </div>

                <!-- 提交表单 -->
                <form action="/questions/submit" method="post" id="questionForm">
                    <input type="hidden" name="questionContent" id="hiddenInput">
                    <input type="hidden" name="userID" value="${user.userID}">
                    <input type="hidden" name="title" id="hiddenTitle">
                    <button type="submit" class="btn-submit btn btn-primary">提交问题</button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        ABCD组 &copy; 2024
    </footer>
</div>

<script>
    // 初始化 Quill 编辑器
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: {
                container: [
                    ['bold', 'italic', 'underline', 'strike'], // 加粗、斜体、下划线等
                    ['blockquote', 'code-block'],
                    [{ 'header': 1 }, { 'header': 2 }], // 标题
                    [{ 'list': 'ordered' }, { 'list': 'bullet' }], // 列表
                    [{ 'script': 'sub' }, { 'script': 'super' }], // 上标/下标
                    [{ 'indent': '-1' }, { 'indent': '+1' }], // 缩进
                    ['image'], // 链接和图片
                    ['clean'] // 清除格式
                ],
                // handlers: {
                //     image: imageHandler // 自定义图片处理
                // }
            }
        }
    });

    // 自定义图片上传逻辑
    function imageHandler() {
        const input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');
        input.click();

        input.onchange = async () => {
            const file = input.files[0];
            const formData = new FormData();
            formData.append('image', file);

            try {
                // 上传图片到服务器
                const response = await fetch('/questions/upload-image', {
                    method: 'POST',
                    body: formData
                });

                const result = await response.json();
                if (result.success) {
                    // 在编辑器中插入图片
                    const range = quill.getSelection();
                    quill.insertEmbed(range.index, 'image', result.imageUrl);
                } else {
                    console.error('Image upload failed');
                }
            } catch (error) {
                console.error('Error uploading image:', error);
            }
        };
    }

    // 表单提交前，将编辑器内容和标题同步到隐藏字段
    document.getElementById('questionForm').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容
        document.getElementById('hiddenInput').value = content;

        var title = document.getElementById('title').value; // 获取标题内容
        document.getElementById('hiddenTitle').value = title;
    };

    document.getElementById('questionForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 阻止默认表单提交

        // 获取表单数据
        const formData = new FormData(this);

        // 发送POST请求到后端
        fetch('/questions/submit', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    return response.text(); // 如果后端返回JSON，使用response.json()
                } else {
                    throw new Error("提交失败");
                }
            })
            .then(data => {
                alert("问题提交成功！");
                // 刷新页面
                location.reload();
            })
            .catch(error => {
                console.error("提交错误：", error);
                alert("提交失败，请稍后重试！");
            });
    });
</script>
</body>
</html>
