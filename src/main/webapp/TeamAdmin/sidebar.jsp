<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!-- Sidebar -->
<div class="sidebar">
    <ul>
        <li>
<%--            <a href="javascript:void(0);">团队管理</a>--%>
<%--            <ul class="submenu">--%>
                <li><a href="/teamAdmin/TeamManage/Info">团队基本信息维护</a></li>
                <li><a href="/teamAdmin/TeamManage/Member">管理团队成员信息</a></li>
                <li><a href="/teamAdmin/ToMemberInfoReview">团队成员信息审核</a></li>
<%--            </ul>--%>
        </li>
        <li>
            <a href="/teamAdmin/achievements?type=0">科研成果管理</a>
        </li>
        <li>
            <a href="/teamAdmin/achievements?type=1">文章管理</a>
        </li>
        <li>
<%--            <a href="javascript:void(0);">用户管理</a>--%>
<%--            <ul class="submenu">--%>
                <li><a href="/teamAdmin/ToUserRegisterManage">注册申请审核</a></li>
                <li><a href="/teamAdmin/ToUserManage">注销与重置用户密码</a></li>
<%--            </ul>--%>
        </li>
        <li>
            <a href="/questions/ans-all-questions">在线交流与反馈</a>
        </li>
    </ul>
    <div class="logout">
        <a href="/user/logout">退出登录</a>
    </div>
</div>
