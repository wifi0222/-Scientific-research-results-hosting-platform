<%--
  Created by IntelliJ IDEA.
  User: zwb
  Date: 2024/12/19
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>科研成果管理</title>
    <!-- 引入外部CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">
</head>
<body>
<div class="container">
    <!-- Content -->
    <div class="content">
        <!-- Sidebar -->
        <div class="sidebar">
            <c:choose>
                <c:when test="${userRoleType == 'TeamAdmin'}">
                    <ul>
                        <li>
                            <a href="javascript:void(0);">团队管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                                <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                                <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="/teamAdmin/achievements?type=0">科研成果管理与发布</a>
                        </li>
                        <li>
                            <a href="/teamAdmin/achievements?type=1">文章管理</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">用户管理</a>
                            <ul class="submenu">
                                <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                                <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:void(0);">在线交流与反馈</a>
                            <ul class="submenu">
                                <li><a href="/feedback/submenu1">子菜单项1</a></li>
                                <li><a href="/feedback/submenu2">子菜单项2</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:when test="${userRoleType == 'SuperAdmin'}">
                    <ul>
                        <li><a href="/SuperController/UserManagement" class="active">用户管理</a></li>
                        <li><a href="/SuperController/TeamAdministratorManagement">权限管理</a></li>
                        <li><a href="/user/checkReply">内容审核</a></li>
                    </ul>
                    <div class="logout">
                        <a href="/user/logout">退出登录</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul>
                        <li><a href="/login.jsp">登录</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="content">
            <div class="main">
                <div class="section-wide">
                    <h1>科研成果管理</h1>

                    <!-- 定义类别列表 -->
                    <c:set var="categories" value="${fn:split('专著,专利,软著,产品', ',')}"/>

                    <!-- 搜索与筛选表单 -->
                    <div class="search-filter">
                        <label for="keyword">关键词：</label>
                        <input type="text" id="keyword" placeholder="请输入成果标题关键词">

                        <label for="category">类别：</label>
                        <select id="category">
                            <option value="">全部</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat}">${cat}</option>
                            </c:forEach>
                        </select>

                        <label for="startDate">发布日期从：</label>
                        <input type="date" id="startDate">

                        <label for="endDate">到：</label>
                        <input type="date" id="endDate">

                        <button type="button" id="searchButton">搜索</button>
                        <button type="button" id="resetButton">重置</button>
                    </div>

                    <div class="tabs">
                        <a href="javascript:void(0)" id="publishedTab" class="active">已发布的成果</a>
                        <a href="javascript:void(0)" id="reviewTab">正在审核的成果</a>
                        <a href="javascript:void(0)" id="rejectedTab">审核被拒绝的成果</a>
                        <a href="${pageContext.request.contextPath}/TeamAdmin/addAchievement.jsp"
                           style="margin-left:20px;">新增成果</a>
                    </div>

                    <!-- 已发布的成果（status=1） -->
                    <div id="publishedSection" class="section active">
                        <%--    <h2>已发布的成果 (status = 1)</h2>--%>
                        <%--    <c:forEach var="cat" items="${categories}">--%>
                        <h3>${cat}</h3>
                        <table class="achievement-table" data-status="1" data-category="${cat}">
                            <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="selectAllPublished"/>
                                    全选
                                </th>
                                <th>ID</th>
                                <th>标题</th>
                                <th>类别</th>
                                <th>摘要</th>
                                <th>内容</th>
                                <%--                <th>附件</th>--%>
                                <%--                <th>展示图片</th>--%>
                                <th>创建时间</th>
                                <th>公开/隐藏</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="entry" items="${achievementMap}">
                                <c:if test="${entry.key.status == 1}">
                                    <%--                <c:if test="${entry.key.status == 1 and entry.key.category eq cat}">--%>
                                    <tr class="achievement-row"
                                        data-title="${fn:escapeXml(entry.key.title)}"
                                        data-category="${entry.key.category}"
                                        data-creationTime="${entry.key.creationTime}"
                                        data-status="${entry.key.status}">

                                        <td>
                                            <input type="checkbox" class="rowCheckboxPublished"
                                                   value="${entry.key.achievementID}"/>
                                        </td>
                                        <td>${entry.key.achievementID}</td>
                                        <td>${entry.key.title}</td>
                                        <td>${entry.key.category}</td>
                                        <td>${entry.key.abstractContent}</td>
                                        <td>${entry.key.contents}</td>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 0}">--%>
                                            <%--                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 1}">--%>
                                            <%--                                    &lt;%&ndash;<img src="/${file.filePath}" alt="展示图片" width="100"><br/>&ndash;%&gt;--%>
                                            <%--                                    &lt;%&ndash;<a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>&ndash;%&gt;--%>
                                            <%--                                    &lt;%&ndash;'\\\\'：在 JSP 中被解析成一个实际的 '\\'，再被 EL 解析时代表一个反斜杠。&ndash;%&gt;--%>
                                            <%--                                    &lt;%&ndash;先用 \\ 替换反斜杠，再用 %20 替换空格&ndash;%&gt;--%>
                                            <%--                                    <c:set var="encodedPath"--%>
                                            <%--                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>--%>
                                            <%--                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"--%>
                                            <%--                                         width="100"/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                        <td><fmt:formatDate value='${entry.key.creationTime}'
                                                            pattern='yyyy-MM-dd HH:mm'/></td>
                                        <td>
                                                <%-- <c:choose>里面不能加注释--%>
                                            <c:choose>
                                                <c:when test="${entry.key.viewStatus == 1}">公开</c:when>
                                                <c:when test="${entry.key.viewStatus == 0}">隐藏</c:when>
                                                <c:otherwise>未知</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button onclick="editAchievement(${entry.key.achievementID})">编辑</button>
                                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除
                                            </button>
                                            <button onclick="switchViewStatus(${entry.key.achievementID})">公开/隐藏
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div style="margin-top:10px;">
                            <button id="batchDeletePublished">批量删除</button>
                            <button id="batchPublicPublished">批量公开</button>
                            <button id="batchHidePublished">批量隐藏</button>
                        </div>
                        <%--    </c:forEach>--%>
                    </div>

                    <!-- 正在审核的成果（status=0） -->
                    <div id="reviewSection" class="section">
                        <%--    <h2>正在审核的成果 (status = 0)</h2>--%>
                        <h3>${cat}</h3>
                        <table class="achievement-table" data-status="0" data-category="${cat}">
                            <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="selectAllReview"/>
                                    全选
                                </th>
                                <th>ID</th>
                                <th>标题</th>
                                <th>类别</th>
                                <th>摘要</th>
                                <th>内容</th>
                                <%--                <th>附件</th>--%>
                                <%--                <th>展示图片</th>--%>
                                <th>创建时间</th>
                                <th>审核状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="entry" items="${achievementMap}">
                                <c:if test="${entry.key.status == 0}">
                                    <tr class="achievement-row"
                                        data-title="${fn:escapeXml(entry.key.title)}"
                                        data-category="${entry.key.category}"
                                        data-creationTime="${entry.key.creationTime}"
                                        data-status="${entry.key.status}">

                                        <td>
                                            <input type="checkbox" class="rowCheckboxReview"
                                                   value="${entry.key.achievementID}"/>
                                        </td>
                                        <td>${entry.key.achievementID}</td>
                                        <td>${entry.key.title}</td>
                                        <td>${entry.key.category}</td>
                                        <td>${entry.key.abstractContent}</td>
                                        <td>${entry.key.contents}</td>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 0}">--%>
                                            <%--                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 1}">--%>
                                            <%--                                    <c:set var="encodedPath"--%>
                                            <%--                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>--%>
                                            <%--                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"--%>
                                            <%--                                         width="100"/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                        <td><fmt:formatDate value='${entry.key.creationTime}'
                                                            pattern='yyyy-MM-dd HH:mm'/></td>
                                        <td>
                                                <%-- <c:choose>里面不能加注释--%>
                                            <c:choose>
                                                <c:when test="${entry.key.status == -1}">不通过</c:when>
                                                <c:when test="${entry.key.status == 0}">正在审核</c:when>
                                                <c:otherwise>未知</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button onclick="editAchievement(${entry.key.achievementID})">编辑</button>
                                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div style="margin-top:10px;">
                            <button id="batchDeleteReview">批量删除</button>
                        </div>
                    </div>

                    <!-- 审核被拒绝的成果（status=-1） -->
                    <div id="rejectedSection" class="section">
                        <%--    <h2>审核被拒绝的成果 (status = -1)</h2>--%>
                        <h3>${cat}</h3>
                        <table class="achievement-table" data-status="-1" data-category="${cat}">
                            <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="selectAllRejected"/>
                                    全选
                                </th>
                                <th>ID</th>
                                <th>标题</th>
                                <th>类别</th>
                                <th>摘要</th>
                                <th>内容</th>
                                <%--                <th>附件</th>--%>
                                <%--                <th>展示图片</th>--%>
                                <th>创建时间</th>
                                <th>审核状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="entry" items="${achievementMap}">
                                <c:if test="${entry.key.status == -1}">
                                    <tr class="achievement-row"
                                        data-title="${fn:escapeXml(entry.key.title)}"
                                        data-category="${entry.key.category}"
                                        data-creationTime="${entry.key.creationTime}"
                                        data-status="${entry.key.status}">

                                        <td>
                                            <input type="checkbox" class="rowCheckboxRejected"
                                                   value="${entry.key.achievementID}"/>
                                        </td>
                                        <td>${entry.key.achievementID}</td>
                                        <td>${entry.key.title}</td>
                                        <td>${entry.key.category}</td>
                                        <td>${entry.key.abstractContent}</td>
                                        <td>${entry.key.contents}</td>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 0}">--%>
                                            <%--                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                            <%--                        <td>--%>
                                            <%--                            <c:forEach var="file" items="${entry.value}">--%>
                                            <%--                                <c:if test="${file.type == 1}">--%>
                                            <%--                                    <c:set var="encodedPath"--%>
                                            <%--                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>--%>
                                            <%--                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />"--%>
                                            <%--                                         alt="展示图片" width="100"/>--%>
                                            <%--                                </c:if>--%>
                                            <%--                            </c:forEach>--%>
                                            <%--                        </td>--%>
                                        <td>
                                            <fmt:formatDate value='${entry.key.creationTime}'
                                                            pattern='yyyy-MM-dd HH:mm'/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${entry.key.status == -1}">不通过</c:when>
                                                <c:when test="${entry.key.status == 0}">正在审核</c:when>
                                                <c:otherwise>未知</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button onclick="editAchievement(${entry.key.achievementID})">编辑</button>
                                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除
                                            </button>
                                            <!-- 触发按钮，点击后打开模态框并传入拒绝理由 -->
                                            <button onclick="showReasonModal('${entry.key.refusalReason}')">拒绝理由
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div style="margin-top:10px;">
                            <button id="batchDeleteRejected">批量删除</button>
                        </div>
                    </div>

                    <!-- 模态框 -->
                    <div id="reasonModal" class="modal" style="display: none;">
                        <div class="modal-content">
                            <span id="closeReasonModal" class="close">&times;</span>
                            <h2>拒绝理由</h2>
                            <!-- 这个地方用于显示拒绝理由 -->
                            <p id="reasonText"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 引入外部JS文件，确保标签切换功能 -->
<script src="../js/achievement-management.js"></script>

<script>
    // 获取所有的a标签
    const menuLinks = document.querySelectorAll('ul > li > a');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // 如果是子菜单的链接，不阻止跳转
            if (this.nextElementSibling && this.nextElementSibling.classList.contains('submenu')) {
                // 这是父菜单，阻止跳转
                event.preventDefault(); // 阻止父菜单的默认跳转行为
                // 切换当前a标签的class
                this.classList.toggle('active');

                // 获取当前点击项的下一个子菜单
                const submenu = this.nextElementSibling;

                if (submenu && submenu.classList.contains('submenu')) {
                    // 切换子菜单的显示状态
                    submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
                }
            }
            // 对于子菜单项，允许跳转，不做任何处理
        });
    });
</script>

</body>
</html>
