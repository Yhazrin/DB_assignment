<%-- profile.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>用户中心 - Mobile InfoHub</title>
  <link rel="stylesheet" href="assets/css/profile.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <jsp:include page="header.jsp"/>
</head>
<body>
<div class="profile-container">
  <!-- 侧边导航 -->
  <aside class="profile-sidebar">
    <div class="user-card">
      <div class="avatar-wrapper">
        <img src="${user.avatar}" alt="用户头像" class="user-avatar">
        <button class="avatar-upload">更换头像</button>
      </div>
      <h2 class="user-nickname">${user.nickname}</h2>
      <p class="user-level">VIP ${user.level}</p>
    </div>

    <nav class="sidebar-nav">
      <a href="#profile" class="nav-item active">个人资料</a>
      <a href="#devices" class="nav-item">我的设备</a>
      <a href="#security" class="nav-item">账户安全</a>
      <a href="#analytics" class="nav-item">数据统计</a>
    </nav>
  </aside>

  <!-- 主内容区 -->
  <main class="profile-main">
    <!-- 个人信息模块 -->
    <section id="profile" class="content-section active">
      <h2 class="section-title">基本信息</h2>
      <div class="info-grid">
        <div class="info-item">
          <label>注册时间</label>
          <p>${user.registerDate}</p>
        </div>
        <div class="info-item">
          <label>电子邮箱</label>
          <p>${user.email} <button class="edit-btn">修改</button></p>
        </div>
        <div class="info-item">
          <label>手机号码</label>
          <p>${user.phone} <button class="edit-btn">更换</button></p>
        </div>
      </div>
    </section>

    <!-- 我的设备模块 -->
    <section id="devices" class="content-section">
      <div class="section-header">
        <h2 class="section-title">已关联设备</h2>
        <button class="add-device-btn">+ 添加新设备</button>
      </div>
      <div class="device-grid">
        <c:forEach items="${devices}" var="device">
          <div class="device-card">
            <img src="${device.image}" class="device-thumb">
            <h3>${device.model}</h3>
            <p>最后使用：${device.lastUsed}</p>
          </div>
        </c:forEach>
      </div>
    </section>

    <!-- 数据统计模块 -->
    <section id="analytics" class="content-section">
      <h2 class="section-title">使用数据统计</h2>
      <div class="chart-container">
        <canvas id="usageChart"></canvas>
      </div>
    </section>
  </main>
</div>

<script src="assets/js/chart.min.js"></script>
<script>
  // 图表初始化逻辑...
</script>
</body>
</html>