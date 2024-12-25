<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>问题详细信息</title>
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2, h3 {
            color: #0056b3;
            text-align: center;
        }

        p {
            margin: 10px 0;
            line-height: 1.6;
        }

        strong {
            color: #0056b3;
        }

        div {
            background-color: #e6f2ff;
            border: 1px solid #b3d7ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
            word-wrap: break-word;
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #0056b3;
        }

        select, button {
            padding: 10px;
            font-size: 14px;
            margin: 10px 0;
            border: 1px solid #b3d7ff;
            border-radius: 5px;
        }

        button {
            background-color: #0056b3;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #004494;
        }

        #editor-container {
            background-color: #ffffff;
            border: 1px solid #b3d7ff;
            padding: 10px;
            border-radius: 5px;
        }

        @media (max-width: 600px) {
            body {
                padding: 10px;
            }

            div {
                padding: 10px;
            }

            select, button {
                width: 100%;
            }

            #editor-container {
                padding: 5px;
            }
        }
    </style>
</head>
<body>
<h2>问题详情</h2>
<p><strong>用户ID：</strong> ${question.userID}</p>
<p><strong>提问时间：</strong> ${question.askTime}</p>

<!-- 更改状态功能 -->
<form action="/questions/${question.questionID}/updateStatus" method="post">
    <label for="status">更改状态：</label>
    <select name="status" id="status">
        <option value="0" ${question.status == 0 ? 'selected' : ''}>待处理</option>
        <option value="1" ${question.status == 1 ? 'selected' : ''}>已处理</option>
        <option value="-1" ${question.status == -1 ? 'selected' : ''}>关闭</option>
    </select>
    <button type="submit">更新状态</button>
</form>

<p><strong>标题：</strong> ${question.title}</p>
<p><strong>描述：</strong></p>
<div>${question.questionContent}</div>

<p><strong>回复</strong></p>

<c:choose>
    <%-- 如果 question.status 等于 0，则显示回复表单 --%>
    <c:when test="${question.status == 0}">
        <form action="/questions/${question.questionID}/reply" method="post" id="replyForm">
            <div id="editor-container" style="height: 300px;"></div>
            <input type="hidden" name="replyContent" id="hiddenInput">
            <button type="submit">提交</button>
        </form>
    </c:when>

    <%-- 如果 question.status 等于 1 或 -1，则显示已回复内容 --%>
    <c:otherwise>
        <c:if test="${not empty question.replyContent}">
            <div>${question.replyContent}</div>
        </c:if>
        <c:if test="${empty question.replyContent}">
            <div>还没有回复</div>
        </c:if>
    </c:otherwise>
</c:choose>

<script>
    // Quill 初始化
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: {
                container: [
                    ['bold', 'italic', 'underline', 'strike'],
                    ['blockquote', 'code-block'],
                    [{ 'header': 1 }, { 'header': 2 }],
                    [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                    [{ 'script': 'sub' }, { 'script': 'super' }],
                    [{ 'indent': '-1' }, { 'indent': '+1' }],
                    ['image'],
                    ['clean']
                ],
                handlers: {
                    image: imageHandler
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
                const response = await fetch('/questions/upload-image', {
                    method: 'POST',
                    body: formData
                });

                const result = await response.json();
                if (result.success) {
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

    // 拦截表单提交
    document.getElementById("replyForm").addEventListener("submit", function (event) {
        event.preventDefault(); // 阻止默认表单提交

        // 获取编辑器内容并同步到隐藏字段
        document.getElementById("hiddenInput").value = quill.root.innerHTML;

        // 构造请求数据
        const formData = new FormData(this);

        // 发送AJAX请求
        fetch(this.action, {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    return response.text(); // 根据后端响应类型调整
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
