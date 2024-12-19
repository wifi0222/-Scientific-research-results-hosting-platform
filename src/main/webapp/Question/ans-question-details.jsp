<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Question Details</title>
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
</head>
<body>
<h2>Question Details</h2>
<p><strong>User ID:</strong> ${question.userID}</p>
<p><strong>Ask Time:</strong> ${question.askTime}</p>
<p><strong>Title:</strong> ${question.title}</p>
<p><strong>Content:</strong></p>
<div>${question.questionContent}</div>

<h3>Reply</h3>
<form action="/questions/${question.questionID}/reply" method="post" id="replyForm">
    <div id="editor-container" style="height: 300px;"></div>
    <input type="hidden" name="replyContent" id="hiddenInput">
    <button type="submit">Submit Reply</button>
</form>

<script>
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
                handlers: {
                    image: imageHandler // 自定义图片处理
                }
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

    document.getElementById("replyForm").onsubmit = function () {
        document.getElementById("hiddenInput").value = quill.root.innerHTML;
    };
</script>
</body>
</html>
