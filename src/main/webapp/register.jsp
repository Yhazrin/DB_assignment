<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    if (session != null && session.getAttribute("username") != null) {
        response.sendRedirect(ctx + "/main");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Database Information System</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<div class="container">
    <h1>User Registration</h1>
    <form action="<%= ctx %>/register" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        <button type="submit">Register</button>
    </form>
    <div class="error">${errorMessage}</div>
    <div class="success">${successMessage}</div>
    <p>Already have an account? <a href="<%= ctx %>/login.jsp">Login</a></p>
</div>
</body>
</html>
