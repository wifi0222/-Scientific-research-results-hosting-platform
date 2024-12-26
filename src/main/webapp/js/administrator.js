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

        // 显示所有
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

// 批量设置选中行的用户权限
const batchUserButton = document.getElementById('batchUserButton');
batchUserButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要设置的管理员！");
        return;
    }
    console.log(selectedIds);

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交
    //弹出确认框
    var modal = document.getElementById("UserModal");
    var modalContent = document.querySelector("#UserModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function() {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("close-user")[0];
    closeBtn.onclick = function() {
        var modal = document.getElementById("UserModal");
        var modalContent = document.querySelector("#UserModal .modal-content");
        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("userButton");
    approveButton.onclick = function() {
        // 批量删除操作
        fetch('/SuperController/TeamAdministrator/setUserAdministrator', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ adminIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("设置成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("设置失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("UserModal");
        var modalContent = document.querySelector("#UserModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});

// 批量设置选中行的科研成果权限
const batchResearchButton = document.getElementById('batchResearchButton');
batchResearchButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要设置的管理员！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交
    //弹出确认框
    var modal = document.getElementById("researchModal");
    var modalContent = document.querySelector("#researchModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function() {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("close-research")[0];
    closeBtn.onclick = function() {
        var modal = document.getElementById("researchModal");
        var modalContent = document.querySelector("#researchModal .modal-content");
        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("researchButton");
    approveButton.onclick = function() {
        // 批量删除操作
        fetch('/SuperController/TeamAdministrator/setResearchAdministrator', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ adminIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("设置成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("设置失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("researchModal");
        var modalContent = document.querySelector("#researchModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});

// 批量设置选中行的文章权限
const batchArticleButton = document.getElementById('batchArticleButton');
batchArticleButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要设置的管理员！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交
    //弹出确认框
    var modal = document.getElementById("articleModal");
    var modalContent = document.querySelector("#articleModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function() {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("close-article")[0];
    closeBtn.onclick = function() {
        var modal = document.getElementById("articleModal");
        var modalContent = document.querySelector("#articleModal .modal-content");
        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("articleButton");
    approveButton.onclick = function() {
        // 批量操作
        fetch('/SuperController/TeamAdministrator/setArticleAdministrator', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ adminIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("设置成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("设置失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("articleModal");
        var modalContent = document.querySelector("#articleModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});


