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
});
