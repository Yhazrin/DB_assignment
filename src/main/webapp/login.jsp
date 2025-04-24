<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    // 如果已经登录，直接回主页
    if (session != null && session.getAttribute("username") != null) {
        response.sendRedirect(ctx + "/main");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Database Information System</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<div class="container">
    <h1>User Login</h1>
    <form action="<%= ctx %>/login" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <div class="error">${errorMessage}</div>
    <p>Don't have an account? <a href="<%= ctx %>/register.jsp">Register</a></p>
</div>
</body>
</html>
