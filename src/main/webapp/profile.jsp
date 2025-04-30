<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Profile - Mobile InfoHub</title>
  <!-- 公共样式 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css">
</head>
<body>
<!-- 导航栏（包含主题切换按钮） -->
<jsp:include page="sub/header.jsp" />

<div class="profile-container">
  <!-- 侧边导航 -->
  <aside class="profile-sidebar">
    <div class="user-card">
      <div class="avatar-wrapper">
        <img src="${user.avatar}" alt="用户头像" class="user-avatar" />
        <button class="avatar-upload">更换头像</button>
      </div>
      <h2 class="user-nickname">${user.nickname}</h2>
      <p class="user-level">VIP ${user.level}</p>
      <!-- 社交与成就系统：关注信息与徽章 -->
      <div class="social-stats">
        <button class="btn">关注 ${user.followingCount}</button>
        <button class="btn">粉丝 ${user.followersCount}</button>
      </div>
      <div class="badge-list">
        <c:forEach items="${user.badges}" var="badge">
          <span class="badge">${badge}</span>
        </c:forEach>
      </div>
    </div>
    <nav class="sidebar-nav">
      <button type="button" class="nav-item active" data-section="profile">个人资料</button>
      <button type="button" class="nav-item" data-section="devices">我的设备</button>
      <button type="button" class="nav-item" data-section="security">账户安全</button>
      <button type="button" class="nav-item" data-section="analytics">数据统计</button>
      <button type="button" class="nav-item" data-section="activity">个人发布动态</button>
    </nav>
  </aside>

  <!-- 主内容区 -->
  <main class="profile-main">
    <!-- 个人信息模块（可编辑） -->
    <section id="profile" class="content-section active">
      <h2 class="section-title">基本信息 <button id="edit-profile-btn" class="btn small">编辑</button></h2>
      <div id="profile-view">
        <div class="info-grid">
          <div class="info-item">
            <label>注册时间</label>
            <p>${user.registerDate}</p>
          </div>
          <div class="info-item">
            <label>电子邮箱</label>
            <p>${user.email}</p>
          </div>
          <div class="info-item">
            <label>手机号码</label>
            <p>${user.phone}</p>
          </div>
        </div>
      </div>
      <div id="profile-edit" style="display:none;">
        <form action="${pageContext.request.contextPath}/profile/update" method="post">
          <div class="info-grid">
            <div class="info-item">
              <label for="email">电子邮箱</label>
              <input type="email" id="email" name="email" value="${user.email}" required />
            </div>
            <div class="info-item">
              <label for="phone">手机号码</label>
              <input type="text" id="phone" name="phone" value="${user.phone}" required />
            </div>
          </div>
          <button type="submit" class="btn primary">保存</button>
          <button type="button" id="cancel-edit-btn" class="btn light">取消</button>
        </form>
      </div>
    </section>

    <!-- 我的设备模块（支持移除和导出） -->
    <section id="devices" class="content-section">
      <div class="section-header">
        <h2 class="section-title">已关联设备</h2>
        <div>
          <input type="text" id="device-search" placeholder="搜索设备..." class="form-input small" />
          <button id="export-devices-btn" class="btn small">导出 CSV</button>
          <button class="add-device-btn btn small">+ 添加新设备</button>
        </div>
      </div>
      <div class="device-grid">
        <c:forEach items="${devices}" var="device">
          <div class="device-card" data-model="${device.model}">
            <img src="${device.image}" class="device-thumb" />
            <h3>${device.model}</h3>
            <p>最后使用：${device.lastUsed}</p>
            <button class="btn small danger remove-device-btn" data-id="${device.id}">移除</button>
          </div>
        </c:forEach>
      </div>
    </section>

    <!-- 账户安全模块 -->
    <section id="security" class="content-section">
      <h2 class="section-title">账户安全</h2>
      <p>在这里添加安全选项设置表单。</p>
    </section>

    <!-- 数据统计模块 -->
    <section id="analytics" class="content-section">
      <h2 class="section-title">使用数据统计</h2>
      <div class="chart-container">
        <canvas id="usageChart"></canvas>
      </div>
    </section>

    <!-- 个人发布动态模块 -->
    <section id="activity" class="content-section">
      <h2 class="section-title">个人发布动态</h2>
      <div class="activity-feed">
        <c:forEach items="${activities}" var="act">
          <div class="activity-item">
            <p>${act.content}</p>
            <span class="activity-date">${act.date}</span>
          </div>
        </c:forEach>
      </div>
    </section>
  </main>
</div>

<!-- 通用脚本（含主题切换、图表等） -->
<jsp:include page="/sub/scripts.jsp" />

<!-- 本页脚本：处理编辑切换、搜索及导出 -->
<script>
  document.getElementById('edit-profile-btn').addEventListener('click', () => {
    document.getElementById('profile-view').style.display = 'none';
    document.getElementById('profile-edit').style.display = 'block';
  });
  document.getElementById('cancel-edit-btn').addEventListener('click', () => {
    document.getElementById('profile-edit').style.display = 'none';
    document.getElementById('profile-view').style.display = 'block';
  });

  document.getElementById('device-search').addEventListener('input', e => {
    const query = e.target.value.toLowerCase();
    document.querySelectorAll('.device-card').forEach(card => {
      card.style.display = card.dataset.model.toLowerCase().includes(query) ? '' : 'none';
    });
  });

  document.getElementById('export-devices-btn').addEventListener('click', () => {
    const devices = Array.from(document.querySelectorAll('.device-card')).map(card => ({ model: card.dataset.model, lastUsed: card.querySelector('p').textContent.replace('最后使用：','') }));
    let csv = '型号,最后使用日期\n';
    devices.forEach(d => csv += `${d.model},${d.lastUsed}\n`);\n      const blob = new Blob([csv], { type: 'text/csv;charset=UTF-8' });
    const link = document.createElement('a'); link.href = URL.createObjectURL(blob); link.download = 'devices.csv'; link.click();
  });

  document.querySelectorAll('.remove-device-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      if (confirm('确定要移除该设备吗？')) {
        const id = btn.dataset.id;
        fetch(`${pageContext.request.contextPath}/profile/device/remove?id=${id}`, { method: 'POST' }).then(() => btn.closest('.device-card').remove());
      }
    });
  });
</script>
</body>
</html>
