<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login – Mobile Phone InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 通用样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css">

    <!-- 登录页专用样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/login.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>

<div class="container">
    <div class="login-card">
        <!-- 可选：项目 Logo -->
        <div class="logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.svg" alt="Site Logo">
        </div>

        <!-- 标题 -->
        <h2>Login</h2>

        <!-- 表单 -->
        <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
            <div class="form-group">
                <label for="username">Username</label>
                <input id="username"
                       name="username"
                       type="text"
                       placeholder="Enter your username"
                       required
                       autofocus>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input id="password"
                       name="password"
                       type="password"
                       placeholder="Enter your password"
                       required>
            </div>

            <!-- 主按钮 -->
            <button type="submit" class="btn-primary">Login</button>
        </form>

        <!-- 底部链接 -->
        <div class="footer">
            <p>Don’t have an account?
                <a href="${pageContext.request.contextPath}/assets/page/register.jsp">Register</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
