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

        // 获取所有行
        const rows = document.querySelectorAll('.one-row');
        rows.forEach(function (row) {
            const name = row.getAttribute('data-name').toLowerCase();

            // 关键词过滤
            let keywordMatch = true;
            if (keyword !== '') {
                keywordMatch = name.includes(keyword);
            }

            // 综合判断
            if (keywordMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 重置筛选条件
    function resetFilters() {
        document.getElementById('keyword').value = '';

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
        alert("请先勾选要通过的成员！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

    //弹出是否确定
    var modal = document.getElementById("batchModal");
    var modalContent = document.querySelector("#batchModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function() {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("close-batch")[0];
    closeBtn.onclick = function() {
        var modal = document.getElementById("batchModal");
        var modalContent = document.querySelector("#batchModal .modal-content");
        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("batchButton");
    approveButton.onclick = function() {
        // 通过审核，跳转并传递审核结果
        // 批量操作
        fetch('/teamAdmin/TeamManage/Member/BatchReview', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ memberIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("审核成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("审核失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("batchModal");
        var modalContent = document.querySelector("#batchModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };
});


