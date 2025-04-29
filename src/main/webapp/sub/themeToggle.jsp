<%-- themeToggle.jsp --%>
<div class="theme-toggle-btn">
    <svg id="icon-sun" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">...</svg>
    <svg id="icon-moon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">...</svg>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const toggle = document.querySelector('.theme-toggle-btn');
        const htmlEl = document.documentElement; // 改为操作html元素

        // 初始化主题
        const savedTheme = localStorage.getItem('theme') || 'light';
        htmlEl.classList.toggle('dark-mode', savedTheme === 'dark');

        // 切换事件
        toggle.addEventListener('click', () => {
            const isDark = htmlEl.classList.toggle('dark-mode');
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
        });
    });
</script>
