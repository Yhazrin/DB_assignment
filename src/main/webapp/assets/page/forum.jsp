<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Forum - Mobile Phone Info System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/layout.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/banner.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/forum.css">
</head>
<body data-context-path="${pageContext.request.contextPath}" data-user-logged-in="${not empty sessionScope.user}">
<!-- Navigation bar -->
<jsp:include page="sub/header.jsp" />

<!-- Main container -->
<div class="main-container">
  <!-- Sidebar -->
  <aside class="forum-sidebar glass-card">
    <!-- Category navigation -->
    <section class="sidebar-section">
      <h2 class="sidebar-title">Categories</h2>
      <ul class="category-list">
        <li><a href="#" class="active">All Topics <span class="count">(128)</span></a></li>
        <li><a href="#">Announcements <span class="count">(5)</span></a></li>
        <li><a href="#">Technical Discussion <span class="count">(47)</span></a></li>
        <li><a href="#">Project Sharing <span class="count">(32)</span></a></li>
        <li><a href="#">Idle Chat <span class="count">(44)</span></a></li>
      </ul>
    </section>

    <!-- Quick actions -->
    <section class="sidebar-section">
      <h2 class="sidebar-title">Quick Actions</h2>
      <div class="nav-buttons">
        <button class="btn glass"><i class="fas fa-plus"></i> New Topic</button>
        <button class="btn glass"><i class="fas fa-user"></i> My Topics</button>
        <button class="btn glass"><i class="fas fa-bell"></i> Received Replies</button>
      </div>
    </section>

    <!-- Usage guide -->
    <section class="sidebar-section">
      <h2 class="sidebar-title">Usage Guide</h2>
      <ul class="guide-list">
        <li><a href="#"><i class="fas fa-book"></i> New User Guide</a></li>
        <li><a href="#"><i class="fas fa-shield-alt"></i> Community Rules</a></li>
        <li><a href="#"><i class="fas fa-search"></i> Search Topics</a></li>
        <li><a href="#"><i class="fas fa-question-circle"></i> FAQ</a></li>
      </ul>
    </section>
  </aside>

  <!-- Main content area -->
  <main class="forum-main">
    <div class="forum-content">
      <!-- Title and sorting -->
      <div class="content-header">
        <div class="breadcrumb">
          <a href="#">Home</a> &gt; <span>Forum</span>
        </div>
        <div class="sort-filter">
          <label for="sort-select">Sort by:</label>
          <select id="sort-select">
            <option>Newest First</option>
            <option>Most Replies</option>
            <option>Most Views</option>
          </select>
        </div>
      </div>

      <!-- Topic list -->
      <ul class="topic-list">
        <!-- Single topic item -->
        <li class="topic-item interactive">
          <div class="topic-icon"><i class="fas fa-comments"></i></div>
          <div class="topic-main">
            <h3 class="topic-title">
              <a href="#">Forum Interface Setup Example and Best Practices</a>
            </h3>
            <div class="topic-meta">
              <span class="stat views"><i class="fas fa-eye"></i> 342</span>
              <span class="stat replies"><i class="fas fa-reply"></i> 27</span>
              <span class="stat likes"><i class="fas fa-thumbs-up"></i> 58</span>
            </div>
          </div>
          <div class="topic-last-reply">
            <span class="reply-author">John</span><br>
            <span class="reply-time">1 hour ago</span>
          </div>
        </li>
        <!-- More topic items... -->
      </ul>

      <!-- Pagination -->
      <div class="pagination">
        <a href="#" class="page-link prev"><i class="fas fa-chevron-left"></i> Previous</a>
        <a href="#" class="page-link current">1</a>
        <a href="#" class="page-link">2</a>
        <a href="#" class="page-link next">Next <i class="fas fa-chevron-right"></i></a>
      </div>
    </div>

    <!-- Back to top -->
    <button class="back-to-top"><i class="fas fa-arrow-up"></i></button>
  </main>
</div>

<!-- Scripts -->
<jsp:include page="sub/scripts.jsp" />
<script src="${pageContext.request.contextPath}/assets/js/forum.js"></script>
</body>
</html>
