<%--
  Created by IntelliJ IDEA.
  User: keyanluo
  Date: 2024/12/19
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理用户权限</title>
</head>
<body>
    <h1>为${teamAdministrator.adminName}设置权限</h1>
    <p>${teamAdministrator.adminID}</p>
    <h2>
        <a href="/editAdministrator?set='setModelAdministrator'&adminID=${teamAdministrator.adminID}">
            一键为用户设置团队管理员基本权限（包括发布权限、用户管理权限)
        </a>
    </h2>

    <h2>设置全部权限：</h2>
    <form action="editAdministrator" method="get">
        <input type="text" name="set" value="setAll" hidden="hidden">
        <input type="text" name="adminID" value="${teamAdministrator.adminID}" hidden="hidden">
        <!-- 发布科研成果权限 -->
        <label>发布科研成果权限：</label>
        <label>
            <input type="radio" name="publishPermission" value="1" ${teamAdministrator.publishPermission == true ? 'checked' : ''}> 有权限
        </label>
        <label>
            <input type="radio" name="publishPermission" value="0" ${teamAdministrator.publishPermission == false ? 'checked' : ''}> 无权限
        </label>
        <br>

        <!-- 审核用户权限 -->
        <label>审核用户权限：</label>
        <label>
            <input type="radio" name="userPermission" value="1" ${teamAdministrator.userPermission == true ? 'checked' : ''}> 有权限
        </label>
        <label>
            <input type="radio" name="userPermission" value="0" ${teamAdministrator.userPermission == false ? 'checked' : ''}> 无权限
        </label>
        <br>

        <!-- 删除科研成果权限 -->
        <label>删除科研成果权限：</label>
        <label>
            <input type="radio" name="deletePermission" value="1" ${teamAdministrator.deletePermission == true ? 'checked' : ''}> 有权限
        </label>
        <label>
            <input type="radio" name="deletePermission" value="0" ${teamAdministrator.deletePermission == false ? 'checked' : ''}> 无权限
        </label>
        <br>

        <input type="submit" value="提交权限设置">
    </form>
</body>
</html>
