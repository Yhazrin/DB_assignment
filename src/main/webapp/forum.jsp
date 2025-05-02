<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>论坛 - 手机信息系统</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/forum.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="sub/header.jsp" />

<div class="forum-container">
  <!-- 顶部横幅 -->
  <div class="forum-banner">
    <h1>手机用户论坛</h1>
    <p>分享经验，解决问题，发现最好的手机</p>
    <div class="forum-stats">
      <div class="stat-item"><i class="fas fa-comments"></i> 主题：${totalTopics}</div>
      <div class="stat-item"><i class="fas fa-users"></i> 用户：${totalUsers}</div>
      <div class="stat-item"><i class="fas fa-clock"></i> 今日发帖：${todayPosts}</div>
    </div>
  </div>
  
  <!-- 主内容区 -->
  <div class="forum-main">
    <!-- 侧边栏 -->
    <aside class="forum-sidebar">
      <div class="sidebar-section">
        <h3 class="sidebar-title">分类</h3>
        <ul class="category-list">
          <li><a href="${pageContext.request.contextPath}/forum" class="${empty param.categoryId ? 'active' : ''}">全部主题</a></li>
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
        <h3 class="sidebar-title">快速导航</h3>
        <div class="nav-buttons">
          <a href="${pageContext.request.contextPath}/forum?action=new" class="btn primary">
            <i class="fas fa-plus-circle"></i> 发表新主题
          </a>
          <a href="${pageContext.request.contextPath}/forum?filter=popular" class="btn secondary">
            <i class="fas fa-fire"></i> 热门讨论
          </a>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3 class="sidebar-title">论坛指南</h3>
        <ul class="guide-list">
          <li><a href="#"><i class="fas fa-book"></i> 新手指南</a></li>
          <li><a href="#"><i class="fas fa-shield-alt"></i> 社区规则</a></li>
          <li><a href="#"><i class="fas fa-question-circle"></i> 常见问题</a></li>
        </ul>
      </div>
    </aside>
    
    <!-- 主题列表区 -->
    <div class="forum-content">
      <!-- 分类标题和面包屑导航 -->
      <div class="content-header">
        <div class="breadcrumb">
          <a href="${pageContext.request.contextPath}/home">首页</a> &gt; 
          <a href="${pageContext.request.contextPath}/forum">论坛</a>
          <c:if test="${not empty currentCategory}">
            &gt; <span>${currentCategory.name}</span>
          </c:if>
        </div>
        
        <div class="sort-filter">
          <span>排序方式：</span>
          <select id="sortOrder" onchange="changeSortOrder()">
            <option value="newest" ${param.sort == 'newest' || empty param.sort ? 'selected' : ''}>最新</option>
            <option value="hottest" ${param.sort == 'hottest' ? 'selected' : ''}>最热</option>
            <option value="mostReplies" ${param.sort == 'mostReplies' ? 'selected' : ''}>回复最多</option>
          </select>
        </div>
      </div>
      
      <!-- 主题列表 -->
      <div class="topic-list">
        <c:if test="${empty topics}">
          <div class="no-topics">
            <i class="fas fa-comment-slash"></i>
            <p>暂无主题</p>
            <a href="${pageContext.request.contextPath}/forum?action=new" class="btn primary">发表第一个主题</a>
          </div>
        </c:if>
        
        <c:forEach var="topic" items="${topics}">
          <div class="topic-item ${topic.isPinned ? 'pinned' : ''}">
            <div class="topic-icon">
              <c:choose>
                <c:when test="${topic.isPinned}">
                  <i class="fas fa-thumbtack" title="置顶"></i>
                </c:when>
                <c:when test="${(topic_extras[topic.id].replyCount) > 20}">
                  <i class="fas fa-fire" title="热门"></i>
                </c:when>
                <c:otherwise>
                  <i class="fas fa-comments"></i>
                </c:otherwise>
              </c:choose>
            </div>
            
            <div class="topic-main">
              <div class="topic-title">
                <a href="${pageContext.request.contextPath}/forum?action=view&id=${topic.id}">${topic.title}</a>
                <c:if test="${topic.isPinned}"><span class="topic-tag pinned">置顶</span></c:if>
              </div>
              
              <div class="topic-meta">
                <span class="topic-category">${topic.categoryName}</span>
                <span class="topic-author">作者: ${topic.author}</span>
                <span class="topic-time">
                  <fmt:formatDate value="${topic.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
              </div>
            </div>
            
            <div class="topic-stats">
              <div class="stat views" title="浏览次数">
                <i class="fas fa-eye"></i> ${topic.views}
              </div>
              <div class="stat replies" title="回复次数">
                <i class="fas fa-comment"></i> ${topic_extras[topic.id].replyCount}
              </div>
              <div class="stat likes" title="点赞数">
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
                <div class="no-reply">暂无回复</div>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
      
      <!-- 分页 -->
      <c:if test="${totalPages > 1}">
        <div class="pagination">
          <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/forum?page=${currentPage - 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link prev">
              <i class="fas fa-chevron-left"></i> 上一页
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
              下一页 <i class="fas fa-chevron-right"></i>
            </a>
          </c:if>
        </div>
      </c:if>
    </div>
  </div>
</div>

<!-- 通用脚本 -->
<jsp:include page="sub/scripts.jsp" />

<script>
function changeSortOrder() {
  const sortOrder = document.getElementById('sortOrder').value;
  const url = new URL(window.location.href);
  url.searchParams.set('sort', sortOrder);
  window.location.href = url.toString();
}

// 添加回到顶部功能
document.addEventListener('DOMContentLoaded', function() {
  // 创建回到顶部按钮
  const backToTop = document.createElement('button');
  backToTop.className = 'back-to-top';
  backToTop.innerHTML = '<i class="fas fa-arrow-up"></i>';
  document.body.appendChild(backToTop);
  
  // 监听滚动事件
  window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
      backToTop.classList.add('show');
    } else {
      backToTop.classList.remove('show');
    }
  });
  
  // 点击回到顶部
  backToTop.addEventListener('click', function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
});
</script>
</body>
</html>