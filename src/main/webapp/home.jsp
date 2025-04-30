<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HOME - Mobile Phone Query System</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">
    <!-- 导航栏 -->

</head>
<body>
    <jsp:include page="sub/header.jsp"/>
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
    </main>
    <jsp:include page="sub/scripts.jsp"/>
</body>
</html>
