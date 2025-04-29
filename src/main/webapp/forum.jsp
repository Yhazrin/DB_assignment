<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Forum - Mobile Phone InfoHub</title>
  <link rel="stylesheet" href="<%= ctx %>/assets/css/common.css" />
  <link rel="stylesheet" href="<%= ctx %>/assets/css/forum.css" />
</head>
<body>

<div class="forum-container">
  <!-- 侧边栏：机型列表 -->
  <aside class="sidebar">
    <h2 class="sidebar-title">Select Model</h2>
    <ul class="model-list">
      <c:forEach var="model" items="${models}">
        <li data-id="${model.id}"
            class="model-item ${model.id == selectedModel.id ? 'selected' : ''}">
          <span class="model-name">${model.name}</span>
          <span class="model-rating">★ ${model.avgRating}</span>
        </li>
      </c:forEach>
    </ul>
  </aside>

  <!-- 主讨论区 -->
  <main class="discussion-main">
    <h2 class="discussion-title">${selectedModel.name} Discussion</h2>

    <div class="posts-container">
      <c:forEach var="post" items="${posts}">
        <article class="post-card">
          <div class="post-header">
            <h3 class="post-title">${post.title}</h3>
            <div class="post-meta">
              <span class="author">${post.author}</span>
              <span class="date">${post.date}</span>
              <span class="rating">Rating: ${post.rating}/5</span>
            </div>
          </div>
          <p class="post-content">${post.content}</p>
        </article>
      </c:forEach>
      <c:if test="${empty posts}">
        <div class="empty-prompt">
          <p>No posts yet. Be the first to comment!</p>
        </div>
      </c:if>
    </div>

    <!-- 评论表单 -->
    <form class="comment-form" action="<%= ctx %>/forum/comment" method="post">
      <h3 class="form-title">Leave a Comment</h3>
      <input type="hidden" name="modelId" value="${selectedModel.id}" />

      <div class="form-group">
        <label for="rating" class="form-label">Rating</label>
        <select id="rating" name="rating" class="form-select">
          <c:forEach var="i" begin="1" end="5">
            <option value="${i}">${i} Star</option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="content" class="form-label">Your Comment</label>
        <textarea id="content" name="content" rows="5"
                  class="form-textarea"
                  placeholder="Share your experience..."></textarea>
      </div>

      <button type="submit" class="submit-btn">Post Comment</button>
    </form>
  </main>
</div>

<script>
  // 机型选择交互
  document.querySelectorAll('.model-item').forEach(item => {
    item.addEventListener('click', () => {
      const modelId = item.dataset.id;
      window.location.href = `<%= ctx %>/forum?modelId=${modelId}`;
    });
  });
</script>
</body>
</html>