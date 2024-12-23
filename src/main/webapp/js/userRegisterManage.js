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

        // 获取所有成果行
        const rows = document.querySelectorAll('.one-row');
        rows.forEach(function (row) {
            const username = row.getAttribute('data-username').toLowerCase();
            const creationTime = row.getAttribute('data-creationTime');
            const creationTimeObj = new Date(creationTime);

            // 关键词过滤
            let keywordMatch = true;
            if (keyword !== '') {
                keywordMatch = username.includes(keyword);
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

        // 显示所有成果
        const rows = document.querySelectorAll('.one-row');
        rows.forEach(function (row) {
            row.style.display = '';
        });
    }
});

// 全选/取消全选
const selectAllCheckbox = document.getElementById('selectAllCheckbox');
selectAllCheckbox.addEventListener('change', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    rowCheckboxes.forEach(function (checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
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

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

        //弹出确认框
        var modal = document.getElementById("approveModal");
        var modalContent = document.querySelector("#approveModal .modal-content");
        modal.style.display = "block";

        // 添加显示动画
        setTimeout(function() {
            modalContent.classList.add("show");
        }, 10);

        // 关闭按钮事件
        var closeBtn = document.getElementsByClassName("close-approve")[0];
        closeBtn.onclick = function() {
            var modal = document.getElementById("approveModal");
            var modalContent = document.querySelector("#approveModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function() {
                modal.style.display = "none";
            }, 300);
        };

        // 确定按钮事件
        var approveButton = document.getElementById("approveButton");
        approveButton.onclick = function() {
            // 通过审核，跳转并传递审核结果
            selectedIds.forEach(function (username) {
                window.location.href = "/teamAdmin/RegisterReview?username=" + username + "&status=1";
            });
        };
});


