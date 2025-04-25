<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<jsp:include page="/sub/themeToggle.jsp" />
<div class="container">
    <form action="<%= ctx %>/login" method="post" class="form-card">
        <h2>Login</h2>

        <div class="form-group">
            <label for="username">Username</label>
            <input id="username" type="text" name="username" placeholder="Enter your username" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input id="password" type="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="submit-btn">Login</button>
    </form>
</div>
</body>
</html>
