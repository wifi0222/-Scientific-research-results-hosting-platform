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
    <link rel="stylesheet" href="/css/sidebar.css">
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
    </STYLE>
</head>
<body>
<div class="container">
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

    <div class="content">
        <div class="main">
            <div class="section">
                <h1>待审核用户详情</h1>

                <div class="user-details">
                    <div class="detail-row">
                        <label>用户名：</label>
                        <span>${registrationReview.username}</span>
                    </div>
                    <div class="detail-row">
                        <label>用户类型：</label>
                        <span>
                      <c:choose>
                          <c:when test="${registrationReview.roleType == 'TeamMember'}">团队成员</c:when>
                          <c:when test="${registrationReview.roleType == 'Visitor'}">普通用户</c:when>
                      </c:choose>
                    </span>
                    </div>
                    <div class="detail-row">
                        <label>用户邮箱：</label>
                        <span>${registrationReview.email}</span>
                    </div>
                    <div class="detail-row">
                        <label>用户注册时间：</label>
                        <span><fmt:formatDate value="${registrationReview.registrationTime}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="detail-row">
                        <label>用户申请理由：</label>
                        <span>${registrationReview.applicationReason}</span>
                    </div>
                </div>

                <!-- 详情按钮 -->
                <button class="back-btn" onclick="window.location.href='/teamAdmin/ToUserRegisterManage'">
                    返回审核注册页面
                </button>
            </div>
        </div>
    </div>
</div>

<footer>
    ABCD组 &copy; 2024
</footer>

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
