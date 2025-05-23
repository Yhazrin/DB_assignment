<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login – Mobile Phone InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;800&display=swap" rel="stylesheet"> <!-- Include Montserrat font -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css"> <!-- Include header component CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css"> <!-- Include theme toggle component CSS -->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/login.css"> <!-- Include login page specific CSS -->
</head>
<body>
    <jsp:include page="sub/header.jsp"/> <!-- Include the header page -->

    <div class="container">
        <div class="login-card">

            <h2>WELCOME.</h2>

            <form id="loginForm" class="login-form" autocomplete="off"> <!-- Login form -->
                <div class="form-group">
                    <label for="username">Username</label> <!-- Username label -->
                    <input id="username"
                           name="username"
                           type="text"
                           placeholder="Enter your username"
                           required
                           autofocus> <!-- Username input field -->
                </div>
                <div class="form-group">
                    <label for="password">Password</label> <!-- Password label -->
                    <input id="password"
                           name="password"
                           type="password"
                           placeholder="Enter your password"
                           required> <!-- Password input field -->
                </div>
                <button type="submit" class="login-btn">LOGIN</button> <!-- Login button -->
            </form>
            <div id="loginError" style="color: #d32f2f; text-align:center; margin-top:10px;"></div> <!-- Container to display login errors -->

            <div class="footer">
                <p>Don't have an account?
                    <a href="${pageContext.request.contextPath}/assets/page/register.jsp">REGISTER</a> <!-- Link to register page -->
                </p>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/login.js" defer></script> <!-- Include login page JavaScript -->
    <jsp:include page="sub/scripts.jsp"/> <!-- Include additional scripts -->
</body>
</html>
