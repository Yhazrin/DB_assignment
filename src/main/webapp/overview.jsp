<!-- overview.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // 登录校验
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // 从 request 中取出 records 列表
    @SuppressWarnings("unchecked")
    java.util.List<String[]> records =
            (java.util.List<String[]>) request.getAttribute("records");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Overview - Database Information System</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
    <h1>User Overview</h1>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr><th>ID</th><th>Username</th></tr>
        <%
            if (records != null) {
                for (String[] rec : records) {
        %>
        <tr>
            <td><%= rec[0] %></td>
            <td><%= rec[1] %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
    <p><a href="main">Back to Main</a></p>
</div>
</body>
</html>
