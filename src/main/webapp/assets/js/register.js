// src/main/webapp/assets/js/register.js

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('registerForm');
    const messageDiv = document.getElementById('registerMessage');

    if (!form || !messageDiv) {
        console.error('⚠️ Missing registerForm or registerMessage element');
        return;
    }

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        // Clear previous messages
        messageDiv.textContent = '';
        messageDiv.style.color = '';

        const username = form.username.value.trim();
        const email = form.email.value.trim();
        const password = form.password.value.trim();
        const confirmPassword = form.confirmPassword.value.trim();

        if (!username || !email || !password || !confirmPassword) {
            messageDiv.textContent = 'Please fill in all fields';
            messageDiv.style.color = 'red';
            return;
        }

        if (password !== confirmPassword) {
            messageDiv.textContent = 'Passwords do not match';
            messageDiv.style.color = 'red';
            return;
        }

        try {
            console.log('📝 Preparing to submit registration', { username, email, password });
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

            console.log('🌐 Registration request status', response.status);
            const data = await response.json();
            console.log('💡 Backend returned JSON:', data);

            if (data.result === 'success') {
                messageDiv.textContent = data.message || 'Registration successful! Redirecting to login page in 1.5 seconds…';
                messageDiv.style.color = 'green';

                // Redirect to login page with username and password as query parameters
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
                messageDiv.textContent = data.message || 'Registration failed, please try again';
                messageDiv.style.color = 'red';
            }
        } catch (err) {
            console.error('🔥 Registration request error:', err);
            messageDiv.textContent = 'Network or server error, please try again later';
            messageDiv.style.color = 'red';
        }
    });
});
