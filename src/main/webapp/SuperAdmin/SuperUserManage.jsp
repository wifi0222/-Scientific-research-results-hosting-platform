<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/17
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>超级管理员用户管理</title>
</head>
<body>
    <%--展示团队管理员列表--%>
    <c:if test="${not empty message}">
        <p>${message}</p>
    </c:if>

    <!-- 如果存在error属性，显示弹窗提示 -->
    <div th:if="${AddTeamAdminRemind}" th:text="${AddTeamAdminRemind}" style="color: red;"></div>

    <h1>团队管理员</h1>
    <table border="1">
        <thead>
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>姓名</th>
            <th>邮箱</th>
            <th>管理团队</th>
            <th>注册时间</th>
            <th>账号状态</th>
            <th>操作</th>
            <!-- 这里可以根据实际需要增加更多的列 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.userID}</td>
                <td>${user.username}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>团队名称</td>
                <td>
                    <fmt:formatDate value="${user.registrationTime}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.status == 1}">正常</c:when>
                        <c:when test="${user.status == 0}">禁用</c:when>
                    </c:choose>
                </td>
                <td>
                    <div>
                        <!-- 修改链接，传递 userID 作为查询参数-->
                        <a href="/SuperController/ToChangeTeamAdmin?userID=${user.userID}">编辑</a>
                        <!-- 删除链接，传递 userID 作为查询参数 -->
                        <a href="javascript:void(0);" onclick="confirmDelete(${user.userID})">删除</a>
                    </div>
                </td>
                <!-- 这里根据用户对象的属性输出信息 -->
            </tr>



        </c:forEach>
        </tbody>
    </table>


    <a href="/SuperController/ToAddTeamAdmin">添加团队管理员</a>


    <%--显示添加团队管理员是否成功--%>
    <script>
        // 检查错误信息并弹出提示框
        window.onload = function() {
            var errorMessage = "${AddTeamAdminRemind}";
            if (errorMessage) {
                alert(errorMessage);
            }else{
                errorMessage="${ChangeTeamAdminRemind}";
                if (errorMessage){
                    alert(errorMessage);
                }
            }
        };
    </script>
    <script>
        // 在删除按钮点击时，弹出确认框
        function confirmDelete(userID) {
            var result = confirm("确定要删除该管理员吗？");
            if (result) {
                // 如果确认删除，跳转到删除链接
                window.location.href = "/SuperController/TeamAdminManage/delete?userID=" + userID;
            }
        }
    </script>
</body>
</html>
