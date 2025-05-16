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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/banner.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/forum.css">
</head>
<body data-context-path="${pageContext.request.contextPath}" data-user-logged-in="${not empty sessionScope.user}">
<!-- Navigation bar -->
<jsp:include page="sub/header.jsp" />

<div class="main-container">
  <!-- Top banner -->
  <div class="banner">
    <h1>Mobile Phone User Forum</h1>
    <p>Share experiences, solve problems, discover the best phones</p>
  </div>

  <!-- Main content area -->
  <div class="forum-main">
    <!-- Sidebar -->
    <aside class="forum-sidebar">
      <div class="sidebar-section">
        <h3 class="sidebar-title">Categories</h3>
        <ul class="category-list">
          <li><a href="${pageContext.request.contextPath}/forum" class="${empty param.categoryId ? 'active' : ''}">All Topics</a></li>
          <c:forEach var="category" items="${categories}">
            <li>
              <a href="${pageContext.request.contextPath}/forum?categoryId=${category.id}"
                 class="${param.categoryId == category.id ? 'active' : ''}">
                ${category.name} <span class="count">(${category.topicCount})</span>
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>

      <div class="sidebar-section">
        <h3 class="sidebar-title">Quick Navigation</h3>
        <div class="nav-buttons">
          <a href="${pageContext.request.contextPath}/forum?action=new" class="btn primary glass">
            <i class="fas fa-plus-circle"></i> Post New Topic
          </a>
          <a href="${pageContext.request.contextPath}/forum?filter=popular" class="btn secondary glass">
            <i class="fas fa-fire"></i> Popular Discussions
          </a>
        </div>
      </div>

      <div class="sidebar-section">
        <h3 class="sidebar-title">Forum Guidelines</h3>
        <ul class="guide-list">
          <li><a href="#"><i class="fas fa-book"></i> Beginner's Guide</a></li>
          <li><a href="#"><i class="fas fa-shield-alt"></i> Community Rules</a></li>
          <li><a href="#"><i class="fas fa-question-circle"></i> FAQ</a></li>
        </ul>
      </div>
    </aside>

    <!-- Topic list area -->
    <div class="forum-content">
      <!-- Category title and breadcrumb navigation -->
      <div class="content-header">
        <nav class="breadcrumb">
          <a href="${pageContext.request.contextPath}/">Home</a> &gt; <span>Forum</span>
        </nav>
        <div class="forum-stats">
          <span class="stat-item"><i class="fas fa-comments"></i> Topics: ${totalTopics}</span>
          <span class="stat-item"><i class="fas fa-users"></i> Users: ${totalUsers}</span>
          <span class="stat-item"><i class="fas fa-clock"></i> Today's Posts: ${todayPosts}</span>
        </div>

        <div class="sort-filter">
          <span>Sort by:</span>
          <select id="sortOrder" onchange="changeSortOrder()">
            <option value="newest" ${param.sort == 'newest' || empty param.sort ? 'selected' : ''}>Newest</option>
            <option value="hottest" ${param.sort == 'hottest' ? 'selected' : ''}>Hottest</option>
            <option value="mostReplies" ${param.sort == 'mostReplies' ? 'selected' : ''}>Most Replies</option>
          </select>
        </div>
      </div>

      <!-- Topic list -->
      <div class="topic-list">
        <c:if test="${empty topics}">
          <div class="no-topics">
            <i class="fas fa-comment-slash"></i>
            <p>No topics yet</p>
            <a href="${pageContext.request.contextPath}/forum?action=new" class="btn primary">Post the first topic</a>
          </div>
        </c:if>

        <c:forEach var="topic" items="${topics}">
          <div class="topic-item ${topic.isPinned ? 'pinned' : ''}">
            <div class="topic-icon">
              <c:choose>
                <c:when test="${topic.isPinned}">
                  <i class="fas fa-thumbtack" title="Pinned"></i>
                </c:when>
                <c:when test="${(topic_extras[topic.id].replyCount) > 20}">
                  <i class="fas fa-fire" title="Hot"></i>
                </c:when>
                <c:otherwise>
                  <i class="fas fa-comments"></i>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="topic-main">
              <div class="topic-title">
                <a href="${pageContext.request.contextPath}/forum?action=view&id=${topic.id}">${topic.title}</a>
                <c:if test="${topic.isPinned}"><span class="topic-tag pinned">Pinned</span></c:if>
              </div>

              <div class="topic-meta">
                <span class="topic-category">${topic.categoryName}</span>
                <span class="topic-author">Author: ${topic.author}</span>
                <span class="topic-time">
                  <fmt:formatDate value="${topic.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
              </div>
            </div>

            <div class="topic-stats">
              <div class="stat views" title="View count">
                <i class="fas fa-eye"></i> ${topic.views}
              </div>
              <div class="stat replies" title="Reply count">
                <i class="fas fa-comment"></i> ${topic_extras[topic.id].replyCount}
              </div>
              <div class="stat likes" title="Like count">
                <i class="fas fa-heart"></i> ${topic.likes}
              </div>
            </div>

            <div class="topic-last-reply">
              <c:if test="${topic_extras[topic.id].lastReply != null}">
                <div class="last-reply-info">
                  <div class="reply-author">${topic_extras[topic.id].lastReply.author}</div>
                  <div class="reply-time">
                    <fmt:formatDate value="${topic_extras[topic.id].lastReply.createdAt}" pattern="MM-dd HH:mm"/>
                  </div>
                </div>
              </c:if>
              <c:if test="${topic_extras[topic.id].lastReply == null}">
                <div class="no-reply">No replies yet</div>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Pagination -->
      <c:if test="${totalPages > 1}">
        <div class="pagination">
          <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/forum?page=${currentPage - 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link prev">
              <i class="fas fa-chevron-left"></i> Previous
            </a>
          </c:if>

          <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
              <c:when test="${i == currentPage}">
                <span class="page-link current">${i}</span>
              </c:when>
              <c:otherwise>
                <a href="${pageContext.request.contextPath}/forum?page=${i}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/forum?page=${currentPage + 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link next">
              Next <i class="fas fa-chevron-right"></i>
            </a>
          </c:if>
        </div>
      </c:if>
    </div>
  </div>
</div>

<!-- 通用脚本 -->
<jsp:include page="sub/scripts.jsp" />

<!-- 引入论坛专用脚本 -->
<script src="${pageContext.request.contextPath}/assets/js/forum.js"></script>
</body>
</html>