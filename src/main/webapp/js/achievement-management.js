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
    var editUrl = '/teamAdmin/achievements/edit?id=' + id + "&type=0";

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
    var editUrl = '/teamAdmin/achievements/delete?id=' + id + "&type=0";
    // 跳转到编辑页面
    window.location.href = editUrl;
}

// 切换审核状态
function switchViewStatus(id) {
    // 此处加入删除逻辑

    // 获取项目的上下文路径
    var contextPath = '${pageContext.request.contextPath}';

    // 构建编辑页面的URL
    var editUrl = '/teamAdmin/achievements/switchViewStatus?id=' + id + "&type=0";

    // 跳转到编辑页面
    window.location.href = editUrl;
}

// ========== 已发布的成果（status=1） ==========
const selectAllPublished = document.getElementById("selectAllPublished");
const rowCheckboxesPublished = document.querySelectorAll(".rowCheckboxPublished");

// 全选/取消全选
selectAllPublished.addEventListener("change", function () {
    rowCheckboxesPublished.forEach(checkbox => {
        const row = checkbox.closest('.achievement-row'); // 获取对应的行
        if (row.style.display !== 'none') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllPublished.checked;
        }
    });
});

document.getElementById("batchDeletePublished").addEventListener("click", function () {
    const selectedIds = getSelectedIds(rowCheckboxesPublished);
    if (selectedIds.length === 0) {
        alert("请先勾选要删除的成果！");
        return;
    }
    // 建议批量操作用单独的接口来实现
    // selectedIds.forEach(function (id) {
    //     deleteAchievement(id);
    // });

    if (!confirm(`确定要批量删除 ${selectedIds.length} 个成果吗？`)) {
        return;
    }

    const url = '/teamAdmin/achievements/batchDelete?ids=' + selectedIds.join(',') + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面，会自动刷新页面
});

document.getElementById("batchPublicPublished").addEventListener("click", function () {
    const selectedIds = getSelectedIds(rowCheckboxesPublished);
    if (selectedIds.length === 0) {
        alert("请先勾选要公开的成果！");
        return;
    }
    // 批量公开逻辑
    // 使用 fetch 发送异步请求，页面不会刷新，适用需要与服务器交互但不想跳转页面、动态更新部分页面，需要手动更新
    // // window.location.href = editUrl;立即导航到指定的 URL，适用于需要打开一个新的页面
    // fetch(url, {method: 'GET'})
    //     .then(response => response.json())
    //     .then(data => {
    //         console.log('操作成功:', data);
    //     })
    //     .catch(error => {
    //         console.error('操作失败:', error);
    //     });
    if (!confirm(`确定要批量公开 ${selectedIds.length} 个成果吗？`)) {
        return;
    }
    const url = '/teamAdmin/achievements/switchViewStatusByStatus?ids=' + selectedIds.join(',') + '&status=1' + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面，会自动刷新页面
});

document.getElementById("batchHidePublished").addEventListener("click", function () {
    const selectedIds = getSelectedIds(rowCheckboxesPublished);
    if (selectedIds.length === 0) {
        alert("请先勾选要隐藏的成果！");
        return;
    }
    if (!confirm(`确定要批量隐藏 ${selectedIds.length} 个成果吗？`)) {
        return;
    }
    // 批量隐藏逻辑
    const url = '/teamAdmin/achievements/switchViewStatusByStatus?ids=' + selectedIds.join(',') + '&status=0' + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面
});

// ========== 正在审核的成果（status=0） ==========
const selectAllReview = document.getElementById("selectAllReview");
const rowCheckboxesReview = document.querySelectorAll(".rowCheckboxReview");

selectAllReview.addEventListener("change", function () {
    rowCheckboxesReview.forEach(checkbox => {
        const row = checkbox.closest('.achievement-row'); // 获取对应的行
        if (row.style.display == '') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllReview.checked;
        }
    });
});

document.getElementById("batchDeleteReview").addEventListener("click", function () {
    const selectedIds = getSelectedIds(rowCheckboxesReview);
    if (selectedIds.length === 0) {
        alert("请先勾选要删除的成果！");
        return;
    }
    if (!confirm(`确定要批量删除 ${selectedIds.length} 个成果吗？`)) {
        return;
    }
    const url = '/teamAdmin/achievements/batchDelete?ids=' + selectedIds.join(',') + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面，会自动刷新页面
});

// ========== 审核被拒绝的成果（status=-1） ==========
const selectAllRejected = document.getElementById("selectAllRejected");
const rowCheckboxesRejected = document.querySelectorAll(".rowCheckboxRejected");

selectAllRejected.addEventListener("change", function () {
    rowCheckboxesRejected.forEach(checkbox => {
        const row = checkbox.closest('.achievement-row'); // 获取对应的行
        if (row.style.display !== 'none') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllRejected.checked;
        }
    });
});

document.getElementById("batchDeleteRejected").addEventListener("click", function () {
    const selectedIds = getSelectedIds(rowCheckboxesRejected);
    if (selectedIds.length === 0) {
        alert("请先勾选要删除的成果！");
        return;
    }
    if (!confirm(`确定要批量删除 ${selectedIds.length} 个成果吗？`)) {
        return;
    }
    const url = '/teamAdmin/achievements/batchDelete?ids=' + selectedIds.join(',') + "&type=0";
    window.location.href = url; // 立即导航到指定的 URL，适用于需要打开一个新的页面，会自动刷新页面
});

// 获取已勾选行的ID列表工具函数
function getSelectedIds(checkboxes) {
    const ids = [];
    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            ids.push(checkbox.value);
        }
    });
    return ids;
}

function showReasonModal(reason) {
    const reasonModal = document.getElementById("reasonModal");
    const closeReasonModalBtn = document.getElementById("closeReasonModal");
    const reasonText = document.getElementById("reasonText");

    // 将传入的拒绝理由赋值给模态框中的文本
    reasonText.textContent = reason;

    // 显示模态框
    reasonModal.style.display = "block";

    // 点击“关闭”按钮时，隐藏模态框
    closeReasonModalBtn.onclick = function () {
        reasonModal.style.display = "none";
    };

    // 点击模态框外部区域时，隐藏模态框
    window.onclick = function (event) {
        if (event.target === reasonModal) {
            reasonModal.style.display = "none";
        }
    };
}
