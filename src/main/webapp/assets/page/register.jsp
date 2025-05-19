<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register – Mobile Phone InfoHub</title>
    <!-- 引入 register.css，而不是 pre.css -->
    <link rel="stylesheet" href="<%= ctx %>/assets/css/pages/register.css">
    <!-- 可选：主题切换组件 -->
    <jsp:include page="sub/header.jsp" />
    <jsp:include page="sub/scripts.jsp" />
</head>
<body>
<div class="container">
    <div class="register-card">
        <h2>HELLO.</h2>
        <form action="<%= ctx %>/register" method="post" class="register-form" autocomplete="off">
            <div class="form-group">
                <label for="username">Username</label>
                <input id="username" type="text" name="username" placeholder="Choose a username" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input id="email" type="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="Create a password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input id="confirmPassword" type="password" name="confirmPassword" placeholder="Repeat your password" required>
            </div>
            <button type="submit" class="register-btn">REGISTER</button>
        </form>
        <div class="footer">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/assets/page/login.jsp" class="section-btn">LOGIN</a>
            </p>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/background.js"></script>
</body>
</html>
