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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/layout.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/banner.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/forum/forum.css">
</head>
<body data-context-path="${pageContext.request.contextPath}" data-user-logged-in="${not empty sessionScope.user}">
<!-- Navigation bar -->
<jsp:include page="sub/header.jsp" />

<!-- Main container -->
<div class="main-container">
  <!-- Sidebar -->
  <aside class="forum-sidebar glass-card">
    <section class="sidebar-section">
      <div class="search-container">
        <form class="sidebar-search">
          <input type="text" placeholder="Search topics...">
        </form>
      </div>
      <div class="nav-buttons">
        <button class="search-type-btn"><i class="fas fa-plus"></i> New Topic</button>
        <button class="search-type-btn"><i class="fas fa-user"></i> My Topics</button>
        <button class="search-type-btn"><i class="fas fa-bell"></i> Received Replies</button>
      </div>
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
