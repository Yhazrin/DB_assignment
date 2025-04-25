<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome - Database Information System</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
</head>
<body>
<!-- 公共主题切换片段 -->
<jsp:include page="/sub/themeToggle.jsp" />

<div class="container">
    <h1>Welcome to the Database Information System</h1>
    <p>Please log in or register to continue.</p>
    <a class="button" href="<%= ctx %>/login.jsp">Login</a>
    <a class="button" href="<%= ctx %>/register.jsp">Register</a>
</div>
</body>
</html>
