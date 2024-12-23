<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>成员信息审核</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/sidebar.css">
    <script type="text/javascript">
        // 通过审核的函数
        function approveReview(memberID) {
            if (confirm("确定通过审核吗？")) {
                // 通过审核，跳转并传递审核结果
                window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=1";
            }
        }

        // 不通过审核的函数
        function rejectReview(memberID) {
            // 弹出框让用户输入拒绝理由
            var refuseReason = prompt("请输入拒绝理由：");
            if (refuseReason != null && refuseReason != "") {
                // 不通过审核，跳转并传递审核结果及拒绝理由
                window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=0"+"&refuseReason=" + encodeURIComponent(refuseReason);
            } else {
                alert("拒绝理由不能为空！");
            }
        }
    </script>
</head>
<body>
<h2>用户信息审核</h2>
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
                <table border="1" class="styled-table">
                    <thead>
                    <tr>
                        <th>用户ID</th>
                        <th>姓名</th>
                        <th>研究方向</th>
                        <th>联系方式</th>
                        <th>学术背景</th>
                        <th>科研成果</th>
                        <th>审核操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="review" items="${memberReviews}">
                        <tr>
                            <td>${review.memberID}</td>
                            <td>${review.name}</td>
                            <td>${review.researchField}</td>
                            <td>${review.contactInfo}</td>
                            <td>${review.academicBackground}</td>
                            <td>${review.researchAchievements}</td>
                            <td>
                                <a href="javascript:void(0);" onclick="approveReview(${review.memberID})" class="edit-button">通过</a> |
                                <a href="javascript:void(0);" onclick="rejectReview(${review.memberID})" class="edit-button">不通过</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer>
    ABCD组 &copy; 2024
</footer>

<script>
    // 检查错误信息并弹出提示框
    window.onload = function() {
        var errorMessage = "${message}";
        if (errorMessage) {
            alert(errorMessage);
        }else{
            errorMessage="${message}";
            if (errorMessage){
                alert(errorMessage);
            }
        }
    };
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


