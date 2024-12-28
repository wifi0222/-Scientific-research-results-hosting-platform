<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>反馈管理</title>
    <!-- 引入外部CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../css/zwb_sidebar.css">
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">

    <style>
        button {
            background-color: #4e73df;
            color: #ffffff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s, opacity 0.3s;
        }

        button:hover {
            background-color: #355db3;
        }

        button#resetButton {
            background-color: #6c757d;
        }

        button#resetButton:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Content -->
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>

        <div class="main">
            <h1>反馈管理</h1>

            <!-- 筛选区域 -->
            <div class="search-filter">
                <label for="statusFilter">按状态筛选：</label>
                <select id="statusFilter">
                    <option value="">所有状态</option>
                    <option value="0">待处理</option>
                    <option value="1">已处理</option>
                    <option value="-1">关闭</option>
                </select>

                <label for="userIDSearch">按用户ID搜索：</label>
                <input type="text" id="userIDSearch" placeholder="输入用户ID">

                <button onclick="applyFilters()">筛选</button>
            </div>

            <div class="section active">
                <!-- 数据表格 -->
                <table id="questionsTable" class="achievement-table">
                    <thead>
                    <tr>
                        <th>用户ID</th>
                        <th style="width: 200px;">标题</th>
                        <th style="width: 50px;">状态</th>
                        <th style="width: 200px;">提问时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 动态生成的行 -->
                    <c:forEach var="question" items="${questions}">
                        <tr>
                            <td>${question.userID}</td>
                            <td>${question.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${question.status == 0}"><span class="status-pending">待处理</span></c:when>
                                    <c:when test="${question.status == 1}"><span class="status-resolved">已处理</span></c:when>
                                    <c:otherwise><span class="status-closed">关闭</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value='${question.askTime}' pattern='yyyy-MM-dd HH:mm'/></td>
                            <td>
                                <a href="/questions/ans-details/${question.questionID}" class="btn-view">查看详情</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // 页面加载时设置默认的状态为"待处理"
    window.onload = function() {
        const statusFilter = document.getElementById('statusFilter');
        statusFilter.value = "0";  // 设置默认状态为"待处理"
        applyFilters();  // 调用筛选函数以便只显示"待处理"状态的记录
    };

    function applyFilters() {
        const statusFilter = document.getElementById('statusFilter').value; // 获取状态筛选值
        const userIDSearch = document.getElementById('userIDSearch').value.trim(); // 获取用户ID搜索值

        const table = document.getElementById('questionsTable');
        const rows = table.getElementsByTagName('tr'); // 获取表格所有行

        // 从第二行开始遍历（跳过表头）
        for (let i = 1; i < rows.length; i++) {
            const row = rows[i];
            const userIDCell = row.cells[0].textContent; // 用户ID列
            const statusCell = row.cells[2].textContent; // 状态列

            let matchesStatus = true;
            let matchesUserID = true;

            // 状态筛选
            if (statusFilter !== "") {
                if (statusFilter === "0" && !statusCell.includes("待处理")) {
                    matchesStatus = false;
                } else if (statusFilter === "1" && !statusCell.includes("已处理")) {
                    matchesStatus = false;
                } else if (statusFilter === "-1" && !statusCell.includes("关闭")) {
                    matchesStatus = false;
                }
            }

            // 用户ID搜索
            if (userIDSearch !== "" && !userIDCell.includes(userIDSearch)) {
                matchesUserID = false;
            }

            // 如果两者都匹配，显示行，否则隐藏
            if (matchesStatus && matchesUserID) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }
</script>
</body>
</html>
