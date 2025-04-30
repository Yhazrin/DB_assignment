// assets/js/theme-toggle.js
document.addEventListener('DOMContentLoaded', () => {
    const btn = document.querySelector('.theme-toggle-btn');
    if (!btn) return;

    // 读取本地主题，初始化状态
    if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.classList.add('dark-mode');
    }

    // 点击切换
    btn.addEventListener('click', () => {
        const isDark = document.documentElement.classList.toggle('dark-mode');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');
    });
});
