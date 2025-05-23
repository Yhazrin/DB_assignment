// src/main/webapp/assets/js/login.js

console.log('🔄 login.js loaded');

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('loginForm');
    const messageDiv = document.getElementById('loginError');

    if (!form || !messageDiv) {
        console.error('⚠️ Missing loginForm or loginError element');
        return;
    }

    // Prefill form with username and password from URL
    const params = new URLSearchParams(window.location.search);
    const savedUser = params.get('username');
    const savedPass = params.get('password');
    if (savedUser) {
        console.log('⭐ Prefilling username:', savedUser);
        document.getElementById('username').value = savedUser;
    }
    if (savedPass) {
        console.log('⭐ Prefilling password:', '[hidden]');
        document.getElementById('password').value = savedPass;
    }

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Clear previous messages
        messageDiv.textContent = '';
        messageDiv.style.color = '';

        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        console.log('📝 Preparing to submit login', { username, password });

        if (!username || !password) {
            messageDiv.textContent = 'Please enter both username and password.';
            messageDiv.style.color = 'red';
            return;
        }

        // Prepare URL and body for login request
        const url = 'http://localhost:8080/ServerletFinal_war_exploded/data';
        const body = new URLSearchParams({
            type:     'login',
            table:    'users',
            username,
            password
        }).toString();

        console.log('🌐 Initiating login request', { url, body });

        try {
            const response = await fetch(url, {
                method: 'POST',
                credentials: 'include',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body
            });

            console.log(`📶 HTTP status: ${response.status} ${response.statusText}`);

            const data = await response.json();
            console.log('💡 Backend returned JSON:', data);

            // Handle backend errors related to missing or invalid parameters
            if (data.ferror) {
                console.warn('❌ Parameter missing or format error:', data.ferror);
                messageDiv.textContent = data.ferror;
                messageDiv.style.color = 'red';
                return;
            }

            if (data.result === 'success') {
                messageDiv.textContent = data.message || 'Login successful!';
                messageDiv.style.color = 'green';
                console.log('✅ Login successful, redirecting soon');

                setTimeout(() => {
                    window.location.href =
                        'http://localhost:8081/DB_assignment_war_exploded/assets/page/home.jsp';
                }, 10000);

            } else {
                console.warn('❌ Login failed:', data.message);
                messageDiv.textContent = data.message || 'Login failed, please try again.';
                messageDiv.style.color = 'red';
            }
        } catch (err) {
            console.error('🔥 Login request error:', err);
            messageDiv.textContent = 'Network or server error, please try again later.';
            messageDiv.style.color = 'red';
        }
    });
});
