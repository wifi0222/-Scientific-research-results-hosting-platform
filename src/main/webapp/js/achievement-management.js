// achievement-management.js

document.addEventListener('DOMContentLoaded', function () {
    const publishedTab = document.getElementById('publishedTab');
    const reviewTab = document.getElementById('reviewTab');
    const publishedSection = document.getElementById('publishedSection');
    const reviewSection = document.getElementById('reviewSection');

    function showPublished() {
        publishedSection.classList.add('active');
        reviewSection.classList.remove('active');
        publishedTab.classList.add('active');
        reviewTab.classList.remove('active');
    }

    function showReview() {
        reviewSection.classList.add('active');
        publishedSection.classList.remove('active');
        reviewTab.classList.add('active');
        publishedTab.classList.remove('active');
    }

    publishedTab.addEventListener('click', showPublished);
    reviewTab.addEventListener('click', showReview);

    // 默认显示已发布的成果
    showPublished();
});

function editAchievement(id) {
    // 获取项目的上下文路径
    var contextPath = '${pageContext.request.contextPath}';

    // 构建编辑页面的URL
    var editUrl = '/teamAdmin/editAchievement?id=' + id;

    // 跳转到编辑页面
    window.location.href = editUrl;
}

function deleteAchievement(id) {
    // 此处加入删除逻辑
}
