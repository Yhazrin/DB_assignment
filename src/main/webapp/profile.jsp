<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile - Mobile InfoHub</title>
  <!-- Common Styles -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
</head>
<body>
<!-- Navigation Bar -->
<jsp:include page="sub/header.jsp" />

<div class="main-container">
  <!-- Top Banner -->
  <header class="banner">
    <h1>User Profile</h1>
    <p>Manage your personal information, devices, and account security</p>
  </header>

  <!-- Main Two-Column Layout -->
  <div class="profile-main">
    <!-- Sidebar -->
    <aside class="profile-sidebar">
      <div class="user-card">
        <div class="avatar-wrapper">
          <img src="${user.avatar}" alt="User Avatar" class="user-avatar" />
          <button class="avatar-upload btn glass">Change Avatar</button>
        </div>
        <h2 class="user-nickname">${user.nickname}</h2>
        <p class="user-level">VIP Level ${user.level}</p>
        <!-- Social Stats & Badges -->
        <div class="social-stats">
          <button class="btn glass">Following ${user.followingCount}</button>
          <button class="btn glass">Followers ${user.followersCount}</button>
        </div>
        <div class="badge-list">
          <c:forEach items="${user.badges}" var="badge">
            <span class="badge">${badge}</span>
          </c:forEach>
        </div>
      </div>

      <nav class="sidebar-nav">
        <button type="button" class="btn" data-section="profile">Profile</button>
        <button type="button" class="btn" data-section="devices">My Devices</button>
        <button type="button" class="btn" data-section="security">Account Security</button>
        <button type="button" class="btn" data-section="analytics">Usage Analytics</button>
        <button type="button" class="btn" data-section="activity">Activity Feed</button>
        <div class="sidebar-divider"></div>
        <button type="button" class="btn" id="switch-account">Switch Account</button>
        <button type="button" class="btn btn-danger" id="logout">Log Out</button>
      </nav>
    </aside>

    <!-- Content Area -->
    <section class="profile-content">
      <!-- Profile Information Section -->
      <div id="profile" class="content-section active">
        <h2 class="section-title">Basic Information <button id="edit-profile-btn" class="btn small">Edit</button></h2>
        <div id="profile-view">
          <div class="info-grid">
            <div class="info-item">
              <label>Joined On</label>
              <p>${user.registerDate}</p>
            </div>
            <div class="info-item">
              <label>Email Address</label>
              <p>${user.email}</p>
            </div>
            <div class="info-item">
              <label>Phone Number</label>
              <p>${user.phone}</p>
            </div>
          </div>
        </div>
        <div id="profile-edit" style="display:none;">
          <form action="${pageContext.request.contextPath}/profile/update" method="post">
            <div class="info-grid">
              <div class="info-item">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="${user.email}" required />
              </div>
              <div class="info-item">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" required />
              </div>
            </div>
            <button type="submit" class="btn primary">Save</button>
            <button type="button" id="cancel-edit-btn" class="btn light">Cancel</button>
          </form>
        </div>
      </div>

      <!-- Devices Section -->
      <div id="devices" class="content-section">
        <h2 class="section-title">My Devices</h2>
        <div class="devices-card">
          <div class="section-header">
            <div class="device-buttons">
              <button id="export-devices-btn" class="btn small">Export CSV</button>
              <button class="btn small primary">+ Add New Device</button>
            </div>
          </div>
          <div class="device-grid">
            <c:forEach items="${devices}" var="device">
              <div class="device-card" data-model="${device.model}">
                <img src="${device.image}" class="device-thumb" alt="${device.model}" />
                <h3>${device.model}</h3>
                <p>Last Used: ${device.lastUsed}</p>
                <button class="btn small danger" data-id="${device.id}">Remove</button>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>

      <!-- Security Section -->
      <div id="security" class="content-section">
        <h2 class="section-title">Account Security</h2>
        <p>Add security settings form here.</p>
      </div>

      <!-- Analytics Section -->
      <div id="analytics" class="content-section">
        <h2 class="section-title">Usage Analytics</h2>
        <div class="chart-container">
          <canvas id="usageChart"></canvas>
        </div>
      </div>

      <!-- Activity Feed Section -->
      <div id="activity" class="content-section">
        <h2 class="section-title">Activity Feed</h2>
        <div class="activity-feed">
          <c:forEach items="${activities}" var="act">
            <div class="activity-item">
              <p>${act.content}</p>
              <span class="activity-date">${act.date}</span>
            </div>
          </c:forEach>
        </div>
      </div>
    </section>
  </div>
</div>

<!-- Common Scripts (theme toggle, charts, etc.) -->
<jsp:include page="/sub/scripts.jsp" />

<!-- Profile Page Specific JS -->
<script src="${pageContext.request.contextPath}/assets/js/profile.js"></script>
</body>
</html>
