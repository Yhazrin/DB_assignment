<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Overview - Mobile Phone InfoHub</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
</head>
<body>
<!-- Hero Section -->
<section class="hero">
    <h1>Build an Innovative Information Management Platform</h1>
    <p>Integrating real-time data visualization, intelligent alerts, and community collaboration to empower your decisions and team growth.</p>
    <a href="#get-started" class="btn">Get Started</a>
</section>

<!-- Cards Section -->
<section class="section-cards">
    <div class="card">
        <img src="<%= ctx %>/assets/images/overview_sample.png" alt="Data Overview">
        <div class="card-content">
            <h3>Data Overview</h3>
            <p>Visualize your data in real time and gain actionable insights.</p>
            <a href="overview.jsp" class="btn primary">Learn More</a>
        </div>
    </div>
    <div class="card">
        <img src="<%= ctx %>/assets/images/forum_sample.png" alt="Community Forum">
        <div class="card-content">
            <h3>Community Forum</h3>
            <p>Connect, discuss, and share knowledge with fellow users.</p>
            <a href="forum.jsp" class="btn primary">Visit Forum</a>
        </div>
    </div>
    <div class="card">
        <img src="<%= ctx %>/assets/images/profile_sample.png" alt="User Profile">
        <div class="card-content">
            <h3>User Profile</h3>
            <p>Manage your profile, preferences, and activity in one place.</p>
            <a href="profile.jsp" class="btn primary">View Profile</a>
        </div>
    </div>
</section>

<!-- Code Snippet Section -->
<section class="code-snippet">
    <pre><code><!-- Example: Include SDK -->
<script src="https://cdn.my-system.com/sdk/v1.0.0/sdk.js"></script>
<script>
  MySystem.init({ apiKey: 'YOUR_API_KEY' });
</script></code></pre>
</section>

<!-- Footer -->
<footer class="footer">
    &copy; 2025 Mobile Phone InfoHub. All rights reserved.
</footer>
</body>
</html>
