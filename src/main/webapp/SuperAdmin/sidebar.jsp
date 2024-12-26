<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<%-- 获取当前页面路径 --%>
<%
    String currentPage = request.getRequestURI();
%>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="/SuperController/UserManagement"
               class="<%= currentPage.contains("/SuperController/UserManagement") ? "active" : "" %>">用户管理</a></li>
        <li><a href="/SuperController/TeamAdministratorManagement"
               class="<%= currentPage.contains("/SuperController/TeamAdministratorManagement") ? "active" : "" %>">权限管理</a>
        </li>
        <li><a href="/SuperController/auditAchievements?type=0" id="researchAchievements"
               class="<%= currentPage.equals("/auditAchievements") && "0".equals(request.getParameter("type")) ? "active" : "" %>">科研成果审核</a>
        </li>
        <li><a href="/SuperController/auditAchievements?type=1" id="articleAudit"
               class="<%= currentPage.equals("/auditAchievements") && "1".equals(request.getParameter("type")) ? "active" : "" %>">文章审核</a>
        </li>
    </ul>
    <div class="logout">
        <a href="/user//backstageLogout">退出登录</a>
    </div>
</div>

<script>
    // 获取当前页面的 URL
    var currentPage = window.location.pathname;

    // 获取所有菜单链接
    var menuLinks = document.querySelectorAll('.sidebar ul li a');

    // 遍历所有菜单链接，检查是否匹配当前页面的 URL
    menuLinks.forEach(function (link) {
        // 如果链接的 href 匹配当前路径，就添加 active 类
        if (currentPage.includes(link.getAttribute('href'))) {
            link.classList.add('active'); // 如果匹配，添加 active 类
        }
    });

    // 获取当前页面的查询字符串
    var urlParams = new URLSearchParams(window.location.search);

    // 获取查询参数 'type' 的值
    var typeValue = urlParams.get("type");

    // 在控制台输出 'type' 参数的值
    console.log(typeValue);  // 例如，如果 URL 是 ?type=0，输出 0

    // 根据 type 值激活相应的菜单项
    if (typeValue === "0") {
        document.getElementById('researchAchievements').classList.add('active');
    } else if (typeValue === "1") {
        document.getElementById('articleAudit').classList.add('active');
    }
</script>
