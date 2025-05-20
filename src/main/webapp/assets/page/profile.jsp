<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/profile.css">
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="sub/header.jsp" />

<div class="main-container">
  <aside class="profile-sidebar glass-card">
    <!-- 如果后端暂时不返回头像和等级，可以隐藏这些 -->
    <!--
    <div class="sidebar-section user-card" id="userCard">
      <div class="avatar-wrapper">
        <img id="avatarImg" src="" alt="Avatar">
      </div>
      <p class="user-nickname">Name: <span id="nickname"></span></p>
      <p class="user-level">Level: <span id="level"></span></p>
    </div>
    <div class="sidebar-section social-stats" id="socialStats">
      <div class="stat-item">Posts: <strong id="postCount"></strong></div>
      <div class="stat-item">Likes: <strong id="likesCount"></strong></div>
      <div class="stat-item">Followers: <strong id="followersCount"></strong></div>
    </div>
    -->

    <div class="sidebar-section sidebar-nav">
      <a href="#" data-section="info" class="nav-item active">Information</a>
      <!-- 其余版块先留着，但进去会是空的 -->
      <a href="#" data-section="devices" class="nav-item">Devices</a>
      <a href="#" data-section="activity" class="nav-item">Activity</a>
    </div>

    <div class="sidebar-section">
      <button id="logoutBtn" class="nav-item danger">Logout</button>
    </div>
  </aside>

  <main class="profile-main">
    <div class="profile-content glass-card">
      <div class="content-header">
        <div class="breadcrumb">
          <a href="${pageContext.request.contextPath}/">Home</a> &gt; <span>Profile</span>
        </div>
      </div>

      <!-- 信息区 -->
      <section id="info" class="content-section active">
        <h2 class="section-title">Basic Information</h2>
        <div class="info-grid">
          <div class="info-item">Name: <span id="userName"></span></div>
          <div class="info-item">Email: <span id="email"></span></div>
          <div class="info-item">Member Since: <span id="registerDate">—</span></div>
        </div>
      </section>

      <!-- 设备区（后端未返回，暂为空） -->
      <section id="devices" class="content-section">
        <h2 class="section-title">Device Management</h2>
        <p>暂无数据</p>
      </section>

      <!-- 活动区（后端未返回，暂为空） -->
      <section id="activity" class="content-section">
        <h2 class="section-title">Activity Log</h2>
        <p>暂无数据</p>
      </section>
    </div>
  </main>
</div>

<jsp:include page="sub/scripts.jsp"/>
<script src="${pageContext.request.contextPath}/assets/js/profile.js"></script>
</body>
</html>
