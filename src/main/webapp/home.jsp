<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mobile Phone InfoHub - Home</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/home.css" />
    <style>
        /* 保证主题切换按钮悬浮在最顶层 */
        .theme-toggle-container {
            position: fixed;
            left: 24px;
            bottom: 24px;
            z-index: 2000;
        }
    </style>
</head>
<body>
<header class="navbar">
    <div class="logo">Mobile Phone InfoHub</div>
    <nav class="nav-links">
        <a onclick="changePage('main.jsp')">Home</a>
        <a onclick="changePage('forum.jsp')">Forum</a>
        <a onclick="changePage('overview.jsp')">Data Overview</a>
        <a onclick="changePage('compare.jsp')">Comparison</a>
        <a onclick="changePage('profile.jsp')">Profile</a>
    </nav>
</header>

<main class="home-content">
    <iframe id="contentFrame" src="main.jsp" frameborder="0" style="width:100%; height:calc(100vh - 56px);"></iframe>
</main>

<!-- 常驻主题切换按钮 -->
<div class="theme-toggle-container">
    <jsp:include page="/sub/themeToggle.jsp" />
</div>

<script>
    function changePage(url) {
        document.getElementById('contentFrame').src = url;
    }
</script>
</body>
</html>
