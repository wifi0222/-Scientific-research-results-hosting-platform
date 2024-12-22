document.addEventListener('DOMContentLoaded', function () {
    const searchButton = document.getElementById('searchButton');
    const resetButton = document.getElementById('resetButton');

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
            let keywordMatch = true;
            if (keyword !== '') {
                keywordMatch = title.includes(keyword);
            }

            // 类别过滤
            let categoryMatch = true;
            if (category !== '') {
                categoryMatch = (rowCategory === category);
            }

            // 开始日期过滤
            let startDateMatch = true;
            if (startDate !== '') {
                startDateMatch = (creationTimeObj >= startDateObj);
            }

            // 结束日期过滤
            let endDateMatch = true;
            if (endDate !== '') {
                endDateMatch = (creationTimeObj <= endDateObj);
            }

            // 综合判断
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

function passAchievementReview(id) {
    if (!confirm('确定通过审核吗？')) {
        return;
    }

    var passUrl = '/SuperController/auditAchievements/pass?id=' + id;

    window.location.href = passUrl;
}

/**
 * 拒绝审核
 * @param {number} id - 成果ID
 */
function rejectAchievementReview(id) {
    if (!confirm('确定拒绝此成果吗？')) {
        return;
    }
    var passUrl = '/SuperController/auditAchievements/reject?id=' + id;

    window.location.href = passUrl;
}
