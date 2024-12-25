
// 全选/取消全选
const selectAllCheckbox = document.getElementById('selectAllCheckbox');
selectAllCheckbox.addEventListener('change', function () {
    const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
    rowCheckboxes.forEach(function (checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
    });
});

// 批量注销选中行
    const batchLogoutButton = document.getElementById('batchLogoutButton');
    batchLogoutButton.addEventListener('click', function () {
        const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
        const selectedIds = [];
        rowCheckboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                selectedIds.push(checkbox.value);
            }
        });

        if (selectedIds.length === 0) {
            alert("请先勾选要注销的用户！");
            return;
        }

        // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
        // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
        // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

        var modal = document.getElementById("LogoutModal");
        var modalContent = document.querySelector("#LogoutModal .modal-content");
        modal.style.display = "block";

        // 添加显示动画
        setTimeout(function () {
            modalContent.classList.add("show");
        }, 10);

        // 关闭按钮事件
        var closeBtn = document.getElementsByClassName("close-logout")[0];
        closeBtn.onclick = function () {
            var modal = document.getElementById("LogoutModal");
            var modalContent = document.querySelector("#LogoutModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function () {
                modal.style.display = "none";
            }, 300);
        };

        // 确定按钮事件
        var approveLogoutButton = document.getElementById("approve-logout-Button");
        approveLogoutButton.onclick = function() {
            // 注销用户
            window.location.href = "/teamAdmin/UserManage/logoutUser?userID=" + userId;
        };

    });

// 批量重置选中行
    const batchResetButton = document.getElementById('batchResetButton');
    batchResetButton.addEventListener('click', function () {
        const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
        const selectedIds = [];
        rowCheckboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                selectedIds.push(checkbox.value);
            }
        });

        if (selectedIds.length === 0) {
            alert("请先勾选要重置密码的用户！");
            return;
        }

        // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
        // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
        // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

        var modal = document.getElementById("ResetModal");
        var modalContent = document.querySelector("#ResetModal .modal-content");
        modal.style.display = "block";

        // 添加显示动画
        setTimeout(function () {
            modalContent.classList.add("show");
        }, 10);

        // 关闭按钮事件
        var closeBtn = document.getElementsByClassName("close-reset")[0];
        closeBtn.onclick = function () {
            var modal = document.getElementById("ResetModal");
            var modalContent = document.querySelector("#ResetModal .modal-content");

            // 隐藏模态框的动画效果
            modalContent.classList.remove("show");

            // 延时隐藏整个模态框，确保动画完成
            setTimeout(function () {
                modal.style.display = "none";
            }, 300);
        };

        // 确定按钮事件
        var approveButton = document.getElementById("approveButton");
        approveButton.onclick = function () {
            selectedIds.forEach(function (userId) {
                // 重置密码
                window.location.href = "/teamAdmin/UserManage/ResetPassword?userID=" + userId;
            });
        };

    });
