<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>问题详情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #0056b3;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            margin: 10px 0;
            line-height: 1.6;
        }

        strong {
            color: #0056b3;
        }

        div {
            background-color: #e6f2ff;
            border: 1px solid #b3d7ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
            word-wrap: break-word;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            color: #fff;
        }

        .status-pending {
            background-color: #f39c12;
        }

        .status-resolved {
            background-color: #27ae60;
        }

        .status-closed {
            background-color: #c0392b;
        }

        .no-reply {
            font-style: italic;
            color: #888;
        }

        @media (max-width: 600px) {
            body {
                padding: 10px;
            }

            div {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<h2>问题详情</h2>
<p><strong>问题ID：</strong> ${question.questionID}</p>
<p><strong>用户ID：</strong> ${question.userID}</p>
<p><strong>提问时间：</strong> <fmt:formatDate value='${question.askTime}'
                                              pattern='yyyy-MM-dd HH:mm'/></p>
<p><strong>标题：</strong> ${question.title}</p>
<p><strong>状态：</strong>
    <span class="status ">
        <c:choose>
            <c:when test="${question.status == 0}">
                <span class="status status-pending">待处理</span>
            </c:when>
            <c:when test="${question.status == 1}">
                <span class="status status-resolved">已处理</span>
            </c:when>
            <c:otherwise>
                <span class="status status-closed">关闭</span>
            </c:otherwise>
        </c:choose>
    </span>
</p>
<p><strong>描述：</strong></p>
<div>${question.questionContent}</div>

<p><strong>回复：</strong></p>
<c:choose>
    <c:when test="${not empty question.replyContent}">
        <div>${question.replyContent}</div>
    </c:when>
    <c:otherwise>
        <p class="no-reply">还没有回复</p>
    </c:otherwise>
</c:choose>
</body>
</html>
