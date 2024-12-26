<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>反馈管理</title>
    <!-- 引入外部CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../css/zwb_sidebar.css">
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #0056b3;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            border: 1px solid #b3d7ff;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #b3d7ff;
        }

        th {
            background-color: #0056b3;
            color: #ffffff;
        }

        tr:nth-child(even) {
            background-color: #e6f2ff;
        }

        a {
            color: #0056b3;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .status-pending {
            color: #f39c12;
            font-weight: bold;
        }

        .status-resolved {
            color: #27ae60;
            font-weight: bold;
        }

        .status-closed {
            color: #c0392b;
            font-weight: bold;
        }

        button {
            background-color: #0056b3; /* 设置背景颜色为蓝色 */
            color: white;           /* 设置文本颜色为白色 */
            cursor: pointer;        /* 鼠标悬停变为指针（可选） */
        }

        button:hover {
            background-color: darkblue; /* 鼠标悬停时变成深蓝色（可选） */
        }


        @media (max-width: 600px) {
            table {
                font-size: 12px;
            }

            th, td {
                padding: 5px;
            }
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
            <h2>反馈管理</h2>

            <!-- 筛选区域 -->
            <div class="filter-container">
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

            <!-- 数据表格 -->
            <table id="questionsTable">
                <thead>
                <tr>
                    <th>用户ID</th>
                    <th>标题</th>
                    <th>状态</th>
                    <th>提问时间</th>
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
                        <td>${question.askTime}</td>
                        <td>
                            <a href="/questions/ans-details/${question.questionID}">查看详情</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
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
