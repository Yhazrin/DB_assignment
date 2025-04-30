<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Mobile Phone InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/pre.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <jsp:include page="header.jsp"/>
</head>
<body>
<jsp:include page="/sub/themeToggle.jsp" />

<div class="container">
    <form action="<%= ctx %>/login" method="post" class="form-card">
        <h2>Login</h2>

        <div class="form-group">
            <input id="username" name="username" type="text" placeholder="Enter your username" class="form-input" required autofocus />
        </div>

        <div class="form-group">
            <input id="password" name="password" type="password" placeholder="Enter your password" class="form-input" required />
        </div>

        <div class="form-actions">
            <a href="<%= ctx %>/register.jsp" class="link-button">Register</a>
            <button type="submit" class="submit-btn">Login</button>
        </div>
    </form>
</div>
</body>
</html>
