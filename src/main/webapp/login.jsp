<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 — MyInfo 系统</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="cover-card">
    <h1>用户登录</h1>
    <form action="LoginServlet" method="post">
        <input type="text" name="username" placeholder="用户名" required
               style="width:100%;padding:8px;margin:8px 0;border:1px solid #ccc;border-radius:4px;">
        <input type="password" name="password" placeholder="密码" required
               style="width:100%;padding:8px;margin:8px 0;border:1px solid #ccc;border-radius:4px;">
        <button type="submit" class="btn">登录</button>
    </form>
    <p style="margin-top:12px;font-size:14px;">
        还没有账户？<a href="register.jsp">去注册</a>
    </p>
</div>
</body>
</html>
