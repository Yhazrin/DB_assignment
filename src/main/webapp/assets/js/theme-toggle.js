// assets/js/theme-toggle.js
document.addEventListener('DOMContentLoaded', () => {
    const btn = document.querySelector('.theme-toggle-btn');
    const iconToggle = document.getElementById('icon-toggle');
    if (!btn || !iconToggle) return;

    // 跟踪当前旋转角度
    let rotationDegrees = 0;

    // 读取本地主题，初始化状态
    if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.classList.add('dark-mode');
        // 如果初始状态是深色模式，设置初始旋转为180度
        rotationDegrees = 180;
        iconToggle.style.transform = `translate(-50%, -50%) rotate(${rotationDegrees}deg)`;
    }

    // 点击切换
    btn.addEventListener('click', () => {
        const isDark = document.documentElement.classList.toggle('dark-mode');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');

        // 每次旋转增加180度
        rotationDegrees += 180;

        // 应用新的旋转角度
        iconToggle.style.transform = `translate(-50%, -50%) rotate(${rotationDegrees}deg)`;
    });
});