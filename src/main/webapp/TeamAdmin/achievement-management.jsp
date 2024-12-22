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
    <link rel="stylesheet" type="text/css" href="../css/achievement-management.css">
</head>
<body>
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
    <a href="${pageContext.request.contextPath}/TeamAdmin/addAchievement.jsp" style="margin-left:20px;">新增成果</a>
</div>

<!-- 已发布的成果（status=1） -->
<div id="publishedSection" class="section active">
    <h2>已发布的成果 (status = 1)</h2>
    <c:forEach var="cat" items="${categories}">
        <h3>${cat}</h3>
        <table class="achievement-table" data-status="1" data-category="${cat}">
            <thead>
            <tr>
                <th>成果ID</th>
                <th>标题</th>
                <th>类别</th>
                <th>摘要</th>
                <th>内容</th>
                <th>附件</th>
                <th>展示图片</th>
                <th>创建时间</th>
                <th>公开/隐藏</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${achievementMap}">
                <c:if test="${entry.key.status == 1 and entry.key.category eq cat}">
                    <tr class="achievement-row"
                        data-title="${fn:escapeXml(entry.key.title)}"
                        data-category="${entry.key.category}"
                        data-creationTime="${entry.key.creationTime}"
                        data-status="${entry.key.status}">

                        <td>${entry.key.achievementID}</td>
                        <td>${entry.key.title}</td>
                        <td>${entry.key.category}</td>
                        <td>${entry.key.abstractContent}</td>
                        <td>${entry.key.contents}</td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 0}">
                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 1}">
                                    <%--<img src="/${file.filePath}" alt="展示图片" width="100"><br/>--%>
                                    <%--<a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>--%>
                                    <%--'\\\\'：在 JSP 中被解析成一个实际的 '\\'，再被 EL 解析时代表一个反斜杠。--%>
                                    <%--先用 \\ 替换反斜杠，再用 %20 替换空格--%>
                                    <c:set var="encodedPath"
                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                                         width="100"/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td><fmt:formatDate value='${entry.key.creationTime}' pattern='yyyy-MM-dd HH:mm'/></td>
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
                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除</button>
                            <button onclick="switchViewStatus(${entry.key.achievementID})">公开/隐藏</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>

<!-- 正在审核的成果（status=0） -->
<div id="reviewSection" class="section">
    <h2>正在审核的成果 (status = 0)</h2>
    <c:forEach var="cat" items="${categories}">
        <h3>${cat}</h3>
        <table class="achievement-table" data-status="0" data-category="${cat}">
            <thead>
            <tr>
                <th>成果ID</th>
                <th>标题</th>
                <th>类别</th>
                <th>摘要</th>
                <th>内容</th>
                <th>附件</th>
                <th>展示图片</th>
                <th>创建时间</th>
                <th>审核状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${achievementMap}">
                <c:if test="${entry.key.status == 0 and entry.key.category eq cat}">
                    <tr class="achievement-row"
                        data-title="${fn:escapeXml(entry.key.title)}"
                        data-category="${entry.key.category}"
                        data-creationTime="${entry.key.creationTime}"
                        data-status="${entry.key.status}">

                        <td>${entry.key.achievementID}</td>
                        <td>${entry.key.title}</td>
                        <td>${entry.key.category}</td>
                        <td>${entry.key.abstractContent}</td>
                        <td>${entry.key.contents}</td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 0}">
                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 1}">
                                    <c:set var="encodedPath"
                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />" alt="展示图片"
                                         width="100"/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td><fmt:formatDate value='${entry.key.creationTime}' pattern='yyyy-MM-dd HH:mm'/></td>
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
                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>

<!-- 审核被拒绝的成果（status=-1） -->
<div id="rejectedSection" class="section">
    <h2>审核被拒绝的成果 (status = -1)</h2>
    <c:forEach var="cat" items="${categories}">
        <h3>${cat}</h3>
        <table class="achievement-table" data-status="-1" data-category="${cat}">
            <thead>
            <tr>
                <th>成果ID</th>
                <th>标题</th>
                <th>类别</th>
                <th>摘要</th>
                <th>内容</th>
                <th>附件</th>
                <th>展示图片</th>
                <th>创建时间</th>
                <th>审核状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${achievementMap}">
                <c:if test="${entry.key.status == -1 and entry.key.category eq cat}">
                    <tr class="achievement-row"
                        data-title="${fn:escapeXml(entry.key.title)}"
                        data-category="${entry.key.category}"
                        data-creationTime="${entry.key.creationTime}"
                        data-status="${entry.key.status}">

                        <td>${entry.key.achievementID}</td>
                        <td>${entry.key.title}</td>
                        <td>${entry.key.category}</td>
                        <td>${entry.key.abstractContent}</td>
                        <td>${entry.key.contents}</td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 0}">
                                    <a href="/${file.filePath}" target="_blank">${file.fileName}</a><br/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="file" items="${entry.value}">
                                <c:if test="${file.type == 1}">
                                    <c:set var="encodedPath"
                                           value="${fn:replace(fn:replace(file.filePath, '\\\\', '/'), ' ', '%20')}"/>
                                    <img src="<c:url value='/getImage?filePath=${encodedPath}' />"
                                         alt="展示图片" width="100"/>
                                </c:if>
                            </c:forEach>
                        </td>
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
                            <button onclick="editAchievement(${entry.key.achievementID})">编辑</button>
                            <button onclick="deleteAchievement(${entry.key.achievementID})">删除</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</div>


<!-- 引入外部JS文件，确保标签切换功能 -->
<script src="../js/achievement-management.js"></script>

</body>
</html>
