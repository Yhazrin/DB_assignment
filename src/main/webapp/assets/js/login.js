// src/main/webapp/assets/js/login.js

console.log('🔄 login.js 加载完成');

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('loginForm');
    const messageDiv = document.getElementById('loginError');

    if (!form || !messageDiv) {
        console.error('⚠️ 缺少 loginForm 或 loginError 元素');
        return;
    }

    // —— 从 URL 拿 username/password，预填表单 ——
    const params = new URLSearchParams(window.location.search);
    const savedUser = params.get('username');
    const savedPass = params.get('password');
    if (savedUser) {
        console.log('⭐ 预填 username:', savedUser);
        document.getElementById('username').value = savedUser;
    }
    if (savedPass) {
        console.log('⭐ 预填 password:', '[hidden]');
        document.getElementById('password').value = savedPass;
    }

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        // 清空上一次提示
        messageDiv.textContent = '';
        messageDiv.style.color = '';

        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        console.log('📝 准备提交登录', { username, password });

        if (!username || !password) {
            messageDiv.textContent = 'Please enter both username and password.';
            messageDiv.style.color = 'red';
            return;
        }

        // —— 修改：将 type 和 table 一并放入 body ——
        const url = 'http://localhost:8080/ServerletFinal_war_exploded/data';
        const body = new URLSearchParams({
            type:     'login',
            table:    'users',
            username,
            password
        }).toString();

        console.log('🌐 发起登录请求', { url, body });

        try {
            const response = await fetch(url, {
                method: 'POST',
                credentials: 'include',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body
            });

            console.log(`📶 HTTP 状态: ${response.status} ${response.statusText}`);

            const data = await response.json();
            console.log('💡 后端返回 JSON:', data);

            // —— 优先处理后端返回的参数缺失或其他自定义错误字段 ——
            if (data.ferror) {
                console.warn('❌ 参数缺失或格式错误:', data.ferror);
                messageDiv.textContent = data.ferror;
                messageDiv.style.color = 'red';
                return;
            }

            if (data.result === 'success') {
                messageDiv.textContent = data.message || 'Login successful!';
                messageDiv.style.color = 'green';
                console.log('✅ 登录成功，即将跳转');

                setTimeout(() => {
                    window.location.href =
                        'http://localhost:8081/DB_assignment_war_exploded/assets/page/home.jsp';
                }, 10000);

            } else {
                console.warn('❌ 登录失败:', data.message);
                messageDiv.textContent = data.message || 'Login failed, please try again.';
                messageDiv.style.color = 'red';
            }
        } catch (err) {
            console.error('🔥 登录请求出错：', err);
            messageDiv.textContent = 'Network or server error, please try again later.';
            messageDiv.style.color = 'red';
        }
    });
});
