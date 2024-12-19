<%--
  Created by IntelliJ IDEA.
  User: zwb
  Date: 2024/12/19
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>科研成果管理</title>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>科研成果管理</h1>

<%--<!-- 搜索与筛选功能 -->--%>
<%--<div>--%>
<%--    <label for="searchTitle">成果标题：</label>--%>
<%--    <input type="text" id="searchTitle" placeholder="输入标题关键词">--%>
<%--    <label for="filterCategory">类别：</label>--%>
<%--    <select id="filterCategory">--%>
<%--        <option value="">全部</option>--%>
<%--        <option value="专著">专著</option>--%>
<%--        <option value="专利">专利</option>--%>
<%--        <option value="软著">软著</option>--%>
<%--        <option value="产品">产品</option>--%>
<%--    </select>--%>
<%--    <label for="filterDate">发布日期：</label>--%>
<%--    <input type="date" id="filterDate">--%>
<%--    <button onclick="searchAchievements()">搜索</button>--%>
<%--</div>--%>

<%--<!-- 新增按钮 -->--%>
<%--<button onclick="showAddForm()">新增成果</button>--%>

<!-- 成果列表 -->
<table border="1">
    <thead>
    <tr>
        <th>成果ID</th>
        <th>标题</th>
        <th>类别</th>
        <th>摘要</th>
        <th>创建时间</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="achievement" items="${achievements}">
        <tr>
            <td>${achievement.achievementID}</td>
            <td>${achievement.title}</td>
            <td>${achievement.category}</td>
            <td>${achievement.abstractText}</td>
            <td>${achievement.creationTime}</td>
            <td>${achievement.viewStatus == 1 ? '公开' : '隐藏'}</td>
            <td>
                <button onclick="editAchievement(${achievement.achievementID})">编辑</button>
                <button onclick="deleteAchievement(${achievement.achievementID})">删除</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%--<!-- 成果编辑表单 -->--%>
<%--<div id="formContainer" style="display:none;">--%>
<%--    <h2 id="formTitle">新增成果</h2>--%>
<%--    <form id="achievementForm">--%>
<%--        <input type="hidden" id="achievementID">--%>
<%--        <label>标题：</label><input type="text" id="title"><br>--%>
<%--        <label>类别：</label>--%>
<%--        <select id="category">--%>
<%--            <option value="专著">专著</option>--%>
<%--            <option value="专利">专利</option>--%>
<%--            <option value="软著">软著</option>--%>
<%--            <option value="产品">产品</option>--%>
<%--        </select><br>--%>
<%--        <label>摘要：</label><textarea id="abstractText"></textarea><br>--%>
<%--        <label>详细描述：</label><div id="editor-container" style="height: 300px;"></div><br>--%>
<%--        <label>附件：</label><input type="file" id="attachment"><br>--%>
<%--        <label>展示图片：</label><input type="file" id="displayImage"><br>--%>
<%--        <label>发布日期：</label><input type="date" id="publishDate"><br>--%>
<%--        <button type="button" onclick="saveAchievement()">保存</button>--%>
<%--        <button type="button" onclick="hideForm()">取消</button>--%>
<%--    </form>--%>
<%--</div>--%>

<%--<script>--%>
<%--    // 初始化 Quill 富文本编辑器--%>
<%--    var quill = new Quill('#editor-container', {--%>
<%--        theme: 'snow',--%>
<%--        modules: {--%>
<%--            toolbar: [--%>
<%--                ['bold', 'italic', 'underline', 'strike'],--%>
<%--                ['blockquote', 'code-block'],--%>
<%--                [{ 'header': [1, 2, 3, false] }],--%>
<%--                [{ 'list': 'ordered' }, { 'list': 'bullet' }],--%>
<%--                ['link', 'image'],--%>
<%--                ['clean']--%>
<%--            ]--%>
<%--        }--%>
<%--    });--%>

<%--    // 动态加载成果数据--%>
<%--    function loadAchievements() {--%>
<%--        $.get('/achievement/getAll', function(data) {--%>
<%--            var rows = '';--%>
<%--            data.forEach(function(item) {--%>
<%--                rows += `--%>
<%--                        <tr>--%>
<%--                            <td>${item.achievementID}</td>--%>
<%--                            <td>${item.title}</td>--%>
<%--                            <td>${item.category}</td>--%>
<%--                            <td>${item.abstractText}</td>--%>
<%--                            <td>${item.creationTime}</td>--%>
<%--                            <td>${item.viewStatus == 1 ? '公开' : '隐藏'}</td>--%>
<%--                            <td>--%>
<%--                                <button onclick="editAchievement(${item.achievementID})">编辑</button>--%>
<%--                                <button onclick="deleteAchievement(${item.achievementID})">删除</button>--%>
<%--                                <button onclick="toggleVisibility(${item.achievementID}, ${item.viewStatus})">--%>
<%--                                    ${item.viewStatus == 1 ? '隐藏' : '公开'}--%>
<%--                                </button>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    `;--%>
<%--            });--%>
<%--            $('#achievementTable tbody').html(rows);--%>
<%--        });--%>
<%--    }--%>

<%--    // 显示新增成果表单--%>
<%--    function showAddForm() {--%>
<%--        $('#formTitle').text('新增成果');--%>
<%--        $('#achievementForm')[0].reset();--%>
<%--        quill.root.innerHTML = '';--%>
<%--        $('#formContainer').show();--%>
<%--    }--%>

<%--    // 隐藏表单--%>
<%--    function hideForm() {--%>
<%--        $('#formContainer').hide();--%>
<%--    }--%>

<%--    // 保存成果--%>
<%--    function saveAchievement() {--%>
<%--        var data = new FormData();--%>
<%--        data.append('achievementID', $('#achievementID').val());--%>
<%--        data.append('title', $('#title').val());--%>
<%--        data.append('category', $('#category').val());--%>
<%--        data.append('abstractText', $('#abstractText').val());--%>
<%--        data.append('detailedDescription', quill.root.innerHTML);--%>
<%--        data.append('attachment', $('#attachment')[0].files[0]);--%>
<%--        data.append('displayImage', $('#displayImage')[0].files[0]);--%>
<%--        data.append('publishDate', $('#publishDate').val());--%>

<%--        $.ajax({--%>
<%--            url: '/achievement/save',--%>
<%--            type: 'POST',--%>
<%--            data: data,--%>
<%--            processData: false,--%>
<%--            contentType: false,--%>
<%--            success: function() {--%>
<%--                alert('保存成功');--%>
<%--                loadAchievements();--%>
<%--                hideForm();--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    // 编辑成果--%>
<%--    function editAchievement(id) {--%>
<%--        $.get('/achievement/get/' + id, function(data) {--%>
<%--            $('#formTitle').text('编辑成果');--%>
<%--            $('#achievementID').val(data.achievementID);--%>
<%--            $('#title').val(data.title);--%>
<%--            $('#category').val(data.category);--%>
<%--            $('#abstractText').val(data.abstractText);--%>
<%--            quill.root.innerHTML = data.detailedDescription;--%>
<%--            $('#publishDate').val(data.creationTime);--%>
<%--            $('#formContainer').show();--%>
<%--        });--%>
<%--    }--%>

<%--    // 删除成果--%>
<%--    function deleteAchievement(id) {--%>
<%--        if (confirm('确定删除此成果吗？')) {--%>
<%--            $.ajax({--%>
<%--                url: '/achievement/delete/' + id,--%>
<%--                type: 'DELETE',--%>
<%--                success: function() {--%>
<%--                    alert('删除成功');--%>
<%--                    loadAchievements();--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    }--%>

<%--    // 切换成果可见性--%>
<%--    function toggleVisibility(id, currentStatus) {--%>
<%--        var newStatus = currentStatus == 1 ? 0 : 1;--%>
<%--        $.post('/achievement/toggleVisibility', { achievementID: id, viewStatus: newStatus }, function() {--%>
<%--            alert('操作成功');--%>
<%--            loadAchievements();--%>
<%--        });--%>
<%--    }--%>

<%--    // 搜索成果--%>
<%--    function searchAchievements() {--%>
<%--        var title = $('#searchTitle').val();--%>
<%--        var category = $('#filterCategory').val();--%>
<%--        var date = $('#filterDate').val();--%>

<%--        $.get('/achievement/search', { title: title, category: category, date: date }, function(data) {--%>
<%--            var rows = '';--%>
<%--            data.forEach(function(item) {--%>
<%--                rows += `--%>
<%--                        <tr>--%>
<%--                            <td>${item.achievementID}</td>--%>
<%--                            <td>${item.title}</td>--%>
<%--                            <td>${item.category}</td>--%>
<%--                            <td>${item.abstractText}</td>--%>
<%--                            <td>${item.creationTime}</td>--%>
<%--                            <td>${item.viewStatus == 1 ? '公开' : '隐藏'}</td>--%>
<%--                            <td>--%>
<%--                                <button onclick="editAchievement(${item.achievementID})">编辑</button>--%>
<%--                                <button onclick="deleteAchievement(${item.achievementID})">删除</button>--%>
<%--                                <button onclick="toggleVisibility(${item.achievementID}, ${item.viewStatus})">--%>
<%--                                    ${item.viewStatus == 1 ? '隐藏' : '公开'}--%>
<%--                                </button>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    `;--%>
<%--            });--%>
<%--            $('#achievementTable tbody').html(rows);--%>
<%--        });--%>
<%--    }--%>

<%--    // 页面加载完成后加载数据--%>
<%--    $(document).ready(function() {--%>
<%--        loadAchievements();--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>
