<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Forum - Mobile Phone Query System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/forum.css" />
</head>
<body>
<!-- 导航栏（包含主题切换按钮） -->
<jsp:include page="sub/header.jsp" />

<main class="forum-container">
  <!-- 侧边栏 -->
  <aside class="sidebar">
    <h2 class="sidebar-title">Discussion Models</h2>
    <ul class="model-list">
      <c:forEach var="model" items="${models}">
        <li class="model-item ${model.selected ? 'selected' : ''}" data-id="${model.id}">
            ${model.name}
        </li>
      </c:forEach>
    </ul>
  </aside>

  <!-- 主讨论区 -->
  <section class="discussion-main">
    <h1 class="discussion-title">${currentTopic.title}</h1>
    <c:forEach var="post" items="${posts}">
      <div class="post-card">
        <div class="post-header">
          <h2 class="post-title">${post.title}</h2>
          <div class="post-meta">By ${post.author} on ${post.date}</div>
        </div>
        <div class="post-body">${post.content}</div>
      </div>
    </c:forEach>

    <!-- 评论表单 -->
    <form class="comment-form" action="${pageContext.request.contextPath}/forum/comment" method="post">
      <h2 class="form-title">Add a Comment</h2>
      <div class="form-group">
        <label class="form-label" for="author">Name</label>
        <input type="text" id="author" name="author" class="form-input" required />
      </div>
      <div class="form-group">
        <label class="form-label" for="content">Comment</label>
        <textarea id="content" name="content" class="form-textarea" rows="5" required></textarea>
      </div>
      <button type="submit" class="btn primary">Submit</button>
    </form>
  </section>
</main>
<!-- 通用脚本（含主题切换逻辑） -->
<jsp:include page="sub/scripts.jsp" />
</body>
</html>
