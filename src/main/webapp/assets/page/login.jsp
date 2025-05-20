<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login – Mobile Phone InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;800&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css">

    <!-- 登录页专用样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/login.css">
</head>
<body>
    <jsp:include page="sub/header.jsp"/>

    <div class="container">
        <div class="login-card">

            <h2>WELCOME.</h2>

            <form id="loginForm" class="login-form" autocomplete="off">
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
                <button type="submit" class="login-btn">LOGIN</button>
            </form>
            <div id="loginError" style="color: #d32f2f; text-align:center; margin-top:10px;"></div>


            <!-- 底部链接 -->
            <div class="footer">
                <p>Don't have an account?
                    <a href="${pageContext.request.contextPath}/assets/page/register.jsp">REGISTER</a>
                </p>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/login.js" defer></script>
    <jsp:include page="sub/scripts.jsp"/>
</body>
</html>
