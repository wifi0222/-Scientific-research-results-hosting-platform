<%--
  Created by IntelliJ IDEA.
  User: 86136
  Date: 2024/12/27
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>团队管理员标签页</title>
  <!-- 引入外部CSS文件 -->
  <link rel="stylesheet" type="text/css" href="../css/zwb_sidebar.css">
<%--  <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">--%>
  <link rel="stylesheet" href="../css/userManagement_new.css">
  <link rel="stylesheet" href="../css/modal.css">
  <script type="text/javascript">
    //确认删除
    function confirmLogout(userId) {
      showLogoutModal(userId);
    }

    //确认重置
    function confirmReset(userId) {
      showResetModal(userId);
    }

    //确认注销
    function confirmSetStatus(userID){
      showSetStatusModal(userID);
    }

  </script>

  <script>
    // 弹出删除模态框函数
    function showLogoutModal(userId) {
      var modal = document.getElementById("LogoutModal");
      var modalContent = document.querySelector("#LogoutModal .modal-content");
      modal.style.display = "block";

      // 添加显示动画
      setTimeout(function() {
        modalContent.classList.add("show");
      }, 10);

      // 关闭按钮事件
      var closeBtn = document.getElementsByClassName("close-logout")[0];
      closeBtn.onclick = function() {
        closeLogoutModal();
      };

      // 确定按钮事件
      var approveLogoutButton = document.getElementById("approve-logout-Button");
      approveLogoutButton.onclick = function() {
        // 删除用户
        window.location.href = "/teamAdmin/UserManage/logoutUser?userID=" + userId;
      };
    }

    // 关闭模态框的函数
    function closeLogoutModal() {
      var modal = document.getElementById("LogoutModal");
      var modalContent = document.querySelector("#LogoutModal .modal-content");

      // 隐藏模态框的动画效果
      modalContent.classList.remove("show");

      // 延时隐藏整个模态框，确保动画完成
      setTimeout(function() {
        modal.style.display = "none";
      }, 300);
    }


    // 弹出禁用账户
    function showSetStatusModal(userId) {
      var modal = document.getElementById("StatusModal");
      var modalContent = document.querySelector("#StatusModal .modal-content");
      modal.style.display = "block";

      // 添加显示动画
      setTimeout(function() {
        modalContent.classList.add("show");
      }, 10);

      // 关闭按钮事件
      var closeBtn = document.getElementsByClassName("close-Status")[0];
      closeBtn.onclick = function() {
        closeSetStatusModal();
      };

      // 确定按钮事件
      var approveStatusButton = document.getElementById("approve-Status-Button");
      approveStatusButton.onclick = function() {
        // 注销用户
        window.location.href = "/teamAdmin/UserManage/setStatusUser?userID=" + userId;
      };
    }

    // 关闭模态框的函数
    function closeSetStatusModal() {
      var modal = document.getElementById("StatusModal");
      var modalContent = document.querySelector("#StatusModal .modal-content");

      // 隐藏模态框的动画效果
      modalContent.classList.remove("show");

      // 延时隐藏整个模态框，确保动画完成
      setTimeout(function() {
        modal.style.display = "none";
      }, 300);
    }

    // 弹出通过重置模态框函数
    function showResetModal(userId) {
      var modal = document.getElementById("ResetModal");
      var modalContent = document.querySelector("#ResetModal .modal-content");
      modal.style.display = "block";

      // 添加显示动画
      setTimeout(function() {
        modalContent.classList.add("show");
      }, 10);

      // 关闭按钮事件
      var closeBtn = document.getElementsByClassName("close-reset")[0];
      closeBtn.onclick = function() {
        closeResetModal();
      };

      // 确定按钮事件
      var approveButton = document.getElementById("approveButton");
      approveButton.onclick = function() {
        // 重置密码
        window.location.href = "/teamAdmin/UserManage/ResetPassword?userID=" + userId;
      };
    }

    // 关闭模态框的函数
    function closeResetModal() {
      var modal = document.getElementById("ResetModal");
      var modalContent = document.querySelector("#ResetModal .modal-content");

      // 隐藏模态框的动画效果
      modalContent.classList.remove("show");

      // 延时隐藏整个模态框，确保动画完成
      setTimeout(function() {
        modal.style.display = "none";
      }, 300);
    }

  </script>

  <script>
    // 检查错误信息并弹出提示框
    window.onload = function() {
      var errorMessage = "${message}";
      if (errorMessage) {
        alert(errorMessage);
      }
    };
  </script>

</head>
<body>
<div class="container">
  <!-- Content -->
  <div class="content">
    <!-- Sidebar -->
    <jsp:include page="/TeamAdmin/sidebar.jsp"/>

    <div class="main">
      <h1>用户账号状态管理</h1>
      <!-- 定义类别列表 -->
      <!-- 搜索与筛选表单 -->
      <div class="search-filter">

        <label for="keyword">关键词：</label>
        <input type="text" id="keyword" placeholder="请输入用户名">

        <label for="category">状态：</label>
        <select id="category">
          <option value="">全部</option>
          <c:forEach var="cat" items="${categories}">
            <option value="${cat}">${cat}</option>
          </c:forEach>
        </select>


        <label for="startDate">注册日期：</label>
        <input type="date" id="startDate">

        <label for="endDate">到：</label>
        <input type="date" id="endDate">


        <button type="button" id="searchButton">搜索</button>
        <button type="button" id="resetButton">重置</button>
      </div>

      <div class="tabs">
        <a href="javascript:void(0)" id="teamMemberTab" class="active">团队成员用户</a>
        <a href="javascript:void(0)" id="visitorTab">普通用户</a>
        <a href="javascript:void(0)" id="applicationTab">申请注销的用户</a>
      </div>
          <!-- 团队成员用户 -->
          <div id="teamMemberSection" class="section active">
            <table class="user-table" data-roleType="teamMember">
              <thead>
              <tr>
                <th>
                  <input type="checkbox"id="selectAllteamMember"/>
                  全选
                </th>
                <th>用户名</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>注册时间</th>
                <th>账号状态</th>
                <th>联系方式</th>
                <th>操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${TeamMember}" var="user">
                <tr class="one-row"
                    data-username="${user.username}"
                    data-creationTime="${user.registrationTime}"
                >
                  <td>
                    <input type="checkbox"
                           class="teamMemberRow"
                           name="selectedRows"
                           value="${user.userID}">
                  </td>
                  <td>${user.username}</td>
                  <td>${user.name}</td>
                  <td>${user.email}</td>
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
                    <c:choose>
                      <c:when test="${empty user.contactInfo}">无</c:when>
                      <c:otherwise>${user.contactInfo}</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div>
                      <!-- 删除用户-->
                      <button class="btn-delete" type="button" onclick="confirmLogout(${user.userID})">删除</button>
                      <!--注销用户-->
                      <button class="btn-logout" type="button" onclick="confirmSetStatus(${user.userID})">注销</button>
                      <!-- 重置密码 -->
                      <button class="btn-preview" type="button" onclick="confirmReset(${user.userID})">重置密码</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
            <button type="button" id="BatchLogoutButton" class="btn btn-delete">批量删除</button>
            <button type="button" id="BatchStatusButton" class="btn btn-logout">批量注销</button>
            <button type="button" id="BatchResetButton" class="btn btn-pass">批量重置</button>
          </div>


          <!-- 普通用户 -->
          <div id="VisitorSection" class="section">
            <table class="user-table" data-roleType="Visitor">
              <thead>
              <tr>
                <th>
                  <input type="checkbox" id="selectAllVisitor"/>
                  全选
                </th>
                <th>用户名</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>注册时间</th>
                <th>账号状态</th>
                <th>联系方式</th>
                <th>操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${Visitor}" var="user">
                <tr class="one-row" data-username="${user.username}"
                    data-creationTime="${user.registrationTime}">
                  <td>
                    <input type="checkbox"
                           class="visitorRow"
                           name="selectedRows"
                           value="${user.userID}">
                  </td>
                    <%--                            <td>${user.userID}</td>--%>
                  <td>${user.username}</td>
                  <td>${user.name}</td>
                  <td>${user.email}</td>
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
                    <c:choose>
                      <c:when test="${empty user.contactInfo}">无</c:when>
                      <c:otherwise>${user.contactInfo}</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div>
                      <!-- 删除用户-->
                      <button class="btn-delete" type="button" onclick="confirmLogout(${user.userID})">删除</button>
                      <!--注销用户-->
                      <button class="btn-logout" type="button" onclick="confirmSetStatus(${user.userID})">注销</button>
                      <!-- 重置密码 -->
                      <button class="btn-preview" type="button" onclick="confirmReset(${user.userID})">重置密码</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
            <button type="button" id="VisitorBatchLogoutButton" class="btn btn-delete">批量删除</button>
            <button type="button" id="VisitorBatchStatusButton" class="btn btn-logout">批量注销</button>
            <button type="button" id="VisitorBatchResetButton" class="btn btn-pass">批量重置</button>
          </div>


          <!-- 申请注销用户 -->
          <div id="ApplicationSection" class="section">
            <table class="user-table" data-status="1">
              <thead>
              <tr>
                <th>
                  <input type="checkbox" id="selectAllApplication"/>
                  全选
                </th>
                <th>用户名</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>注册时间</th>
                <th>账号状态</th>
                <th>联系方式</th>
                <th>操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${ApplicationUser}" var="user">
                <tr class="one-row" data-username="${user.username}"
                    data-creationTime="${user.registrationTime}">
                  <td>
                    <input type="checkbox"
                           class="ApplicationRow"
                           name="selectedRows"
                           value="${user.userID}">
                  </td>
                  <td>${user.username}</td>
                  <td>${user.name}</td>
                  <td>${user.email}</td>
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
                    <c:choose>
                      <c:when test="${empty user.contactInfo}">无</c:when>
                      <c:otherwise>${user.contactInfo}</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div>
                      <!-- 删除用户 -->
                      <button class="btn-delete" type="button" onclick="confirmLogout(${user.userID})">删除</button>
                      <!--注销用户-->
                      <button class="btn-logout" type="button" onclick="confirmSetStatus(${user.userID})">注销</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>

            <button type="button" id="ApplicationBatchLogoutButton" class="btn btn-delete">批量删除</button>
            <button type="button" id="ApplicationBatchStatusButton" class="btn btn-logout">批量注销</button>
          </div>
    </div>
  </div>
</div>


<!-- 模态框 -->
<div id="LogoutModal" class="modal">
  <div class="modal-content">
    <span class="close-logout">&times;</span>
    <h3>删除用户</h3>
    <p>确定删除此账户吗？删除后该用户将永远无法登录。</p>
    <button id="approve-logout-Button" class="modal-button">确定</button>
  </div>
</div>

<div id="ResetModal" class="modal">
  <div class="modal-content">
    <span class="close-reset">&times;</span>
    <h3>重置用户密码</h3>
    <p>是否为用户生成新密码？系统将发送临时密码至注册邮箱。</p>
    <button id="approveButton" class="modal-button">确定</button>
  </div>
</div>

<div id="StatusModal" class="modal">
  <div class="modal-content">
    <span class="close-Status">&times;</span>
    <h3>注销用户</h3>
    <p>确定注销此账户吗？注销后该用户将无法登录。</p>
    <button id="approve-Status-button" class="modal-button">确定</button>
  </div>
</div>

<!-- 批量-->
<%--团队成员--%>
<div id="BatchLogoutModal" class="modal">
  <div class="modal-content">
    <span class="batch-close-logout">&times;</span>
    <h3>删除用户</h3>
    <p>确定删除选中的全部用户吗？删除后用户将永久无法登录。</p>
    <button id="batch-logout-Button" class="modal-button">确定</button>
  </div>
</div>
<div id="BatchStatusModal" class="modal">
  <div class="modal-content">
    <span class="batch-close-status">&times;</span>
    <h3>注销用户</h3>
    <p>确定注销选中的全部用户吗？注销后用户将无法登录。</p>
    <button id="batch-status-Button" class="modal-button">确定</button>
  </div>
</div>
<div id="BatchResetModal" class="modal">
  <div class="modal-content">
    <span class="batch-close-reset">&times;</span>
    <h3>重置用户密码</h3>
    <p>是否为选中的用户生成新密码？系统将发送临时密码至注册邮箱。</p>
    <button id="batch-reset-button" class="modal-button">确定</button>
  </div>
</div>




<%--普通用户--%>
<div id="VisitorBatchLogoutModal" class="modal">
  <div class="modal-content">
    <span class="Visitor-batch-close-logout">&times;</span>
    <h3>删除用户</h3>
    <p>确定删除选中的全部用户吗？删除后用户将永久无法登录。</p>
    <button id="Visitor-batch-logout-Button" class="modal-button">确定</button>
  </div>
</div>
<div id="VisitorBatchStatusModal" class="modal">
  <div class="modal-content">
    <span class="Visitor-batch-close-status">&times;</span>
    <h3>注销用户</h3>
    <p>确定注销选中的全部用户吗？注销后用户将无法登录。</p>
    <button id="Visitor-batch-status-Button" class="modal-button">确定</button>
  </div>
</div>
<div id="VisitorBatchResetModal" class="modal">
  <div class="modal-content">
    <span class="Visitor-batch-close-reset">&times;</span>
    <h3>重置用户密码</h3>
    <p>是否为选中的用户生成新密码？系统将发送临时密码至注册邮箱。</p>
    <button id="Visitor-batch-reset-button" class="modal-button">确定</button>
  </div>
</div>

<%--申请注销--%>
<div id="ApplicationBatchLogoutModal" class="modal">
  <div class="modal-content">
    <span class="Application-batch-close-logout">&times;</span>
    <h3>删除用户</h3>
    <p>确定删除选中的全部用户吗？删除后用户将永久无法登录。</p>
    <button id="Application-batch-logout-Button" class="modal-button">确定</button>
  </div>
</div>
<div id="ApplicationBatchStatusModal" class="modal">
  <div class="modal-content">
    <span class="Application-batch-close-status">&times;</span>
    <h3>注销用户</h3>
    <p>确定注销选中的全部用户吗？注销后用户将无法登录。</p>
    <button id="Application-batch-status-Button" class="modal-button">确定</button>
  </div>
</div>


      <!-- 引入外部JS文件，确保标签切换功能 -->
<script src="../js/usermanagement.js"></script>

</body>
</html>
