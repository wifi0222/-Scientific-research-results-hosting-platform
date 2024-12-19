<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2024/12/19
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
</head>
<body>
<h2>Submit Your Question</h2>
<div id="editor-container" style="height: 300px;"></div>
<form action="/questions/submit" method="post" id="questionForm">
    <input type="hidden" name="questionContent" id="hiddenInput">
    <input type="hidden" name="userID" value="1"> <!-- 假设用户ID为1 -->
    <button type="submit">Submit</button>
</form>

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

    // 表单提交前，将编辑器内容同步到隐藏字段
    document.getElementById('questionForm').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容
        document.getElementById('hiddenInput').value = content;
    };
</script>
</body>
</html>


