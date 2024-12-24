<%--
  Created by IntelliJ IDEA.
  User: zwb
  Date: 2024/12/19
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
    <title>新增科研成果</title>
    <link rel="stylesheet" type="text/css" href="../css/addAchievement.css">

    <!-- 引入Quill编辑器所需的CSS和JS -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

</head>
<body>
<h1>新增科研成果</h1>
<form action="/teamAdmin/achievements/add" method="post" id="quillForm" enctype="multipart/form-data">
    <label>成果标题：</label><br>
    <input type="text" name="title" placeholder="如：基于深度学习的遥感图像分类技术" required><br><br>

    <label>成果类别：</label><br>
    <select name="category">
        <option value="专著">专著</option>
        <option value="专利">专利</option>
        <option value="软著">软著</option>
        <option value="产品">产品</option>
    </select><br><br>

    <label>摘要：</label><br>
    <textarea name="abstractContent" rows="3" placeholder="如：本专利提供了一种新型遥感图像分类算法，可提高分类准确率" required></textarea><br><br>

    <label>内容：</label><br>
    <!-- Quill编辑器的容器 -->
    <div id="editor-container" style="height: 300px;"></div>
    <!-- 隐藏字段，用于提交编辑器内容 -->
    <input type="hidden" name="contents" id="hiddenInput" required>

    <label>附件上传（可选）：</label><br>
    <input type="file" name="attachmentFile"><br><br>

    <label>展示图片上传（可选）：</label><br>
    <input type="file" name="coverImage"><br><br>

    <%--选择上传的时间--%>
    <label>发布日期：</label><br>
    <input type="datetime-local" id="creationTime" name="creationTime" required><br><br>


    <button type="submit">保存并发布</button>
    <!-- 返回主页按钮 -->
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/teamAdmin/achievements'">返回主页</button>
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
                    ['link', 'image'], // 链接和图片
                    ['clean'] // 清除格式
                ],
                handlers: {
                    image: imageHandler // 自定义图片处理（可根据需要实现）
                }
            }
        }
    });

    // 可选：自定义图片上传逻辑，如不需要可删除imageHandler方法并在toolbar中移除'image'
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
                // 上传图片到服务器（请根据实际情况修改URL和逻辑）
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
    document.getElementById('quillForm').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容的HTML
        document.getElementById('hiddenInput').value = content;
    };
</script>
</body>
</html>
