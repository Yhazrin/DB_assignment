<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Forum - MobilePhoneSys</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/forum.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>
<div class="main-container">
  <aside class="forum-sidebar">
    <div class="sidebar-section">
      <button id="newForumBtn" class="btn-new">New Forum</button>
    </div>
    <div class="sidebar-section">
      <div class="forum-list-container">
        <ul class="category-list" id="forumList">
        </ul>
      </div>
    </div>
  </aside>
  <div class="forum-main">

    <div class="content-header">
      <h2 id="currentForumTitle">Select a Forum</h2>
      <button id="newPostBtn" class="color-btn" disabled>New Post</button>
    </div>

    <!-- Post list -->
    <div class="topic-list" id="postList">
      <!-- populated by forum.js -->
    </div>

    <!-- Shown when no posts exist in a forum -->
    <div class="no-topics" id="noPosts" style="display:none;">
      <i class="icon-info"></i>
      <p>No posts yet. Be the first to post!</p>
    </div>

  </div>
</div>
<!-- Central input modal -->
<div id="inputModal" class="modal hidden">
  <div class="modal-content">
    <h3 id="modalHeader">Title</h3>
    <form id="modalForm">
      <!-- JS dynamically inserts <label>+<input> or <textarea> -->
    </form>
    <div class="modal-buttons">
      <button type="button" id="modalCancel">Cancel</button>
      <button type="submit" form="modalForm" id="modalOk">Confirm</button>
    </div>
  </div>
</div>

<jsp:include page="sub/scripts.jsp"/>
<script src="${pageContext.request.contextPath}/assets/js/forum.js"></script>
</body>
</html>
