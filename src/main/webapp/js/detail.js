document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('.carousel-img'); // 获取所有的图片元素
    let currentIndex = 0;

    // 初始化，显示第一张图片
    images[currentIndex].classList.add('active');

    // 添加类名来管理图片切换
    function showNextImage() {
        images[currentIndex].classList.remove('active');   // 移除当前显示的图片的 active 类
        currentIndex = (currentIndex + 1) % images.length; // 计算下一个图片的索引
        images[currentIndex].classList.add('active');      // 给下一张图片添加 active 类
    }

    function showPrevImage() {
        images[currentIndex].classList.remove('active');   // 移除当前显示的图片的 active 类
        currentIndex = (currentIndex - 1 + images.length) % images.length; // 计算上一张图片的索引
        images[currentIndex].classList.add('active');      // 给上一张图片添加 active 类
    }

    setInterval(showNextImage, 3000); // 每3秒切换一次图片

    // 手动控制轮播图
    window.moveCarousel = function (direction) {
        if (direction === 1) {
            showNextImage();
        } else if (direction === -1) {
            showPrevImage();
        }
    };
});

// 检查是否直接访问，或者浏览历史长度
function goBack() {
    if (document.referrer && document.referrer !== "") {
        // 如果有来源页，返回到上一页
        window.history.back();
    } else {
        // 如果没有来源页（直接访问），跳转到默认页面
        window.location.href = '/browse';  // 或者你希望跳转的其他默认页面
    }
}