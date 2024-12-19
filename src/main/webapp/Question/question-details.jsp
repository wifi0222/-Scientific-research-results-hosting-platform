<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Question Details</title>
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
</head>
<body>
<h2>Question Details</h2>
<p><strong>User ID:</strong> ${question.userID}</p>
<p><strong>Ask Time:</strong> ${question.askTime}</p>
<p><strong>Content:</strong></p>
<div>${question.questionContent}</div>

<h3>Reply</h3>
<form action="/questions/${question.questionID}/reply" method="post" id="replyForm">
    <div id="editor-container" style="height: 300px;"></div>
    <input type="hidden" name="replyContent" id="hiddenInput">
    <button type="submit">Submit Reply</button>
</form>

<script>
    var quill = new Quill('#editor-container', {
        theme: 'snow'
    });

    document.getElementById("replyForm").onsubmit = function () {
        document.getElementById("hiddenInput").value = quill.root.innerHTML;
    };
</script>
</body>
</html>
