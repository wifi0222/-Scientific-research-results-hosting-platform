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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>修改文章</title>
    <link rel="stylesheet" type="text/css" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" type="text/css" href="/css/editAchievement.css">

    <!-- 引入Quill编辑器所需的CSS和JS -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <jsp:include page="/TeamAdmin/sidebar.jsp"/>

    <!-- 主内容 -->
    <div class="main">
        <!-- 返回主页按钮 -->
        <button type="button" class="return-home-btn"
                onclick="location.href='${pageContext.request.contextPath}/teamAdmin/achievements?type=1'">
            返回主页
        </button>

        <h1>修改文章</h1>
        <form action="/teamAdmin/achievements/edit/update?type=1" method="post" id="quillForm"
              enctype="multipart/form-data">
            <!-- 隐藏字段，用于存储文章ID -->
            <input type="hidden" name="id" value="${article.articleID}"/>

            <label>文章标题：</label><br>
            <input type="text" name="title" value="${article.title}" placeholder="如：基于深度学习的遥感图像分类技术"
                   required><br><br>

            <label>文章类别：</label><br>
            <select name="category">
                <option value="SCI" ${article.category == 'SCI' ? 'selected' : ''}>SCI</option>
                <option value="EI" ${article.category == 'EI' ? 'selected' : ''}>EI</option>
                <option value="核心" ${article.category == '核心' ? 'selected' : ''}>核心</option>
            </select><br><br>

            <label>摘要：</label><br>
            <textarea name="abstractContent" rows="3"
                      placeholder="如：本专利提供了一种新型遥感图像分类算法，可提高分类准确率"
                      required>${article.abstractContent}</textarea><br><br>

            <label>内容：</label><br>
            <!-- Quill编辑器的容器 -->
            <div id="editor-container" style="height: 300px;">
                ${article.contents}
            </div>
            <!-- 隐藏字段，用于提交编辑器内容 -->
            <input type="hidden" name="contents" id="hiddenInput" required>

            <label>当前附件：</label><br>
            <div class="attachment-section">
                <c:forEach var="file" items="${articleFiles}">
                    <c:if test="${file.type == 0}">
                        <div class="file-list">
                            <a href="/${file.filePath}" target="_blank">${file.fileName}</a>
                            <button type="button" class="delete-btn"
                                    onclick="deleteFile('${file.fileID}', '${article.articleID}')">
                                删除
                            </button>
                        </div>
                    </c:if>
                    <br>
                </c:forEach>
            </div>

            <label>增加附件（可选）：</label><br>
            <div class="upload-section">
                <input type="file" name="attachmentFile">
            </div>

            <label>当前展示图片：</label><br>
            <div class="cover-section">
                <div class="image-list">
                    <c:forEach var="file" items="${articleFiles}">
                        <c:if test="${file.type == 1}">
                            <div class="image-container">
                                    <%--先用 \\ 替换反斜杠，再用 %20 替换空格--%>
                                <c:set var="encodedPath"
                                       value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
                                <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                                     class="cover-image"/>
                                <button type="button" class="delete-btn"
                                        onclick="deleteFile('${file.fileID}', '${article.articleID}')">
                                    删除
                                </button>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <label>增加展示图片（可选）：</label><br>
            <div class="upload-section">
                <input type="file" name="coverImage">
            </div>

            <%--选择上传的时间--%>
            <label>发布日期：</label><br>
            <input type="datetime-local" id="creationTime" name="creationTime" required><br><br>

            <button type="submit">保存修改</button>
        </form>
    </div>
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
                    [{'header': 1}, {'header': 2}], // 标题
                    [{'list': 'ordered'}, {'list': 'bullet'}], // 列表
                    [{'script': 'sub'}, {'script': 'super'}], // 上标/下标
                    [{'indent': '-1'}, {'indent': '+1'}], // 缩进
                    ['link', 'image'], // 链接和图片
                    ['clean'] // 清除格式
                ],
                // handlers: {
                //     image: imageHandler // 自定义图片处理（可根据需要实现）
                // }
            }
        }
    });

    // 设置编辑器内容
    quill.root.innerHTML = '${article.contents}';

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
    function deleteFile(fileID, articleID) {
        // 1. 二次确认
        if (!confirm('确定要删除这个附件吗？')) {
            return;
        }

        // 2. 创建一个表单
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/teamAdmin/achievements/edit/deleteFile?type=1';

        // 3. 创建隐藏表单域，填入 fileID、articleID
        const fileIDInput = document.createElement('input');
        fileIDInput.type = 'hidden';
        fileIDInput.name = 'fileID';
        fileIDInput.value = fileID;
        form.appendChild(fileIDInput);

        const articleIDInput = document.createElement('input');
        articleIDInput.type = 'hidden';
        articleIDInput.name = 'id';
        articleIDInput.value = articleID;
        form.appendChild(articleIDInput);

        // 4. 将表单添加到 document.body 并提交
        document.body.appendChild(form);
        form.submit();

        // // 直接 GET 方式跳转，但是control是post，而且删除一般用post
        // window.location.href = '/teamAdmin/deleteFile?fileID=' + fileID + '&articleID=' + articleID;
    }

    window.addEventListener('pageshow', function (event) {
        const now = new Date();
        // 格式化为 yyyy-MM-ddTHH:mm
        const year = now.getFullYear();
        console.log(year)
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const defaultValue = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
        console.log(defaultValue)
        console.log("设置时间成功")

        // 设置 datetime-local 的 value
        document.getElementById('creationTime').value = defaultValue;
    });
</script>
<script>
    // 获取所有的a标签
    const menuLinks = document.querySelectorAll('ul > li > a');

    menuLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            // 如果是子菜单的链接，不阻止跳转
            if (this.nextElementSibling && this.nextElementSibling.classList.contains('submenu')) {
                // 这是父菜单，阻止跳转
                event.preventDefault(); // 阻止父菜单的默认跳转行为
                // 切换当前a标签的class
                this.classList.toggle('active');

                // 获取当前点击项的下一个子菜单
                const submenu = this.nextElementSibling;

                if (submenu && submenu.classList.contains('submenu')) {
                    // 切换子菜单的显示状态
                    submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
                }
            }
            // 对于子菜单项，允许跳转，不做任何处理
        });
    });
</script>
</body>
</html>
