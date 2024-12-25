<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page isELIgnored="false" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>修改团队管理员的信息</title>--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">--%>
<%--    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">--%>
<%--    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>--%>
<%--    <link rel="stylesheet" href="/css/sidebar.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <div class="sidebar">--%>
<%--        <c:choose>--%>
<%--            <c:when test="${userRoleType == 'SuperAdmin'}">--%>
<%--                <ul>--%>
<%--                    <li><a href="/SuperController/UserManagement" class="active">用户管理</a></li>--%>
<%--                    <li><a href="/SuperController/TeamAdministratorManagement">权限管理</a></li>--%>
<%--                    <li><a href="/user/checkReply">内容审核</a></li>--%>
<%--                </ul>--%>
<%--                <div class="logout">--%>
<%--                    <a href="/user/logout">退出登录</a>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <ul>--%>
<%--                    <li><a href="/login.jsp">登录</a></li>--%>
<%--                </ul>--%>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>
<%--    </div>--%>

<%--    <div class="content">--%>
<%--        <div class="main">--%>
<%--            <div class="section">--%>
<%--                <form action="/SuperController/TeamAdminManage/edit" method="GET" enctype="multipart/form-data">--%>
<%--                        <div>--%>
<%--                            用户ID(无法修改)：<input type="text" name="userID" value="${user.userID}" readonly>--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            用户名（无法修改)：<input type="text" name="username" value="${user.username}" readonly>--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            密码：<input type="text" name="password" value="${user.password}">--%>
<%--                        </div>--%>

<%--                        <!-- 角色类型单选框 -->--%>
<%--                        <div>--%>
<%--                            角色类型：--%>
<%--                            <input type="radio" id="roleTypeTeamAdmin" name="roleType" value="TeamAdmin" ${user.roleType == 'TeamAdmin' ? 'checked' : ''}>--%>
<%--                            <label for="roleTypeTeamAdmin">团队管理员</label>--%>

<%--                            <input type="radio" id="roleTypeTeamMember" name="roleType" value="TeamMember" ${user.roleType == 'TeamMember' ? 'checked' : ''}>--%>
<%--                            <label for="roleTypeTeamMember">团队成员</label>--%>

<%--                            <input type="radio" id="roleTypeVisitor" name="roleType" value="Visitor" ${user.roleType == 'Visitor' ? 'checked' : ''}>--%>
<%--                            <label for="roleTypeVisitor">普通用户</label>--%>
<%--                        </div>--%>

<%--                        <div>--%>
<%--                            邮箱：--%>
<%--                            <input type="text" id="email" name="email" value="${user.email}">--%>
<%--                            <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span>--%>
<%--                        </div>--%>

<%--                        <div>--%>
<%--                            <label for="registrationTime">注册时间（无法修改）：--%>
<%--                                <input type="text" id="registrationTime" name="registrationTime"--%>
<%--                                       value="${user.registrationTime}" readonly />--%>
<%--                            </label>--%>
<%--                        </div>--%>

<%--                        <!-- 账号状态单选框 -->--%>
<%--                        <div>--%>
<%--                            账号状态：--%>
<%--                            <input type="radio" id="statusActive" name="status" value="1" ${user.status == 1 ? 'checked' : ''}>--%>
<%--                            <label for="statusActive">正常使用</label>--%>

<%--                            <input type="radio" id="statusInactive" name="status" value="0" ${user.status == 0 ? 'checked' : ''}>--%>
<%--                            <label for="statusInactive">禁用</label>--%>
<%--                        </div>--%>

<%--                        <div>--%>
<%--                            姓名：<input type="text" name="name" value="${user.name}">--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            研究方向：<input type="text" name="researchField" value="${user.researchField}">--%>
<%--                        </div>--%>
<%--                        <div>--%>
<%--                            联系方式：<input type="text" name="contactInfo" value="${user.contactInfo}">--%>
<%--                        </div>--%>

<%--                        <div>--%>
<%--                            学术背景：<input type="text" name="academicBackground" value="${user.academicBackground}">--%>
<%--                        </div>--%>


<%--                        <label for="researchAchievements">科研成果:</label>--%>
<%--                            <div id="researchAchievementsEditor" style="height: 300px;">--%>
<%--                            <input type="hidden" name="researchAchievements" id="researchAchievements" value="${user.researchAchievements}"><br>--%>
<%--                            </div>--%>

<%--                        <input type="submit" value="提交">--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--    <script>--%>
<%--        // 获取邮箱输入框和提示信息元素--%>
<%--        var emailInput = document.getElementById('email');--%>
<%--        var emailError = document.getElementById('emailError');--%>

<%--        // 定义正则表达式用于验证邮箱格式--%>
<%--        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;--%>

<%--        // 监听用户输入事件--%>
<%--        emailInput.addEventListener('input', function() {--%>
<%--            var emailValue = emailInput.value;--%>

<%--            // 检查输入的邮箱是否符合格式--%>
<%--            if (emailPattern.test(emailValue)) {--%>
<%--                // 如果格式正确，隐藏错误提示--%>
<%--                emailError.style.display = 'none';--%>
<%--                emailInput.style.borderColor = '';  // 恢复输入框边框颜色--%>
<%--            } else {--%>
<%--                // 如果格式错误，显示错误提示--%>
<%--                emailError.style.display = 'inline';--%>
<%--                emailInput.style.borderColor = 'red';  // 设置红色边框提醒用户--%>
<%--            }--%>
<%--        });--%>
<%--    </script>--%>

<%--    <script>--%>
<%--        // 初始化 Quill 编辑器--%>
<%--        var quill = new Quill('#researchAchievementsEditor', {--%>
<%--            theme: 'snow',--%>
<%--            modules: {--%>
<%--                toolbar: [--%>
<%--                    ['bold', 'italic', 'underline', 'strike'], // 加粗、斜体、下划线等--%>
<%--                    ['blockquote', 'code-block'],--%>
<%--                    [{ 'header': 1 }, { 'header': 2 }], // 标题--%>
<%--                    [{ 'list': 'ordered' }, { 'list': 'bullet' }], // 列表--%>
<%--                    [{ 'script': 'sub' }, { 'script': 'super' }], // 上标/下标--%>
<%--                    [{ 'indent': '-1' }, { 'indent': '+1' }], // 缩进--%>
<%--                    ['image'], // 插入图片--%>
<%--                    ['clean'] // 清除格式--%>
<%--                ]--%>
<%--            }--%>
<%--        });--%>

<%--        // 表单提交前，将编辑器内容同步到隐藏字段--%>
<%--        document.querySelector('form').onsubmit = function () {--%>
<%--            var content = quill.root.innerHTML; // 获取编辑器内容--%>
<%--            document.getElementById('researchAchievements').value = content;--%>
<%--        };--%>

<%--        function displayFileName() {--%>
<%--            var fileInput = document.getElementById('avatarFile');--%>
<%--            var fileName = fileInput.files[0] ? fileInput.files[0].name : ''; // 获取文件名--%>
<%--            document.getElementById('fileName').textContent = fileName; // 显示文件名--%>
<%--        }--%>
<%--    </script>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改团队管理员的信息</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <link rel="stylesheet" href="/css/newSidebar.css">
    <style>
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 4px;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
        }

        .btn-primary {
            background-color: #4e73df;
            border-color: #4e73df;
            padding: 10px 20px;
            border-radius: 4px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .form-check-label {
            margin-left: 5px;
        }

        .form-check {
            margin-bottom: 10px;
        }

        .error-message {
            color: red;
            display: none;
        }

        #researchAchievementsEditor {
            height: 300px;
            border: 1px solid #ccc;
        }

        /* 按钮样式 */
        /* 按钮样式 */
        .back-btn {
            background-color: #4e73df; /* 按钮背景色 */
            border: none;
            border-radius: 5px; /* 圆角边框 */
            padding: 12px 20px;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
            position: relative; /* 相对定位，为了放置箭头 */
        }

        .back-btn a{
            font-size: 16px;
            color: white;
            text-align: center;
            text-decoration: none; /* 去掉下划线 */
            font-weight: bold; /* 设置字体加粗 */
        }

        /* 按钮悬停时 */
        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }

        /* 在悬停时显示箭头 */
        .back-btn:hover::after {
            font-size: 20px;
            margin-left: 10px; /* 箭头和文字之间的间距 */
            position: absolute;
            right: -25px; /* 箭头位于按钮的右侧 */
            top: 50%;
            transform: translateY(-50%); /* 垂直居中 */
            transition: transform 0.3s ease-in-out; /* 平滑过渡 */
        }

        /* ======== 自定义单选框样式 ======== */
        input[type="radio"] {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 20px;
            height: 20px;
            border: 2px solid #ccc;
            border-radius: 50%;
            position: relative;
            cursor: pointer;
            background-color: #fff;
            transition: background-color 0.3s, border-color 0.3s;
        }

        input[type="radio"]:checked {
            border-color: #4e73df;
            background-color: #4e73df;
        }

        input[type="radio"]:checked::after {
            content: '\f00c'; /* Unicode勾选符号 */
            font-family: "Font Awesome 5 Free", sans-serif;
            font-weight: 900;
            color: white;
            position: absolute;
            top: 2px;
            left: 2px;
            font-size: 14px;
            line-height: 16px;
        }

        /* 鼠标悬停时改变单选框颜色 */
        input[type="radio"]:hover {
            border-color: #3578f3;
        }

        input[type="radio"]:checked:hover {
            background-color: #3578f3;
            border-color: #3578f3;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="content">
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'SuperAdmin'}">
                    <ul>
                        <li><a href="/SuperController/UserManagement" class="active">用户管理</a></li>
                        <li><a href="/SuperController/TeamAdministratorManagement">权限管理</a></li>
                        <li><a href="/user/checkReply">内容审核</a></li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul>
                        <li><a href="/login.jsp">登录</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="main">
            <div class="section">
                <h1>修改团队管理员信息</h1>

                <button class="back-btn">
                    <a href="/SuperController/UserManagement">返回用户管理</a>
                </button>

                <form action="/SuperController/TeamAdminManage/edit" method="GET" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="userID">用户ID(无法修改)：</label>
                        <input type="text" name="userID" id="userID" value="${user.userID}" readonly class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="username">用户名（无法修改)：</label>
                        <input type="text" name="username" id="username" value="${user.username}" readonly class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="password">密码：</label>
                        <input type="text" name="password" id="password" value="${user.password}" class="form-control">
                    </div>

                    <!-- 角色类型单选框 -->
                    <div class="form-group">
                        <label>角色类型：</label>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="roleTypeTeamAdmin" name="roleType" value="TeamAdmin" ${user.roleType == 'TeamAdmin' ? 'checked' : ''} class="form-check-input">
                            <label for="roleTypeTeamAdmin" class="form-check-label">团队管理员</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="roleTypeTeamMember" name="roleType" value="TeamMember" ${user.roleType == 'TeamMember' ? 'checked' : ''} class="form-check-input">
                            <label for="roleTypeTeamMember" class="form-check-label">团队成员</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="roleTypeVisitor" name="roleType" value="Visitor" ${user.roleType == 'Visitor' ? 'checked' : ''} class="form-check-input">
                            <label for="roleTypeVisitor" class="form-check-label">普通用户</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">邮箱：</label>
                        <input type="text" id="email" name="email" value="${user.email}" class="form-control">
                        <span id="emailError" class="error-message">请输入有效的邮箱地址</span>
                    </div>

                    <div class="form-group">
                        <label for="registrationTime">注册时间（无法修改）：</label>
                        <input type="text" id="registrationTime" name="registrationTime" value="${user.registrationTime}" readonly class="form-control">
                    </div>

                    <!-- 账号状态单选框 -->
                    <div class="form-group">
                        <label>账号状态：</label>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="statusActive" name="status" value="1" ${user.status == 1 ? 'checked' : ''} class="form-check-input">
                            <label for="statusActive" class="form-check-label">正常使用</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="statusInactive" name="status" value="0" ${user.status == 0 ? 'checked' : ''} class="form-check-input">
                            <label for="statusInactive" class="form-check-label">禁用</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="name">姓名：</label>
                        <input type="text" name="name" id="name" value="${user.name}" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="researchField">研究方向：</label>
                        <input type="text" name="researchField" id="researchField" value="${user.researchField}" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="contactInfo">联系方式：</label>
                        <input type="text" name="contactInfo" id="contactInfo" value="${user.contactInfo}" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="academicBackground">学术背景：</label>
                        <input type="text" name="academicBackground" id="academicBackground" value="${user.academicBackground}" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="researchAchievements">科研成果：</label>
                        <div id="researchAchievementsEditor"></div>
                        <input type="hidden" name="researchAchievements" id="researchAchievements" value="${user.researchAchievements}">
                    </div>

                    <div class="form-group">
                        <input type="submit" value="提交" class="btn btn-primary">
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // 邮箱验证
    var emailInput = document.getElementById('email');
    var emailError = document.getElementById('emailError');
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    emailInput.addEventListener('input', function() {
        var emailValue = emailInput.value;
        if (emailPattern.test(emailValue)) {
            emailError.style.display = 'none';
            emailInput.style.borderColor = '';
        } else {
            emailError.style.display = 'inline';
            emailInput.style.borderColor = 'red';
        }
    });

    // 初始化 Quill 编辑器
    var quill = new Quill('#researchAchievementsEditor', {
        theme: 'snow',
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],
                ['blockquote', 'code-block'],
                [{ 'header': 1 }, { 'header': 2 }],
                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                [{ 'script': 'sub' }, { 'script': 'super' }],
                [{ 'indent': '-1' }, { 'indent': '+1' }],
                ['image'],
                ['clean']
            ]
        }
    });

    // 表单提交时同步编辑器内容
    document.querySelector('form').onsubmit = function () {
        var content = quill.root.innerHTML;
        document.getElementById('researchAchievements').value = content;
    };
</script>

</body>
</html>
