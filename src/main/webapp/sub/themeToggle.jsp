<%-- themeToggle.jsp --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">

<button class="theme-toggle-btn" type="button" aria-label="切换主题">
    <svg id="icon-sun" viewBox="0 0 24 24">
        <path d="M12 17a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0 2a7 7 0 1 1 0-14 7 7 0 0 1 0 14zM11 3v2h2V3h-2zm0 16v2h2v-2h-2zM3.515 4.929l1.414-1.414L7.05 5.636 5.636 7.05 3.515 4.93zM16.95 18.364l1.414-1.414 2.121 2.121-1.414 1.414-2.121-2.121zm2.121-14.85l1.414 1.415-2.121 2.121-1.414-1.414 2.121-2.121zM5.636 16.95l1.414 1.414-2.121 2.121-1.414-1.414 2.121-2.121zM23 11v2h-3v-2h3zM4 11v2H1v-2h3z"/>
    </svg>
    <svg id="icon-moon" viewBox="0 0 24 24">
        <path d="M12 3c.132 0 .263 0 .393 0a7.5 7.5 0 0 0 7.92 12.446A9 9 0 1 1 12 3z"/>
    </svg>
</button>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const toggle = document.querySelector('.theme-toggle-btn');
        const htmlEl = document.documentElement;

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