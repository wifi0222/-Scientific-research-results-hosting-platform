<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>审核用户注册</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<%--    <link rel="stylesheet" href="/css/newSidebar.css">--%>
    <link rel="stylesheet" href="/css/zwb_sidebar.css">
    <link rel="stylesheet" href="/css/modal.css">
    <link rel="stylesheet" href="/css/userRegisterManage.css">
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

        .main h1 {
            text-align: center;
            color: #4a4a4a;
            margin-bottom: 30px;
        }

        .section-active {
            margin: 20px;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: 1.5px solid #4e73df;
        }
    </style>

    <script>
        // 检查错误信息并弹出提示框
        window.onload = function() {
            var errorMessage = "${message}";
            if (errorMessage) {
                alert(errorMessage);
            }
        };
    </script>

    <script type="text/javascript">
        // 通过审核的函数
        function approveReview(username) {
            showApproveModal(username);
        }

        // 不通过审核的函数
        // 模拟点击不通过审核按钮，展示模态框
        function rejectReview(username) {
            showRejectModal();
            var submitButton = document.getElementById("submitReason");
            submitButton.onclick = function() {
                var refuseReason = document.getElementById("refuseReason").value;
                if (refuseReason != "") {
                    closeRejectModal();
                    // 跳转并传递拒绝理由
                    window.location.href = "/teamAdmin/RegisterReview?username=" + username + "&status=0"+"&refuseReason=" + encodeURIComponent(refuseReason);
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
        function showApproveModal(username) {
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
                window.location.href = "/teamAdmin/RegisterReview?username=" + username + "&status=1";
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
    <div class="content">

        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>


        <div class="main">
            <!-- 这里填充主内容，例如文章、图片等 -->
<%--            <div class="section">--%>
                <h1>待审核用户列表</h1>

                <!-- 搜索与筛选表单 -->
                <div class="search-filter">
                    <label for="keyword">用户名：</label>
                    <input type="text" id="keyword" placeholder="请输入用户名">

                    <label for="startDate">申请时间从：</label>
                    <input type="date" id="startDate">

                    <label for="endDate">到：</label>
                    <input type="date" id="endDate">

                    <button type="button" id="searchButton">搜索</button>
                    <button type="button" id="resetButton">重置</button>
                </div>

                <div class="section-active">
                    <table border="1" class="styled-table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAllCheckbox"/>
                                全选
                            </th>
                            <th>用户名</th>
                            <th>申请时间</th>
                            <th>申请理由</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr class="one-row"
                                data-username="${user.username}"
                                data-creationTime="${user.registrationTime}">
                                <td>
                                    <input type="checkbox"
                                           class="rowCheckbox"
                                           name="selectedRows"
                                           value="${user.username}">
                                </td>
                                <td>${user.username}</td>
                                <td>
                                    <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td>${user.applicationReason}</td>
                                <td>
                                    <!-- 详情按钮 -->
                                    <button class="btn-preview" onclick="window.location.href='/teamAdmin/RegisterReview/Details?username=${user.username}'">
                                        <i class="fas fa-eye"></i><span>详情</span>
                                    </button>

                                    <!-- 通过按钮 -->
                                    <button class="btn-pass" onclick="approveReview('${user.username}')">
                                        <i class="fas fa-check"></i><span>通过</span>
                                    </button>

                                    <!-- 不通过按钮 -->
                                    <button class="btn-reject" onclick="rejectReview('${user.username}')">
                                        <i class="fas fa-times"></i><span>不通过</span>
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
        <p>确定通过该成员的注册申请吗？</p>
        <button id="approveButton" class="modal-button">确定</button>
    </div>
</div>

<div id="batchModal" class="modal">
    <div class="modal-content">
        <span class="close-batch">&times;</span>
        <h3>审核通过</h3>
        <p>确定通过全部选中成员的注册吗？</p>
        <button id="batchButton" class="modal-button">确定</button>
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

<!-- 引入外部JS文件 -->
<script src="../js/userRegisterManage.js"></script>
</body>
</html>
