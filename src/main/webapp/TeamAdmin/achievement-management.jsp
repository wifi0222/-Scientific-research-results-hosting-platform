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
    <link rel="stylesheet" type="text/css" href="../css/zwb_sidebar.css">
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">
</head>
<body>
<div class="container">
    <!-- Content -->
    <div class="content">
        <!-- Sidebar -->
        <jsp:include page="/TeamAdmin/sidebar.jsp"/>

        <div class="main">

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
                <a href="javascript:void(0)" id="publishedTab" class="active">已发布</a>
                <a href="javascript:void(0)" id="reviewTab">待审核</a>
                <a href="javascript:void(0)" id="rejectedTab">审核被拒绝</a>
                <a href="${pageContext.request.contextPath}/TeamAdmin/addAchievement.jsp"
                   style="
                       display: inline-block;
                       padding: 8px 12px;
                       background-color: #4e73df;
                       color: #ffffff;
                       border: none;
                       border-radius: 5px;
                       text-align: center;
                       text-decoration: none;
                       font-size: 14px;
                       cursor: pointer;
                       margin-left: 20px;
                       transition: background-color 0.3s ease;"
                   onmouseover="this.style.backgroundColor='#0056b3'"
                   onmouseout="this.style.backgroundColor='#4e73df'">
                    新增成果
                </a>
            </div>

            <!-- 已发布的成果（status=1） -->
            <div id="publishedSection" class="section active">
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
                    <button id="batchPublicPublished">批量公开</button>
                    <button id="batchDeletePublished">批量删除</button>
                    <button id="batchHidePublished">批量隐藏</button>
                </div>
                <%--    </c:forEach>--%>
            </div>

            <!-- 待审核的成果（status=0） -->
            <div id="reviewSection" class="section">
                <%--    <h2>待审核的成果 (status = 0)</h2>--%>
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
                        <%--                        <th>摘要</th>--%>
                        <%--                        <th>内容</th>--%>
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
                                    <%--                                <td>${entry.key.abstractContent}</td>--%>
                                    <%--                                <td>${entry.key.contents}</td>--%>
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
                                        <c:when test="${entry.key.status == 0}">待审核</c:when>
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
                    <button id="batchDeleteReview" style="background-color: #dc3545;">批量删除</button>
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
                        <%--                        <th>摘要</th>--%>
                        <%--                        <th>内容</th>--%>
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
                                <td>
                                    <fmt:formatDate value='${entry.key.creationTime}'
                                                    pattern='yyyy-MM-dd HH:mm'/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${entry.key.status == -1}">不通过</c:when>
                                        <c:when test="${entry.key.status == 0}">待审核</c:when>
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
                    <button id="batchDeleteRejected" style="background-color: #dc3545;">批量删除</button>
                </div>
            </div>

            <!-- 模态框 -->
            <div id="reasonModal" class="modal" style="display: none;">
                <div class="modal-content" style="position: relative;"> <!-- 父容器设置为相对定位 -->
                    <!-- 修改关闭按钮的样式 -->
                    <span id="closeReasonModal" class="close"
                          style="position: absolute; top: 10px; right: 20px; font-size: 30px; cursor: pointer;">&times;</span>
                    <h2>拒绝理由</h2>
                    <!-- 这个地方用于显示拒绝理由 -->
                    <p id="reasonText"></p>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- 引入外部JS文件，确保标签切换功能 -->
<script src="../js/achievement-management.js"></script>

<script>
    // 获取当前页面的查询字符串
    var urlParams = new URLSearchParams(window.location.search);

    // 获取查询参数 'type' 的值
    var typeValue = urlParams.get("type");

    // 在控制台输出 'type' 参数的值
    console.log(typeValue);  // 例如，如果 URL 是 ?type=0，输出 0
</script>


</body>
</html>
