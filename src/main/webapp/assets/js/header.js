// header.js
document.addEventListener('DOMContentLoaded', () => {
    // 取 contextPath，在 JSP 中可以写成 window.CONTEXT_PATH = '${pageContext.request.contextPath}';
    const CONTEXT = window.CONTEXT_PATH || '';

    const loginBtn = document.getElementById('loginBtn');
    if (loginBtn) {
        loginBtn.addEventListener('click', () => {
            window.location.href = `${CONTEXT}/assets/page/login.jsp`;
        });
    }

    const welcomeBtn = document.getElementById('welcomeBtn');
    if (welcomeBtn) {
        welcomeBtn.addEventListener('click', () => {
            window.location.href = `${CONTEXT}/assets/page/profile.jsp`;
        });
    }
});
