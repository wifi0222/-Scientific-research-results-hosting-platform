<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
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
<%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">--%>
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
<%--    <link rel="stylesheet" href="/css/changeTeamAdmin.css">--%>
    <style>
            /* 表单样式 */
            .main h1 {
                color: #4e73df;
                margin-bottom: 20px;
                font-size: 28px;
                padding-bottom: 10px;
                text-align: center;
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

            /* Quill 编辑器容器样式 */
            #researchAchievementsEditor {
                height: 400px;  /* 设置合适的高度 */
                border: 1px solid #ced4da;  /* 为编辑器添加边框 */
                border-radius: 5px;  /* 圆角边框 */
                padding: 10px;  /* 添加内边距 */
                overflow-y: auto;  /* 当内容超出时，允许垂直滚动 */
            }

            /* 提交按钮样式 */
            .InButton {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background-color: #4e73df;
                margin-top: 10px;
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

        /* 父容器使用flex布局，使Toptitle和back-btn并列展示 */
        .header-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }

        .Toptitle {
            color: #4e73df;
            margin-bottom: 20px;
            font-size: 28px;
            padding-bottom: 10px;
            text-align: center;
            flex-grow: 1;
        }

        /* 按钮样式 */
        .back-btn {
            background-color: #4e73df;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
        }

        .back-btn a {
            text-decoration: none;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .back-btn a i {
            font-size: 20px;
        }

        .back-btn:hover {
            background-color: #355db3;
            transform: translateX(5px);
        }

            /* 自定义单选框样式 */
            .main .form-check-input {
                display: none; /* 隐藏默认单选框 */
            }

            /* 创建自定义单选框 */
            .main .form-check-label {
                position: relative;
                padding-left: 30px; /* 给label添加左侧空间 */
                cursor: pointer;
                font-size: 16px;
                color: #333;
                display: inline-block;
                line-height: 24px;
            }

            /* 单选框外观 */
            .main .form-check-label:before {
                content: ''; /* 空内容 */
                position: absolute;
                left: 0;
                top: 0;
                width: 20px;
                height: 20px;
                border: 2px solid #4e73df;
                border-radius: 50%;
                background-color: white;
                transition: background-color 0.3s, border-color 0.3s; /* 平滑过渡 */
            }

            /* 单选框选中状态 */
            .main .form-check-input:checked + .form-check-label:before {
                background-color: #4e73df;
                border-color: #4e73df;
            }

            /* 在选中状态下改变单选框内圆的样式 */
            .main .form-check-input:checked + .form-check-label:after {
                content: '';
                position: absolute;
                left: 6px;
                top: 6px;
                width: 8px;
                height: 8px;
                background-color: white;
                border-radius: 50%;
                transition: background-color 0.3s;
            }

            /* 鼠标悬停时的样式 */
            .main .form-check-label:hover:before {
                border-color: #2e59d9;
            }

            /* 可选样式 - 提高交互体验 */
            .main .form-check-label:active:before {
                transform: scale(1.1);
            }

    </style>
</head>
<body>

<div class="container">
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/SuperAdmin/sidebar.jsp"/>

        <div class="main">
            <div class="section">
                <div class="header-container">
                    <button class="back-btn">
                        <a href="/SuperController/UserManagement">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">修改团队管理员信息</h1>
                </div>


                <form action="/SuperController/TeamAdminManage/edit" method="GET" enctype="multipart/form-data">
                    <div class="form-group" hidden="hidden">
                        <label for="userID">用户ID：</label>
                        <input type="text" name="userID" id="userID" value="${user.userID}" readonly class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="username">用户名：</label>
                        <input type="text" name="username" id="username" value="${user.username}" readonly class="form-control">
                    </div>

<%--                    <!-- 角色类型单选框 -->--%>
<%--                    <div class="form-group">--%>
<%--                        <label>角色类型：</label>--%>
<%--                        <div class="form-check form-check-inline">--%>
<%--                            <input type="radio" id="roleTypeTeamAdmin" name="roleType" value="TeamAdmin" ${user.roleType == 'TeamAdmin' ? 'checked' : ''} class="form-check-input">--%>
<%--                            <label for="roleTypeTeamAdmin" class="form-check-label">团队管理员</label>--%>
<%--                        </div>--%>
<%--                        <div class="form-check form-check-inline">--%>
<%--                            <input type="radio" id="roleTypeTeamMember" name="roleType" value="TeamMember" ${user.roleType == 'TeamMember' ? 'checked' : ''} class="form-check-input">--%>
<%--                            <label for="roleTypeTeamMember" class="form-check-label">团队成员</label>--%>
<%--                        </div>--%>
<%--                        <div class="form-check form-check-inline">--%>
<%--                            <input type="radio" id="roleTypeVisitor" name="roleType" value="Visitor" ${user.roleType == 'Visitor' ? 'checked' : ''} class="form-check-input">--%>
<%--                            <label for="roleTypeVisitor" class="form-check-label">普通用户</label>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                    <div class="form-group">
                        <label for="email">邮箱：</label>
                        <input type="text" id="email" name="email" value="${user.email}" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="registrationTime">注册时间：</label>
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

<%--                    <div class="form-group">--%>
<%--                        <label for="researchField">研究方向：</label>--%>
<%--                        <input type="text" name="researchField" id="researchField" value="${user.researchField}" class="form-control">--%>
<%--                    </div>--%>

                    <div class="form-group">
                        <label for="contactInfo">联系方式：</label>
                        <input type="text" name="contactInfo" id="contactInfo" value="${user.contactInfo}" class="form-control">
                    </div>

<%--                    <div class="form-group">--%>
<%--                        <label for="academicBackground">学术背景：</label>--%>
<%--                        <input type="text" name="academicBackground" id="academicBackground" value="${user.academicBackground}" class="form-control">--%>
<%--                    </div>--%>

<%--                    <div class="form-group">--%>
<%--                        <label for="researchAchievements">科研成果：</label>--%>
<%--                        <div id="researchAchievementsEditor"></div>--%>
<%--                        <input type="hidden" name="researchAchievements" id="researchAchievements" value="${user.researchAchievements}">--%>
<%--                    </div>--%>

                    <button type="submit" class="InButton">
                        提交修改
                    </button>

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
