/**
 * profile.js - 处理用户个人资料页面的所有交互逻辑
 */
document.addEventListener('DOMContentLoaded', function() {
  // 个人资料编辑功能
  document.getElementById('edit-profile-btn').addEventListener('click', () => {
    document.getElementById('profile-view').style.display = 'none';
    document.getElementById('profile-edit').style.display = 'block';
  });
  
  document.getElementById('cancel-edit-btn').addEventListener('click', () => {
    document.getElementById('profile-edit').style.display = 'none';
    document.getElementById('profile-view').style.display = 'block';
  });

  // 设备搜索功能
  const deviceSearchInput = document.getElementById('device-search');
  if (deviceSearchInput) {
    deviceSearchInput.addEventListener('input', e => {
      const query = e.target.value.toLowerCase();
      document.querySelectorAll('.device-card').forEach(card => {
        card.style.display = card.dataset.model.toLowerCase().includes(query) ? '' : 'none';
      });
    });
  }

  // 设备导出功能
  const exportBtn = document.getElementById('export-devices-btn');
  if (exportBtn) {
    exportBtn.addEventListener('click', () => {
      const devices = Array.from(document.querySelectorAll('.device-card')).map(card => ({ 
        model: card.dataset.model, 
        lastUsed: card.querySelector('p').textContent.replace('Last used: ','') 
      }));
      
      let csv = 'Model,Last Used Date\n';
      devices.forEach(d => csv += `${d.model},${d.lastUsed}\n`);
      
      const blob = new Blob([csv], { type: 'text/csv;charset=UTF-8' });
      const link = document.createElement('a'); 
      link.href = URL.createObjectURL(blob); 
      link.download = 'devices.csv'; 
      link.click();
    });
  }

  // 删除设备功能
  document.querySelectorAll('.remove-device-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      if (confirm('确定要移除此设备吗？')) {
        const id = btn.dataset.id;
        const contextPath = document.body.dataset.contextPath || '';
        fetch(`${contextPath}/profile/device/remove?id=${id}`, { 
          method: 'POST' 
        }).then(() => btn.closest('.device-card').remove());
      }
    });
  });
  
  // 侧边栏导航功能
  document.querySelectorAll('.nav-item[data-section]').forEach(btn => {
    btn.addEventListener('click', () => {
      // 移除所有 active 类
      document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
      document.querySelectorAll('.content-section').forEach(section => section.classList.remove('active'));
      
      // 添加 active 类到选中项
      btn.classList.add('active');
      const targetSection = document.getElementById(btn.dataset.section);
      if (targetSection) {
        targetSection.classList.add('active');
      }
    });
  });
  
  // 切换账号功能
  const switchAccountBtn = document.getElementById('switch-account');
  if (switchAccountBtn) {
    switchAccountBtn.addEventListener('click', function() {
      const contextPath = document.body.dataset.contextPath || '';
      window.location.href = `${contextPath}/account/switch`;
    });
  }
  
  // 退出登录功能
  const logoutBtn = document.getElementById('logout');
  if (logoutBtn) {
    logoutBtn.addEventListener('click', function() {
      if (confirm('确定要退出登录吗？')) {
        const contextPath = document.body.dataset.contextPath || '';
        window.location.href = `${contextPath}/LogoutServlet`;
      }
    });
  }
});
