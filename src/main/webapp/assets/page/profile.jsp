<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // Determine which section to show: info, devices, or activity
  String currentSection = request.getParameter("section");
  if (currentSection == null || !(currentSection.equals("devices") || currentSection.equals("activity"))) {
    currentSection = "info";
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
  <!-- Theme variables -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/profile/profile.css">
</head>
<body>
<!-- Global header -->
<jsp:include page="sub/header.jsp" />

<!-- Main layout container: sidebar + content -->
<div class="main-container">

  <!-- Sidebar -->
  <aside class="profile-sidebar">
    <!-- User Card -->
    <div class="sidebar-section user-card">
      <div class="avatar-wrapper">
        <img src="${user.avatarUrl}" alt="Avatar">
      </div>
      <h3 class="user-nickname">${user.nickname}</h3>
      <p class="user-role">Role: ${user.role}</p>
      <p class="user-level">Level: ${user.level}</p>
    </div>

    <!-- Social Stats -->
    <div class="sidebar-section social-stats">
      <div class="stat-item">Posts: <strong>${user.postCount}</strong></div>
      <div class="stat-item">Likes: <strong>${user.likes}</strong></div>
      <div class="stat-item">Followers: <strong>${user.followers}</strong></div>
    </div>

    <!-- Navigation -->
    <div class="sidebar-section sidebar-nav">
      <a href="?section=info" class="nav-item ${currentSection == 'info' ? 'active' : ''}">Basic Information</a>
      <a href="?section=devices" class="nav-item ${currentSection == 'devices' ? 'active' : ''}">Devices</a>
      <a href="?section=activity" class="nav-item ${currentSection == 'activity' ? 'active' : ''}">Activity</a>
    </div>

    <div class="sidebar-section">
      <a href="${pageContext.request.contextPath}/logout" class="nav-item danger">Logout</a>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="profile-main">
    <div class="profile-content profile-content">
      <!-- Breadcrumb -->
      <div class="content-header">
        <div class="breadcrumb">
          <a href="${pageContext.request.contextPath}/">Home</a> &gt; <span>Profile</span>
        </div>
      </div>

      <!-- Sections -->
      <section id="info" class="content-section ${currentSection == 'info' ? 'active' : ''}">
        <h2 class="section-title">Basic Information</h2>
        <div class="info-grid">
          <div class="info-item">Name: ${user.realName}</div>
          <div class="info-item">Email: ${user.email}</div>
          <div class="info-item">Member Since: ${user.registerDate}</div>
        </div>
      </section>

      <section id="devices" class="content-section ${currentSection == 'devices' ? 'active' : ''}">
        <h2 class="section-title">Device Management</h2>
        <div class="device-grid">
          <c:forEach var="dev" items="${user.devices}">
            <div class="device-card">
              <img src="${dev.icon}" alt="${dev.name}">
              <h3>${dev.name}</h3>
              <p>${dev.description}</p>
              <a href="editDevice?id=${dev.id}" class="device-btn">Edit</a>
            </div>
          </c:forEach>
        </div>
      </section>

      <section id="activity" class="content-section ${currentSection == 'activity' ? 'active' : ''}">
        <h2 class="section-title">Activity Log</h2>
        <div class="activity-feed">
          <c:forEach var="act" items="${user.activities}">
            <div class="activity-item">
              <p>${act.message}</p>
              <div class="activity-date">${act.time}</div>
            </div>
          </c:forEach>
        </div>
      </section>

    </div>
  </main>

</div>
<jsp:include page="sub/scripts.jsp"/>
</body>
</html>
