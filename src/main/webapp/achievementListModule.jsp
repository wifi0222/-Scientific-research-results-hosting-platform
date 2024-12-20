<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <!-- 模块标题 -->
    <h3>${achievementTitle}</h3>

    <!-- 成果列表 -->
    <ul>
        <c:forEach var="achievement" items="${achievementList}">
            <li>
                <!-- 成果标题 -->
                标题：<c:out value="${achievement.title}"/>，
                <!-- 成果发布时间 -->
                时间：<c:out value="${achievement.creationTime}"/>
                <!-- 查看详情链接 -->
                <a href="/achievement/details?achievementID=${achievement.achievementID}">查看详情</a>
            </li>
        </c:forEach>
    </ul>

    <!-- 查看更多链接 -->
    <a href="/achievement/list?category=${achievementTitle}">查看更多</a>
</div>
