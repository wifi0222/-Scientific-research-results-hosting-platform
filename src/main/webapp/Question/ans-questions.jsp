<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pending Questions</title>
</head>
<body>
<h2>Pending Questions</h2>
<table border="1">
    <tr>
        <th>User ID</th>
        <th>Title</th>
        <th>Status</th>
        <th>Ask Time</th>
        <th>Action</th>
    </tr>
    <c:forEach var="question" items="${questions}">
        <tr>
            <td>${question.userID}</td>
            <td>${question.title}</td>
            <td>
                <c:choose>
                    <c:when test="${question.status == 0}">Pending</c:when>
                    <c:when test="${question.status == 1}">Answered</c:when>
                    <c:otherwise>Closed</c:otherwise>
                </c:choose>
            </td>
            <td>${question.askTime}</td>
            <td>
                <a href="/questions/ans-details/${question.questionID}">View Question</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
