document.addEventListener('DOMContentLoaded', function () {
    // 新增
    // const searchButton = document.getElementById('searchButton');
    // const resetButton = document.getElementById('resetButton');
    const teamMemberTab=document.getElementById('teamMemberTab');
    const visitorTab=document.getElementById('visitorTab');
    const applicationTab=document.getElementById('applicationTab');

    const teamMemberSection=document.getElementById('teamMemberSection');
    const VisitorSection=document.getElementById('VisitorSection');
    const ApplicationSection=document.getElementById('ApplicationSection');

    // 显示团队成员
    function showTeamMember() {
        teamMemberSection.classList.add('active');
        VisitorSection.classList.remove('active');
        ApplicationSection.classList.remove('active');

        teamMemberTab.classList.add('active');
        visitorTab.classList.remove('active');
        applicationTab.classList.remove('active');
    }

    // 显示普通用户
    function showVisitor() {
        VisitorSection.classList.add('active');
        teamMemberSection.classList.remove('active');
        ApplicationSection.classList.remove('active'); // 新增

        visitorTab.classList.add('active');
        teamMemberTab.classList.remove('active');
        applicationTab.classList.remove('active'); // 新增
    }

    // 显示申请注销
    function showApplication() {
        ApplicationSection.classList.add('active');
        teamMemberSection.classList.remove('active');
        VisitorSection.classList.remove('active');

        applicationTab.classList.add('active');
        teamMemberTab.classList.remove('active');
        visitorTab.classList.remove('active');
    }

    // 给每个 tab 绑定事件
    teamMemberTab.addEventListener('click', showTeamMember);
    visitorTab.addEventListener('click', showVisitor);
    applicationTab.addEventListener('click', showApplication); // 新增

    // 默认显示团队成员
    showTeamMember();

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
        // const category = document.getElementById('category').value;
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
            const username = row.getAttribute('data-username').toLowerCase();
            const creationTime = row.getAttribute('data-creationTime');
            const creationTimeObj = new Date(creationTime);

            // 关键词过滤
            let keywordMatch = !keyword || username.includes(keyword);

            // 时间过滤
            let startDateMatch = !startDate || (creationTimeObj >= startDateObj);
            let endDateMatch = !endDate || (creationTimeObj <= endDateObj);

            // 合并判断
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

//团队成员
const selectAllteamMember = document.getElementById("selectAllteamMember");
const rowCheckboxesteamMemberRow = document.querySelectorAll(".teamMemberRow");

selectAllteamMember.addEventListener("change", function () {
    rowCheckboxesteamMemberRow.forEach(checkbox => {
        const row = checkbox.closest('.one-row'); // 获取对应的行
        if (row.style.display == '') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllteamMember.checked;
        }
    });
});

//普通成员
const selectAllVisitor = document.getElementById("selectAllVisitor");
const rowCheckboxesVisitor = document.querySelectorAll(".visitorRow");

selectAllVisitor.addEventListener("change", function () {
    rowCheckboxesVisitor.forEach(checkbox => {
        const row = checkbox.closest('.one-row'); // 获取对应的行
        if (row.style.display == '') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllVisitor.checked;
        }
    });
});

//普通成员
const selectAllApplication = document.getElementById("selectAllApplication");
const rowCheckboxesApplication = document.querySelectorAll(".ApplicationRow");

selectAllApplication.addEventListener("change", function () {
    rowCheckboxesApplication.forEach(checkbox => {
        const row = checkbox.closest('.one-row'); // 获取对应的行
        if (row.style.display == '') { // 只处理可见的行，确保筛选后的全选不会选择未筛选的行
            checkbox.checked = selectAllApplication.checked;
        }
    });
});

//团队成员批量
// 批量删除选中行
const batchLogoutButton = document.getElementById('BatchLogoutButton');
batchLogoutButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.teamMemberRow');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要删除的用户！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

    var modal = document.getElementById("BatchLogoutModal");
    var modalContent = document.querySelector("#BatchLogoutModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("batch-close-logout")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("BatchLogoutModal");
        var modalContent = document.querySelector("#BatchLogoutModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveLogoutButton = document.getElementById("batch-logout-Button");
    approveLogoutButton.onclick = function() {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchLogoutUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("BatchLogoutModal");
        var modalContent = document.querySelector("#BatchLogoutModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});

// 批量重置选中行
const batchResetButton = document.getElementById('BatchResetButton');
batchResetButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.teamMemberRow');
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

    var modal = document.getElementById("BatchResetModal");
    var modalContent = document.querySelector("#BatchResetModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("batch-close-reset")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("BatchResetModal");
        var modalContent = document.querySelector("#BatchResetModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("batch-reset-button");
    approveButton.onclick = function () {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchResetUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("重置成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("重置失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("BatchLogoutModal");
        var modalContent = document.querySelector("#BatchLogoutModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };
});

// 批量注销选中行
const batchStatusButton = document.getElementById('BatchStatusButton');
batchStatusButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.teamMemberRow');
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

    var modal = document.getElementById("BatchStatusModal");
    var modalContent = document.querySelector("#BatchStatusModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("batch-close-status")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("BatchStatusModal");
        var modalContent = document.querySelector("#BatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("batch-status-button");
    approveButton.onclick = function () {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchSetStatusUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("BatchStatusModal");
        var modalContent = document.querySelector("#BatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };
});

//普通用户批量
// 批量删除选中行
const VisitorbatchLogoutButton = document.getElementById('VisitorBatchLogoutButton');
VisitorbatchLogoutButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.visitorRow');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要删除的用户！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

    var modal = document.getElementById("VisitorBatchLogoutModal");
    var modalContent = document.querySelector("#VisitorBatchLogoutModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("Visitor-batch-close-logout")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("VisitorBatchLogoutModal");
        var modalContent = document.querySelector("#VisitorBatchLogoutModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveLogoutButton = document.getElementById("Visitor-batch-logout-Button");
    approveLogoutButton.onclick = function() {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchLogoutUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("VisitorBatchLogoutModal");
        var modalContent = document.querySelector("#VisitorBatchLogoutModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});

// 批量重置选中行
const VisitorbatchResetButton = document.getElementById('VisitorBatchResetButton');
VisitorbatchResetButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.visitorRow');
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

    var modal = document.getElementById("VisitorBatchResetModal");
    var modalContent = document.querySelector("#VisitorBatchResetModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("Visitor-batch-close-reset")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("VisitorBatchResetModal");
        var modalContent = document.querySelector("#VisitorBatchResetModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("Visitor-batch-reset-button");
    approveButton.onclick = function () {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchResetUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("重置成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("重置失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("VisitorBatchLogoutModal");
        var modalContent = document.querySelector("#VisitorBatchLogoutModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };
});

// 批量注销选中行
const VisitorbatchStatusButton = document.getElementById('VisitorBatchStatusButton');
VisitorbatchStatusButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.visitorRow');
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

    var modal = document.getElementById("VisitorBatchStatusModal");
    var modalContent = document.querySelector("#VisitorBatchStatusModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("Visitor-batch-close-status")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("VisitorBatchStatusModal");
        var modalContent = document.querySelector("#VisitorBatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("Visitor-batch-status-button");
    approveButton.onclick = function () {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchSetStatusUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("VisitorBatchStatusModal");
        var modalContent = document.querySelector("#VisitorBatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };
});

//普通用户批量
// 批量删除选中行
const AppbatchLogoutButton = document.getElementById('ApplicationBatchLogoutButton');
AppbatchLogoutButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.ApplicationRow');
    const selectedIds = [];
    rowCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            selectedIds.push(checkbox.value);
        }
    });

    if (selectedIds.length === 0) {
        alert("请先勾选要删除的用户！");
        return;
    }

    // 这里根据你的后端实现方式，可通过 AJAX、表单提交等方式将 selectedIds 传到后端
    // 下面只演示简单的调用已有的 passAchievementReview(id) 函数逐个处理
    // 如果你需要一次性将所有 ID 传给后台做批量更新，也可以改成一个新的函数来一次性提交

    var modal = document.getElementById("ApplicationBatchLogoutModal");
    var modalContent = document.querySelector("#ApplicationBatchLogoutModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("Application-batch-close-logout")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("ApplicationBatchLogoutModal");
        var modalContent = document.querySelector("#ApplicationBatchLogoutModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveLogoutButton = document.getElementById("Application-batch-logout-Button");
    approveLogoutButton.onclick = function() {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchLogoutUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("ApplicationBatchLogoutModal");
        var modalContent = document.querySelector("#ApplicationBatchLogoutModal .modal-content");
        modalContent.classList.remove("show");

        setTimeout(function() {
            modal.style.display = "none";
        }, 300);
    };

});

// 批量注销选中行
const AppbatchStatusButton = document.getElementById('ApplicationBatchStatusButton');
AppbatchStatusButton.addEventListener('click', function () {
    const rowCheckboxes = document.querySelectorAll('.ApplicationRow');
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

    var modal = document.getElementById("ApplicationBatchStatusModal");
    var modalContent = document.querySelector("#ApplicationBatchStatusModal .modal-content");
    modal.style.display = "block";

    // 添加显示动画
    setTimeout(function () {
        modalContent.classList.add("show");
    }, 10);

    // 关闭按钮事件
    var closeBtn = document.getElementsByClassName("Application-batch-close-status")[0];
    closeBtn.onclick = function () {
        var modal = document.getElementById("ApplicationBatchStatusModal");
        var modalContent = document.querySelector("#ApplicationBatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };

    // 确定按钮事件
    var approveButton = document.getElementById("Application-batch-status-button");
    approveButton.onclick = function () {
        // 批量操作
        fetch('/teamAdmin/UserManage/BatchSetStatusUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userIds: selectedIds })
        })
            .then(response => response.json())
            .then(data => {
                // 处理结果
                if (data.success) {
                    alert("注销成功！");
                    location.reload(); // 刷新页面
                } else {
                    alert("注销失败！");
                }
            })
            .catch(error => {
                alert(error);
            });

        // 关闭模态框
        var modal = document.getElementById("ApplicationBatchStatusModal");
        var modalContent = document.querySelector("#ApplicationBatchStatusModal .modal-content");

        // 隐藏模态框的动画效果
        modalContent.classList.remove("show");

        // 延时隐藏整个模态框，确保动画完成
        setTimeout(function () {
            modal.style.display = "none";
        }, 300);
    };
});



