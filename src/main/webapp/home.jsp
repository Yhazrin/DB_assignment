<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overview - Mobile Phone Query System</title>
    <!-- 本页专属样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <jsp:include page="header.jsp"/>
    <jsp:include page="sub/themeToggle.jsp" />
</head>
<body>

<main>
    <!-- 核心功能列表 -->
    <section class="features">
        <h2>Core Features</h2>
        <ul>
            <c:forEach var="feature" items="${features}">
                <li>${feature}</li>
            </c:forEach>
        </ul>
    </section>

    <!-- 用户指南 -->
    <section class="user-guide">
        <h2>User Guide</h2>
        <ol>
            <c:forEach var="step" items="${userGuideSteps}">
                <li>${step}</li>
            </c:forEach>
        </ol>
    </section>

    <!-- 技术架构描述 -->
    <section class="tech-arch">
        <h2>Technical Architecture</h2>
        <p>${techArchitecture}</p>
    </section>

    <!-- 代码示例 -->
    <section class="code-snippet">
        <pre><code>${codeSnippet}</code></pre>
    </section>

    <!-- 页脚 -->
    <section class="footer">
        <p>&copy; 2025 Mobile Phone Query System. Powered by Java &amp; MySQL — fast, reliable, and feature-rich.</p>
    </section>
</main>

</body>
</html>
