<%--
  Created by IntelliJ IDEA.
  User: 20544
  Date: 2025/4/30
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar">
    <div class="logo">MobilePhoneSys</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/overview.jsp">Overview</a>
        <a href="${pageContext.request.contextPath}/compare.jsp">Compare</a>
        <a href="${pageContext.request.contextPath}/forum.jsp">Forum</a>
        <a href="${pageContext.request.contextPath}/profile.jsp">Profile</a>
    </div>
    <div class="theme-toggle-container">
        <button class="theme-toggle-btn" type="button">🌙</button>
    </div>
</nav>

