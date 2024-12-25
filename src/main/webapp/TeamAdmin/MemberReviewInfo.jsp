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
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/memberReviewInfo.css">
    <style>
        /* 按钮样式 */
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .btn-pass {
            margin-top: 20px;
            margin-left: 20px;
            background-color: #3e8e41;
            color: white;
            font-weight: bold;
        }

        .btn-pass:hover {
            background-color: darkgreen;
        }

    </style>

    <script type="text/javascript">
        // 通过审核的函数
        function approveReview(memberID) {
            showApproveModal(memberID);
        }

        // 不通过审核的函数
        // 模拟点击不通过审核按钮，展示模态框
        function rejectReview(memberID) {
            showRejectModal();
            var submitButton = document.getElementById("submitReason");
            submitButton.onclick = function() {
                var refuseReason = document.getElementById("refuseReason").value;
                if (refuseReason != "") {
                    closeRejectModal();
                    // 跳转并传递拒绝理由
                    window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=0&refuseReason=" + encodeURIComponent(refuseReason);
                } else {
                    alert("拒绝理由不能为空！");
                }
            };
        }
    </script>
    <script>
        // 弹出模态框函数
        function showRejectModal() {
            var modal = document.getElementById("myModal");
            var modalContent = document.querySelector("#myModal .modal-content");
            modal.style.display = "block";

            // 添加显示动画
            setTimeout(function() {
                modalContent.classList.add("show");
            }, 10);

            // 关闭按钮事件
            var closeBtn = document.getElementsByClassName("close-reject")[0];
            closeBtn.onclick = function() {
                closeRejectModal();
            };
        }

        // 关闭模态框的函数
        function closeRejectModal() {
            var modal = document.getElementById("myModal");
            var modalContent = document.querySelector("#myModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        }

        // 弹出通过审核模态框函数
        function showApproveModal(memberID) {
            var modal = document.getElementById("approveModal");
            var modalContent = document.querySelector("#approveModal .modal-content");
            modal.style.display = "block";

            // 添加显示动画
            setTimeout(function() {
                modalContent.classList.add("show");
            }, 10);

            // 关闭按钮事件
            var closeBtn = document.getElementsByClassName("close-approve")[0];
            closeBtn.onclick = function() {
                closeApproveModal();
            };

            // 确定按钮事件
            var approveButton = document.getElementById("approveButton");
            approveButton.onclick = function() {
                // 通过审核，跳转并传递审核结果
                window.location.href = "/teamAdmin/TeamManage/Member/review?memberID=" + memberID + "&status=1";
            };
        }

        // 关闭模态框的函数
        function closeApproveModal() {
            var modal = document.getElementById("approveModal");
            var modalContent = document.querySelector("#approveModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        }

    </script>
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
                <h1>团队成员信息审核</h1>

                <!-- 搜索与筛选表单 -->
                <div class="search-filter">
                    <label for="keyword">姓名：</label>
                    <input type="text" id="keyword" placeholder="请输入姓名关键词">

                    <button type="button" id="searchButton">搜索</button>
                    <button type="button" id="resetButton">重置</button>
                </div>

                <table  class="styled-table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllCheckbox"/>
                            全选
                        </th>
                        <th>ID</th>
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
                        <tr class="one-row"
                            data-name="${review.name}">
                            <td>
                                <input type="checkbox"
                                       class="rowCheckbox"
                                       name="selectedRows"
                                       value="${review.memberID}">
                            </td>

                            <td>${review.memberID}</td>
                            <td>${review.name}</td>
                            <td>${review.researchField}</td>
                            <td>${review.contactInfo}</td>
                            <td>${review.academicBackground}</td>
                            <td>${review.researchAchievements}</td>
                            <td>
<%--                                <a href="javascript:void(0);" onclick="approveReview(${review.memberID})" >通过</a>--%>
<%--                                <br>--%>
<%--                                <a href="javascript:void(0);" onclick="rejectReview(${review.memberID})" >不通过</a>--%>
                                <button class="btn-pass" onclick="approveReview(${review.memberID})">
                                    <i class="fas fa-check"></i><span>通过</span>
                                </button>

                                <button class="btn-reject" onclick="rejectReview(${review.memberID})">
                                    <i class="fas fa-times"></i><span>拒绝</span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>


                <button type="button" id="batchPassButton" class="btn btn-pass">
                    批量通过
                </button>

            </div>
        </div>
    </div>
</div>

<footer>
    ABCD组 &copy; 2024
</footer>


<!-- 模态框 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close-reject">&times;</span>
        <h3>请输入拒绝理由</h3>
        <textarea id="refuseReason" rows="5" placeholder="请输入拒绝理由..."></textarea><br><br>
        <button id="submitReason" class="modal-button">提交</button>
    </div>
</div>

<div id="approveModal" class="modal">
    <div class="modal-content">
        <span class="close-approve">&times;</span>
        <h3>审核通过</h3>
        <p>确定通过该成员的审核吗？</p>
        <button id="approveButton" class="modal-button">确定</button>
    </div>
</div>

<div id="batchModal" class="modal">
    <div class="modal-content">
        <span class="close-batch">&times;</span>
        <h3>审核通过</h3>
        <p>确定通过全部选中成员的审核吗？</p>
        <button id="batchButton" class="modal-button">确定</button>
    </div>
</div>

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

<!-- 引入外部JS文件 -->
<script src="../js/memberReviewInfo.js"></script>
</body>
</html>


