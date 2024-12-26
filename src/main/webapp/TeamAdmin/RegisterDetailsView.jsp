<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核用户注册查看详情</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<%--    <link rel="stylesheet" href="/css/newSidebar.css">--%>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">

    <STYLE>
        /* 章节标题 */
        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        /* 用户信息区域 */
        .user-details {
            font-size: 16px;
            line-height: 1.8;
            color: #555;
        }

        /* 每一行的显示方式 */
        .detail-row {
            margin-bottom: 15px;
        }

        /* 标签 */
        .detail-row label {
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }

        /* 用户信息内容 */
        .detail-row span {
            color: #777;
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
            color: #4e73df;
            margin-bottom: 20px;
            font-size: 28px;
            padding-bottom: 10px;
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

        .user-details {
            text-align: center;
            font-size: 16px;
            line-height: 1.8;
            color: #555;
        }

        .detail-row {
            margin-bottom: 15px;
        }

        .detail-row label {
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }

        .detail-row span {
            color: #777;
        }

        .content-section {
            margin: 20px 0;
            padding: 15px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #4e73df;
            margin-bottom: 10px;
        }

        .content-section p {
            font-size: 16px;
            color: #333;
            line-height: 1.6;
        }

        /* 提示信息 */
        .content-section p {
            word-wrap: break-word; /* 防止长文本溢出 */
        }
    </STYLE>
</head>
<body>
<div class="container">
    <div class="content">
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>


        <div class="main">
            <div class="section">
                <div class="header-container">
                    <button class="back-btn">
                        <a href="/teamAdmin/ToUserRegisterManage">
                            <i class="fas fa-arrow-left"></i>  <!-- 使用 FontAwesome 返回箭头图标 -->
                        </a>
                    </button>
                    <h1 class="Toptitle">待审核用户详情</h1>
                </div>

                    <div class="content-section">
                        <label class="section-title">用户名：</label>
                        <span>${registrationReview.username}</span>
                    </div>

                    <div class="content-section">
                        <label class="section-title">用户类型：</label>
                        <span>
                      <c:choose>
                          <c:when test="${registrationReview.roleType == 'TeamMember'}">团队成员</c:when>
                          <c:when test="${registrationReview.roleType == 'Visitor'}">普通用户</c:when>
                      </c:choose>
                    </span>
                    </div>

                    <div class="content-section">
                        <label class="section-title">用户邮箱：</label>
                        <span>${registrationReview.email}</span>
                    </div>

                    <div class="content-section">
                        <label class="section-title">用户注册时间：</label>
                        <span><fmt:formatDate value="${registrationReview.registrationTime}" pattern="yyyy-MM-dd" /></span>
                    </div>

                    <div class="content-section">
                        <label class="section-title">用户申请理由：</label>
                        <span>${registrationReview.applicationReason}</span>
                    </div>
            </div>
        </div>
    </div>
</div>


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
