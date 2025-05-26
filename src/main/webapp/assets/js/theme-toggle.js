// assets/js/theme-toggle.js
document.addEventListener('DOMContentLoaded', () => {
    const toggleBtn = document.querySelector('.theme-toggle-btn');
    const icon = document.getElementById('icon-toggle');
    if (!toggleBtn || !icon) return;

    // 1. 读取并应用初始主题
    let rotation = 0;
    const stored = localStorage.getItem('preferred-theme');
    let theme;
    if (stored === 'dark') {
        theme = 'dark';
        rotation = 180;
    } else if (stored === 'light') {
        theme = 'light';
    } else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        theme = 'dark';
        rotation = 180;
    } else {
        theme = 'light';
    }
    applyTheme(theme, rotation);

    // 2. 点击切换主题 + 图标旋转
    toggleBtn.addEventListener('click', () => {
        theme = (theme === 'light' ? 'dark' : 'light');
        rotation += 180;
        localStorage.setItem('preferred-theme', theme);
        applyTheme(theme, rotation);
    });

    // 工具函数：应用主题状态到 document & 按钮
    function applyTheme(theme, rotationDeg) {
        // ① data-theme 属性（部分 CSS 可能基于它）
        document.documentElement.setAttribute('data-theme', theme);
        // ② 可选 class 切换（如果你有 .dark-mode 相关样式）
        document.documentElement.classList.toggle('dark-mode', theme === 'dark');
        // ③ 切换开关状态（checkbox 形式）
        const checkbox = document.querySelector('.theme-toggle');
        if (checkbox) checkbox.checked = (theme === 'dark');
        // ④ 图标旋转
        icon.style.transform = `translate(-50%, -50%) rotate(${rotationDeg}deg)`;
    }
});
