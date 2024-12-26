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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" href="/css/changeTeamAdmin.css">
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
