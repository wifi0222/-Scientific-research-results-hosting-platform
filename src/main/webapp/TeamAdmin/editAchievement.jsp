<%--
  Created by IntelliJ IDEA.
  User: zwb
  Date: 2024/12/20
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
    <title>修改科研成果</title>
    <link rel="stylesheet" type="text/css" href="../css/editAchievement.css">

    <!-- 引入Quill编辑器所需的CSS和JS -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

</head>
<body>
<h1>修改科研成果</h1>
<form action="/teamAdmin/achievements/edit/update" method="post" id="quillForm" enctype="multipart/form-data">
    <!-- 隐藏字段，用于存储成果ID -->
    <input type="hidden" name="achievementID" value="${achievement.achievementID}"/>

    <label>成果标题：</label><br>
    <input type="text" name="title" value="${achievement.title}" placeholder="如：基于深度学习的遥感图像分类技术"
           required><br><br>

    <label>成果类别：</label><br>
    <select name="category">
        <option value="专著" ${achievement.category == '专著' ? 'selected' : ''}>专著</option>
        <option value="专利" ${achievement.category == '专利' ? 'selected' : ''}>专利</option>
        <option value="软著" ${achievement.category == '软著' ? 'selected' : ''}>软著</option>
        <option value="产品" ${achievement.category == '产品' ? 'selected' : ''}>产品</option>
    </select><br><br>

    <label>摘要：</label><br>
    <textarea name="abstractContent" rows="3" placeholder="如：本专利提供了一种新型遥感图像分类算法，可提高分类准确率"
              required>${achievement.abstractContent}</textarea><br><br>

    <label>内容：</label><br>
    <!-- Quill编辑器的容器 -->
    <div id="editor-container" style="height: 300px;">
        ${achievement.contents}
    </div>
    <!-- 隐藏字段，用于提交编辑器内容 -->
    <input type="hidden" name="contents" id="hiddenInput" required>

    <label>当前附件：</label><br>
    <c:forEach var="file" items="${achievementFiles}">
        <c:if test="${file.type == 0}">
            <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>
            <!-- 删除附件按钮 -->
            <%--在 HTML 标准 中，不允许将一个 <form> 放在另一个 <form> 的内部--%>
<%--            <form action="/teamAdmin/deleteFile" method="post" style="display:inline;">--%>
<%--                <input type="hidden" name="fileID" value="${file.fileID}"/>--%>
<%--                <input type="hidden" name="achievementID" value="${achievement.achievementID}"/>--%>
<%--                <button type="submit" onclick="return confirm('确定要删除这个附件吗？');">删除</button>--%>
<%--            </form>--%>
            <!-- 删除附件按钮（用JS创建并提交表单） -->
            <button type="button"
                    onclick="deleteFile('${file.fileID}', '${achievement.achievementID}')">
                删除
            </button>
        </c:if>
    </c:forEach>
    <br>

    <label>增加附件（可选）：</label><br>
    <input type="file" name="attachmentFile"><br><br>

    <label>当前展示图片：</label><br>
    <c:forEach var="file" items="${achievementFiles}">
        <c:if test="${file.type == 1}">
            <%--先用 \\ 替换反斜杠，再用 %20 替换空格--%>
            <c:set var="encodedPath"
                   value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
            <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                 width="100"/>
            <!-- 删除图片按钮 -->
            <button type="button"
                    onclick="deleteFile('${file.fileID}', '${achievement.achievementID}')">
                删除
            </button>
        </c:if>
    </c:forEach>
    <br>

    <label>增加展示图片（可选）：</label><br>
    <input type="file" name="coverImage"><br><br>

    <label>发布日期：</label><br>
    <input type="date" name="creationTime"
           value="<fmt:formatDate value='${achievement.creationTime}' pattern='yyyy-MM-dd'/>" required>

    <button type="submit">保存修改</button>
    <!-- 返回主页按钮 -->
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/teamAdmin/achievements'">返回主页
    </button>
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
                    [{'header': 1}, {'header': 2}], // 标题
                    [{'list': 'ordered'}, {'list': 'bullet'}], // 列表
                    [{'script': 'sub'}, {'script': 'super'}], // 上标/下标
                    [{'indent': '-1'}, {'indent': '+1'}], // 缩进
                    ['link', 'image'], // 链接和图片
                    ['clean'] // 清除格式
                ],
                handlers: {
                    image: imageHandler // 自定义图片处理（可根据需要实现）
                }
            }
        }
    });

    // 设置编辑器内容
    quill.root.innerHTML = '${achievement.contents}';

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
                const response = await fetch('/teamAdmin/uploadImage', {
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

    // 删除附件/图片
    function deleteFile(fileID, achievementID) {
        // 1. 二次确认
        if (!confirm('确定要删除这个附件吗？')) {
            return;
        }

        // 2. 创建一个表单
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/teamAdmin/achievements/edit/deleteFile';

        // 3. 创建隐藏表单域，填入 fileID、achievementID
        const fileIDInput = document.createElement('input');
        fileIDInput.type = 'hidden';
        fileIDInput.name = 'fileID';
        fileIDInput.value = fileID;
        form.appendChild(fileIDInput);

        const achievementIDInput = document.createElement('input');
        achievementIDInput.type = 'hidden';
        achievementIDInput.name = 'achievementID';
        achievementIDInput.value = achievementID;
        form.appendChild(achievementIDInput);

        // 4. 将表单添加到 document.body 并提交
        document.body.appendChild(form);
        form.submit();

        // // 直接 GET 方式跳转，但是control是post，而且删除一般用post
        // window.location.href = '/teamAdmin/deleteFile?fileID=' + fileID + '&achievementID=' + achievementID;
    }
</script>
</body>
</html>
