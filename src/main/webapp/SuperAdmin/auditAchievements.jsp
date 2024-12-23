<%--
  只显示正在审核的成果（status=0）
  File: auditAchievements.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>内容管理 - 审核科研成果</title>
    <!-- 引入外部CSS文件 -->
    <link rel="stylesheet" type="text/css" href="../css/auditAchievements.css">
</head>
<body>
<h1>内容管理 - 审核科研成果</h1>

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

<!-- 正在审核的成果（status=0） -->
<div id="reviewSection" class="section active">
    <h2></h2>
    <h3>${cat}</h3>
    <table class="achievement-table" data-status="0" data-category="${cat}">
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="selectAllCheckbox"/>
                全选
            </th>
            <th>ID</th>
            <th>标题</th>
            <th>类别</th>
            <th>摘要</th>
            <th>内容</th>
<%--            <th>附件</th>--%>
<%--            <th>展示图片</th>--%>
            <th>创建时间</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="entry" items="${auditAchievementMap}">
            <c:if test="${entry.key.status == 0}">
                <tr class="achievement-row"
                    data-title="${fn:escapeXml(entry.key.title)}"
                    data-category="${entry.key.category}"
                    data-creationTime="${entry.key.creationTime}"
                    data-status="${entry.key.status}">

                    <td>
                        <input type="checkbox"
                               class="rowCheckbox"
                               name="selectedRows"
                               value="${entry.key.achievementID}">
                    </td>
                    <td>${entry.key.achievementID}</td>
                    <td>${entry.key.title}</td>
                    <td>${entry.key.category}</td>
                    <td>${entry.key.abstractContent}</td>
                    <td>${entry.key.contents}</td>
<%--                    <td>--%>
<%--                        <c:forEach var="file" items="${entry.value}">--%>
<%--                            <c:if test="${file.type == 0}">--%>
<%--                                <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        <c:forEach var="file" items="${entry.value}">--%>
<%--                            <c:if test="${file.type == 1}">--%>
<%--                                <c:set var="encodedPath"--%>
<%--                                       value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>--%>
<%--                                <img src="<c:url value='/getImage?filePath=${encodedPath}' />"--%>
<%--                                     alt="展示图片" width="100"/>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                    </td>--%>
                    <td>
                        <fmt:formatDate value='${entry.key.creationTime}' pattern='yyyy-MM-dd HH:mm'/>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${entry.key.status == -1}">不通过</c:when>
                            <c:when test="${entry.key.status == 0}">正在审核</c:when>
                            <c:otherwise>未知</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <button class="btn-preview" onclick="previewAchievement(${entry.key.achievementID})">预览</button>
                        <button class="btn-pass" onclick="passAchievementReview(${entry.key.achievementID})">通过</button>
                        <button class="btn-reject" onclick="rejectAchievementReview(${entry.key.achievementID})">拒绝</button>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>

    <div style="margin-top: 10px;">
        <button type="button" id="batchPassButton">通过</button>
    </div>

</div>

<!-- 引入外部JS文件 -->
<script src="../js/auditAchievements.js"></script>
</body>
</html>
