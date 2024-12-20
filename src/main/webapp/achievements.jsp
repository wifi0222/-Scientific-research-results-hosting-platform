<%--
  Created by IntelliJ IDEA.
  User: 王斐
  Date: 2024/12/20
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>成果展示</title>
</head>
<body>

<h2>${categoryname}成果</h2> <!-- 显示当前分类名称 -->

<!-- 筛选表单 -->
<form action="/achievements/${category}" method="get">
  <label for="year">选择年份：</label>
  <select name="year" id="year">
    <option value="">请选择年份</option>
    <c:forEach var="year" items="${years}">
      <option value="${year}" ${year == param.year ? 'selected' : ''}>${year}</option>
    </c:forEach>
  </select>

  <label for="sortOrder">排序：</label>
  <select name="sortOrder" id="sortOrder">
    <option value="asc" ${'asc' == param.sortOrder ? 'selected' : ''}>升序</option>
    <option value="desc" ${'desc' == param.sortOrder ? 'selected' : ''}>降序</option>
  </select>

  <button type="submit">筛选</button>
</form>

<ul>
  <!-- 检查列表是否为空 -->
  <c:if test="${empty achievements}">
    <p>暂无成果展示</p>
  </c:if>

  <!-- 如果列表不为空，显示每一项成果 -->
  <c:if test="${not empty achievements}">
    <ul>
      <c:forEach var="achievement" items="${achievements}">
        <li>
          <!-- 构造链接，点击后跳转到成果详情 -->
          <a href="/achievement/details?achievementID=${achievement.achievementID}">
            <strong>${achievement.title}</strong>
          </a>
            ${achievement.creationTime}
        </li>
      </c:forEach>
    </ul>
  </c:if>
</ul>

<!-- 返回主页或其他分类的链接 -->
<p><a href="/browse">返回主页</a></p>

</body>
</html>
