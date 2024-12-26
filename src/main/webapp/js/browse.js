document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('.carousel img');
    let currentIndex = 0;

    function showNextImage() {
        images[currentIndex].classList.remove('active');
        images[currentIndex].classList.add('prev');
        currentIndex = (currentIndex + 1) % images.length;
        images[currentIndex].classList.remove('prev');
        images[currentIndex].classList.add('active');
    }

    setInterval(showNextImage, 3000); // 每3秒切换

    const sidebar = document.querySelector('.sidebar');
    const sidebarToggle = document.querySelector('.sidebar-toggle');

    // 定义 toggleSidebar 函数
    function toggleSidebar() {
        sidebar.classList.toggle('collapsed'); // 切换 collapsed 类控制显示和隐藏
    }

    // 绑定点击事件
    sidebarToggle.addEventListener('click', toggleSidebar);
});
