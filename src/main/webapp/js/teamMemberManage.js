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

        // 获取所有行
        const rows = document.querySelectorAll('.one-row');
        rows.forEach(function (row) {
            const name = row.getAttribute('data-name').toLowerCase();
            const creationTime = row.getAttribute('data-creationTime');
            const creationTimeObj = new Date(creationTime);

            // 关键词过滤
            let keywordMatch = true;
            if (keyword !== '') {
                keywordMatch = name.includes(keyword);
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
            if (keywordMatch && startDateMatch && endDateMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 重置筛选条件
    function resetFilters() {
        document.getElementById('keyword').value = '';
        document.getElementById('startDate').value = '';
        document.getElementById('endDate').value = '';

        // 显示所有
        const rows = document.querySelectorAll('.one-row');
        rows.forEach(function (row) {
            row.style.display = '';
        });
    }
});


