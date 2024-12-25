<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>修改团队成员信息</title>
    <link rel="stylesheet" href="/css/newSidebar.css">
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>

    <style>
        /* 表单样式 */
        .h1{
            text-align: center;
            padding: 6px;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }

        form input[type="text"], form input[type="email"], form input[type="password"], form select {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        form input[type="text"]:focus, form input[type="email"]:focus, form input[type="password"]:focus, form select:focus {
            border-color: #4e73df;
            outline: none;
        }

        form input[type="submit"] {
            background-color: #4e73df;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        form input[type="submit"]:hover {
            background-color: #355db3;
        }

        form label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        form span {
            color: red;
            font-size: 14px;
            display: inline-block;
            margin-top: 5px;
        }

        form .quill-editor {
            height: 300px;
            margin-top: 10px;
        }

        form .quill-editor input {
            display: none;
        }

        input[type="text"][readonly] {
            background-color: #f0f0f0;
            cursor: not-allowed;
        }

        /* 提示信息 */
        #emailError {
            font-size: 14px;
            color: red;
        }

        /* 新增：父容器使用flex布局，使Toptitle和back-btn并列展示 */
        .header-container {
            display: flex;
            justify-content: center;  /* 水平居中对齐 */
            align-items: center;      /* 垂直居中对齐 */
            gap: 20px;                /* 在标题和按钮之间添加间距 */
        }

        /* 使Toptitle居中 */
        .Toptitle {
            text-align: center;
            flex-grow: 1;             /* 使标题占据可用空间 */
        }

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
            text-align: center;
        }

        .back-btn a {
            text-decoration: none;
            color: white;
            display: flex;  /* 使用flex布局使图标居中 */
            align-items: center;
            justify-content: center;
        }

        /* 隐藏链接中的文字，只显示图标 */
        .back-btn a i {
            font-size: 20px; /* 设置图标大小 */
        }

        .back-btn:hover {
            background-color: #355db3; /* 悬停时背景色 */
            transform: translateX(5px); /* 向右移动 */
        }
    </style>
</head>
<body>
<div class="container">
    <div class="content">
    <!-- Sidebar -->
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'TeamAdmin'}">
                    <ul>
                        <li><a href="javascript:void(0);">团队管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                                <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                                <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);">科研成果管理与发布</a>
                            <ul class="submenu">
                                <li><a href="/research/submenu1">子菜单项1</a></li>
                                <li><a href="/research/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);">文章管理</a>
                            <ul class="submenu">
                                <li><a href="/article/submenu1">子菜单项1</a></li>
                                <li><a href="/article/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);">用户管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                                <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);">在线交流与反馈</a>
                            <ul class="submenu">
                                <li><a href="/feedback/submenu1">子菜单项1</a></li>
                                <li><a href="/feedback/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 普通用户的菜单项，若有的话 -->
                    <a href="user/ManagementLogin">管理员登录</a>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="main">
            <!-- 这里填充主内容，例如文章、图片等 -->
            <div class="section">
                <div class="header-container">
                    <button class="back-btn">
                        <a href="/teamAdmin/TeamManage/Member">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">修改用户信息</h1>
                </div>

                <form action="/teamAdmin/TeamManage/Member/edit" method="post" enctype="multipart/form-data">
                    <!-- 用户ID (只读) -->
                    用户ID：<input type="text" name="userID" value="${user.userID}" readonly><br>

                    <!-- 用户名 -->
                    用户名：<input type="text" name="username" value="${user.username}" readonly><br>

                <%--    <!-- 密码 -->--%>
                <%--    密码：<input type="password" name="password" value="${user.password}"><br>--%>

                <%--    <!-- 角色类型 -->--%>
                <%--    角色类型：<input type="text" name="roleType" value="${user.roleType}"><br>--%>

                    <!-- 邮箱 -->
                    邮箱：
                    <input type="text" id="email" name="email" value="${user.email}">
                    <span id="emailError" style="color:red; display:none;">请输入有效的邮箱地址</span><br>

                <%--    <!-- 状态 -->--%>
                <%--    状态：--%>
                <%--    <select name="status">--%>
                <%--        <option value="1" ${user.status == 1 ? 'selected' : ''}>可用</option>--%>
                <%--        <option value="0" ${user.status == 0 ? 'selected' : ''}>禁用</option>--%>
                <%--    </select><br>--%>

                    <!-- 姓名 -->
                    姓名：<input type="text" name="name" value="${user.name}"><br>

                    <!-- 研究方向 -->
                    研究方向：<input type="text" name="researchField" value="${user.researchField}"><br>

                    <!-- 联系方式 -->
                    联系方式：<input type="text" name="contactInfo" value="${user.contactInfo}"><br>

                    <!-- 学术背景 -->
                    学术背景：<input type="text" name="academicBackground" value="${user.academicBackground}"><br>

<%--                    <!-- 研究成果 -->--%>
<%--                    研究成果：<input type="text" name="researchAchievements" value="${user.researchAchievements}"><br>--%>
                    <label for="researchAchievements">科研成果:</label>
                    <div id="researchAchievementsEditor" style="height: 300px;"></div>
                    <input type="hidden" name="researchAchievements" id="researchAchievements"><br>

                    <!-- 提交按钮 -->
                    <input type="submit" value="提交修改">
                </form>
            </div>
        </div>
    </div>
</div>

<footer>
    ABCD组 &copy; 2024
</footer>

<script>
    // 获取邮箱输入框和提示信息元素
    var emailInput = document.getElementById('email');
    var emailError = document.getElementById('emailError');

    // 定义正则表达式用于验证邮箱格式
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // 监听用户输入事件
    emailInput.addEventListener('input', function() {
        var emailValue = emailInput.value;

        // 检查输入的邮箱是否符合格式
        if (emailPattern.test(emailValue)) {
            // 如果格式正确，隐藏错误提示
            emailError.style.display = 'none';
            emailInput.style.borderColor = '';  // 恢复输入框边框颜色
        } else {
            // 如果格式错误，显示错误提示
            emailError.style.display = 'inline';
            emailInput.style.borderColor = 'red';  // 设置红色边框提醒用户
        }
    });

    // 初始化 Quill 编辑器
    var quill = new Quill('#researchAchievementsEditor', {
        theme: 'snow',
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'], // 加粗、斜体、下划线等
                ['blockquote', 'code-block'],
                [{ 'header': 1 }, { 'header': 2 }], // 标题
                [{ 'list': 'ordered' }, { 'list': 'bullet' }], // 列表
                [{ 'script': 'sub' }, { 'script': 'super' }], // 上标/下标
                [{ 'indent': '-1' }, { 'indent': '+1' }], // 缩进
                ['image'], // 插入图片
                ['clean'] // 清除格式
            ]
        }
    });

    // 表单提交前，将编辑器内容同步到隐藏字段
    document.querySelector('form').onsubmit = function () {
        var content = quill.root.innerHTML; // 获取编辑器内容
        document.getElementById('researchAchievements').value = content;
    };

    function displayFileName() {
        var fileInput = document.getElementById('avatarFile');
        var fileName = fileInput.files[0] ? fileInput.files[0].name : ''; // 获取文件名
        document.getElementById('fileName').textContent = fileName; // 显示文件名
    }
</script>

<script>
    // 获取所有的a标签
    const menuLinks = document.querySelectorAll('ul > li > a');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
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

