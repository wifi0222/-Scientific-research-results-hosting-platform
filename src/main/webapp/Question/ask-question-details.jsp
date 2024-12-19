<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Question Details</title>
</head>
<body>
<h2>Question Details</h2>
<p><strong>Question ID:</strong> ${question.questionID}</p>
<p><strong>User ID:</strong> ${question.userID}</p>
<p><strong>Ask Time:</strong> ${question.askTime}</p>
<p><strong>Title:</strong> ${question.title}</p>
<p><strong>Status:</strong>
    <c:choose>
        <c:when test="${question.status == 0}">Pending</c:when>
        <c:when test="${question.status == 1}">Answered</c:when>
        <c:otherwise>Closed</c:otherwise>
    </c:choose>
</p>
<p><strong>Question Content:</strong></p>
<div>${question.questionContent}</div>

<p><strong>Reply Content:</strong></p>
<c:choose>
    <c:when test="${not empty question.replyContent}">
        <div>${question.replyContent}</div>
    </c:when>
    <c:otherwise>
        <p>No reply yet.</p>
    </c:otherwise>
</c:choose>
</body>
</html>
