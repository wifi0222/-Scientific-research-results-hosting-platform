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

// 通过审核
function passAchievementReview(id) {
    if (!confirm('确定通过审核吗？')) {
        return;
    }

    var passUrl = '/SuperController/auditAchievements/pass?id=' + id + "&type=0";

    window.location.href = passUrl;
}

// 拒绝审核
function rejectAchievementReview(id) {
    // 获取模态框元素
    const modal = document.getElementById('rejectModal');
    const closeModal = document.getElementById('closeModal');
    const cancelReject = document.getElementById('cancelReject');
    const confirmReject = document.getElementById('confirmReject');
    const refusalReasonInput = document.getElementById('refusalReason');

    // 显示模态框
    modal.style.display = 'block';

    // 关闭模态框的事件
    closeModal.onclick = function () {
        modal.style.display = 'none';
        refusalReasonInput.value = '';
    }

    cancelReject.onclick = function () {
        modal.style.display = 'none';
        refusalReasonInput.value = '';
    }

    // 点击「确定」时执行逻辑
    confirmReject.onclick = function () {
        const reason = refusalReasonInput.value.trim();
        if (reason === '') {
            alert('拒绝理由不能为空。');
            return;
        }

        // 1. 将 ID 和拒绝理由 设置到隐藏表单中
        document.getElementById('achievementId').value = id;
        document.getElementById('refusalReasonField').value = reason;

        // 2. 提交表单
        document.getElementById('rejectForm').submit();
    };

    // 点击模态框外部关闭
    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
            refusalReasonInput.value = '';
        }
    }
}

// 预览审核
function previewAchievement(id) {

    var passUrl = '/SuperController/auditAchievements/preview?id=' + id + "&type=0";

    window.location.href = passUrl;
}

// 全选/取消全选
const selectAllCheckbox = document.getElementById('selectAllCheckbox');
selectAllCheckbox.addEventListener('change', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    rowCheckboxes.forEach(function (checkbox) {
        const row = checkbox.closest('.achievement-row'); // 获取对应的行
        if (row.style.display !== 'none') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllCheckbox.checked;
        }
    });
});

// 批量通过选中行
const batchPassButton = document.getElementById('batchPassButton');
batchPassButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要通过的成果！");
        return;
    }

    if (!confirm(`确定要批量通过 ${selectedIds.length} 个成果吗？`)) {
        return;
    }

    const url = '/SuperController/auditAchievements/batchPass?ids=' + selectedIds.join(',') + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面，会自动刷新页面

});


