// achievement-management.js

document.addEventListener('DOMContentLoaded', function () {
    const publishedTab = document.getElementById('publishedTab');
    const reviewTab = document.getElementById('reviewTab');
    const rejectedTab = document.getElementById('rejectedTab'); // 新增
    const publishedSection = document.getElementById('publishedSection');
    const reviewSection = document.getElementById('reviewSection');
    const rejectedSection = document.getElementById('rejectedSection'); // 新增
    const searchButton = document.getElementById('searchButton');
    const resetButton = document.getElementById('resetButton');

    // 显示已发布成果
    function showPublished() {
        publishedSection.classList.add('active');
        reviewSection.classList.remove('active');
        rejectedSection.classList.remove('active'); // 新增
        publishedTab.classList.add('active');
        reviewTab.classList.remove('active');
        rejectedTab.classList.remove('active'); // 新增
    }

    // 显示正在审核成果
    function showReview() {
        reviewSection.classList.add('active');
        publishedSection.classList.remove('active');
        rejectedSection.classList.remove('active'); // 新增
        reviewTab.classList.add('active');
        publishedTab.classList.remove('active');
        rejectedTab.classList.remove('active'); // 新增
    }

    // 显示审核被拒绝成果
    function showRejected() {
        rejectedSection.classList.add('active');
        publishedSection.classList.remove('active');
        reviewSection.classList.remove('active');
        rejectedTab.classList.add('active');
        publishedTab.classList.remove('active');
        reviewTab.classList.remove('active');
    }

    // 给每个 tab 绑定事件
    publishedTab.addEventListener('click', showPublished);
    reviewTab.addEventListener('click', showReview);
    rejectedTab.addEventListener('click', showRejected); // 新增

    // 默认显示已发布的成果
    showPublished();

    // 搜索按钮点击事件
    searchButton.addEventListener('click', function () {
        applyFilters();
    });

    // 重置按钮点击事件
    resetButton.addEventListener('click', function () {
        resetFilters();
    });

    // 应用筛选条件
    function applyFilters() {
        const keyword = document.getElementById('keyword').value.trim().toLowerCase();
        const category = document.getElementById('category').value;
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        let startDateObj = null;
        if (startDate) {
            startDateObj = new Date(startDate);
            startDateObj.setHours(0, 0, 0, 0);
        }

        let endDateObj = null;
        if (endDate) {
            endDateObj = new Date(endDate);
            endDateObj.setHours(23, 59, 59, 999);
        }

        // 获取所有成果行
        const rows = document.querySelectorAll('.achievement-row');
        rows.forEach(function (row) {
            const title = row.getAttribute('data-title').toLowerCase();
            const rowCategory = row.getAttribute('data-category');
            const creationTime = row.getAttribute('data-creationTime');
            const creationTimeObj = new Date(creationTime);

            // 关键词过滤
            let keywordMatch = !keyword || title.includes(keyword);

            // 类别过滤
            let categoryMatch = !category || (rowCategory === category);

            // 时间过滤
            let startDateMatch = !startDate || (creationTimeObj >= startDateObj);
            let endDateMatch = !endDate || (creationTimeObj <= endDateObj);

            // 合并判断
            if (keywordMatch && categoryMatch && startDateMatch && endDateMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 重置筛选条件
    function resetFilters() {
        document.getElementById('keyword').value = '';
        document.getElementById('category').selectedIndex = 0;
        document.getElementById('startDate').value = '';
        document.getElementById('endDate').value = '';

        // 显示所有成果
        const rows = document.querySelectorAll('.achievement-row');
        rows.forEach(function (row) {
            row.style.display = '';
        });
    }
});

function editAchievement(id) {
    // 获取项目的上下文路径
    var contextPath = '${pageContext.request.contextPath}';

    // 构建编辑页面的URL
    var editUrl = '/teamAdmin/achievements/edit?id=' + id;

    // 跳转到编辑页面
    window.location.href = editUrl;
}

function deleteAchievement(id) {
    // 此处加入删除逻辑

    // 1. 二次确认
    if (!confirm('确定删除此成果吗？此操作无法恢复')) {
        return;
    }

    // 获取项目的上下文路径
    var contextPath = '${pageContext.request.contextPath}';

    // 构建编辑页面的URL
    var editUrl = '/teamAdmin/achievements/delete?id=' + id;

    // 跳转到编辑页面
    window.location.href = editUrl;
}

// 切换审核状态
function switchViewStatus(id) {
    // 此处加入删除逻辑

    // 获取项目的上下文路径
    var contextPath = '${pageContext.request.contextPath}';

    // 构建编辑页面的URL
    var editUrl = '/teamAdmin/achievements/switchViewStatus?id=' + id;

    // 跳转到编辑页面
    window.location.href = editUrl;
}
