<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome - Database Information System</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<div class="container">
    <h1>Welcome to the Database Information System</h1>
    <p>Please log in or register to continue</p>
    <a class="button" href="<%= ctx %>/login.jsp">Login</a>
    <a class="button" href="<%= ctx %>/register.jsp">Register</a>
</div>
</body>
</html>
