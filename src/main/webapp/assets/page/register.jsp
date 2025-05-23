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
    <link rel="stylesheet" href="<%= ctx %>/assets/css/pages/register.css"> <!-- Include register page specific CSS -->
    <jsp:include page="sub/header.jsp" /> <!-- Include the header page -->
    <jsp:include page="sub/scripts.jsp" /> <!-- Include additional scripts -->
</head>
<body>
<div class="container">
    <div class="register-card">
        <h2>HELLO.</h2>
        <form id="registerForm" class="register-form" autocomplete="off">
            <div class="form-group">
                <label for="username">Username</label> <!-- Username label -->
                <input id="username" type="text" name="username" placeholder="Choose a username" required> <!-- Username input field -->
            </div>
            <div class="form-group">
                <label for="email">Email</label> <!-- Email label -->
                <input id="email" type="email" name="email" placeholder="Enter your email" required> <!-- Email input field -->
            </div>
            <div class="form-group">
                <label for="password">Password</label> <!-- Password label -->
                <input id="password" type="password" name="password" placeholder="Create a password" required> <!-- Password input field -->
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label> <!-- Confirm Password label -->
                <input id="confirmPassword" type="password" name="confirmPassword" placeholder="Repeat your password" required> <!-- Confirm Password input field -->
            </div>
            <button type="submit" class="register-btn">REGISTER</button> <!-- Register button -->
        </form>

        <div id="registerMessage" style="margin-top:1rem;"></div> <!-- Container to display registration messages -->

        <script src="${pageContext.request.contextPath}/assets/js/register.js"></script> <!-- Include register page specific JavaScript -->

        <div class="footer">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/assets/page/login.jsp" class="section-btn">LOGIN</a> <!-- Link to login page -->
            </p>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/background.js"></script> <!-- Include background JavaScript -->
</body>
</html>
