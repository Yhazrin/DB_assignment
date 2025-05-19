// src/main/webapp/assets/js/register.js

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('registerForm');
    const messageDiv = document.getElementById('registerMessage');

    if (!form || !messageDiv) {
        console.error('缺少 registerForm 或 registerMessage 元素');
        return;
    }

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        // 重置提示
        messageDiv.textContent = '';
        messageDiv.style.color = '';

        const username        = form.username.value.trim();
        const email           = form.email.value.trim();
        const password        = form.password.value.trim();
        const confirmPassword = form.confirmPassword.value.trim();

        if (!username || !email || !password || !confirmPassword) {
            messageDiv.textContent = '请填写所有字段';
            messageDiv.style.color = 'red';
            return;
        }

        if (password !== confirmPassword) {
            messageDiv.textContent = '两次输入的密码不一致';
            messageDiv.style.color = 'red';
            return;
        }

        try {
            console.log('准备提交注册', { username, email, password });
            const response = await fetch(
                'http://localhost:8080/ServerletFinal_war_exploded/data?type=modifySQL&table=users',
                {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        username,
                        password,
                        email
                    }).toString()
                }
            );

            console.log('注册请求状态', response.status);
            const data = await response.json();
            console.log('后端返回', data);

            if (data.result === 'success') {
                messageDiv.textContent = data.message || '注册成功，1.5秒后跳转到登录页…';
                messageDiv.style.color = 'green';

                // —— 修改：带上用户名和密码作为查询参数 ——
                setTimeout(() => {
                    const params = new URLSearchParams({
                        username: username,
                        password: password
                    });
                    window.location.href =
                        'http://localhost:8081/DB_assignment_war_exploded/assets/page/login.jsp'
                        + '?' + params.toString();
                }, 1500);

            } else {
                messageDiv.textContent = data.message || '注册失败，请重试';
                messageDiv.style.color = 'red';
            }
        } catch (err) {
            console.error('注册请求出错', err);
            messageDiv.textContent = '网络或服务器错误，请稍后再试';
            messageDiv.style.color = 'red';
        }
    });
});
