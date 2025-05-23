<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/profile.css"> <!-- Include profile page specific CSS -->
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="sub/header.jsp" /> <!-- Include the header page -->

<div class="main-container">
  <aside class="profile-sidebar glass-card">
    <div class="sidebar-section sidebar-nav">
      <a href="#" data-section="info" class="nav-item active">Information</a> <!-- Information section link -->
      <a href="#" data-section="devices" class="nav-item">Devices</a> <!-- Devices section link -->
      <a href="#" data-section="activity" class="nav-item">Activity</a> <!-- Activity section link -->
    </div>

    <div class="sidebar-section">
      <button id="logoutBtn" class="nav-item danger">Logout</button> <!-- Logout button -->
    </div>
  </aside>

  <main class="profile-main">
    <div class="profile-content glass-card">
      <div class="content-header">
        <div class="breadcrumb">
          <a href="${pageContext.request.contextPath}/">Home</a> &gt; <span>Profile</span> <!-- Breadcrumb navigation -->
        </div>
      </div>

      <!-- Basic Information section -->
      <section id="info" class="content-section active">
        <h2 class="section-title">Basic Information</h2>
        <div class="info-grid">
          <div class="info-item">Name: <span id="userName"></span></div> <!-- Display user name -->
          <div class="info-item">Email: <span id="email"></span></div> <!-- Display user email -->
          <div class="info-item">Member Since: <span id="registerDate">—</span></div> <!-- Display member since date -->
        </div>
      </section>

      <!-- Device Management section (currently empty) -->
      <section id="devices" class="content-section">
        <h2 class="section-title">Device Management</h2>
        <p>no data</p> <!-- Placeholder text for empty section -->
      </section>

      <!-- Activity Log section (currently empty) -->
      <section id="activity" class="content-section">
        <h2 class="section-title">Activity Log</h2>
        <p>no data</p> <!-- Placeholder text for empty section -->
      </section>
    </div>
  </main>
</div>

<jsp:include page="sub/scripts.jsp"/> <!-- Include additional scripts -->
<script src="${pageContext.request.contextPath}/assets/js/profile.js"></script> <!-- Include profile page specific JavaScript -->
</body>
</html>
