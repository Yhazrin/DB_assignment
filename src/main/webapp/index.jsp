<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome - Database Information System</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<!-- 主题切换按钮：移除 onclick -->
<div class="theme-toggle">🌓</div>

<div class="container">
    <h1>Welcome to the Database Information System</h1>
    <p>Please log in or register to continue.</p>
    <a class="button" href="<%= ctx %>/login.jsp">Login</a>
    <a class="button" href="<%= ctx %>/register.jsp">Register</a>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const toggle = document.querySelector('.theme-toggle');
        const body   = document.body;

        // 初始化：从 localStorage 读取
        if (localStorage.getItem('theme') === 'dark') {
            body.classList.add('dark-mode');
        }

        // 点击只执行一次切换和存储
        toggle.addEventListener('click', () => {
            const isDark = body.classList.toggle('dark-mode');
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
        });
    });
</script>
</body>
</html>
