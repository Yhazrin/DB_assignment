<!-- main.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // 如果未登录，跳回登录页
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<head>
    <title>Main - Database Information System</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
    <h1>Welcome, <%= user %>!</h1>
    <nav>
        <a class="button" href="overview">Overview</a>
        <a class="button" href="forum">Forum</a>
        <a class="button" href="logout">Logout</a>
    </nav>
</div>
</body>
</html>
