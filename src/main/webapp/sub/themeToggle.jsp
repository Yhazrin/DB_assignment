<%-- WebContent/WEB-INF/jsp/common/themeToggle.jsp --%>
<!-- 主题切换按钮 -->
<div class="theme-toggle">🌓</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const toggle = document.querySelector('.theme-toggle');
        const body   = document.body;

        // 1. 读取上次保存的主题
        if (localStorage.getItem('theme') === 'dark') {
            body.classList.add('dark-mode');
        }

        // 2. 点击切换并持久化
        toggle.addEventListener('click', () => {
            const isDark = body.classList.toggle('dark-mode');
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
        });
    });
</script>
