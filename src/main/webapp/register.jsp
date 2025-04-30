<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/pre.css">
    <jsp:include page="sub/themeToggle.jsp" />
</head>
<body>
<div class="container">
    <form action="<%= ctx %>/register" method="post" class="form-card">
        <h2>Register</h2>

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

        <button type="submit" class="submit-btn">Register</button>
    </form>
</div>
</body>
</html>
