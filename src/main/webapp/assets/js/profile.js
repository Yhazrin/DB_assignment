/**
 * profile.js - 处理用户个人资料页面的所有交互逻辑（简化版）
 */
document.addEventListener('DOMContentLoaded', function() {
  const ctx    = getContextPath();
  const USERID = "u1";
  const endpoint = 'http://localhost:8080/ServerletFinal_war_exploded//data?type=readSQL&table=users&userID=' + USERID;

  // 1. 拉取并渲染用户基本信息（只渲染后端已返回字段）
  fetch(endpoint)
      .then(res => res.ok ? res.json() : Promise.reject(res.status))
      .then(users => {
        const user = users[0];  // 取第一个元素
        // 只渲染 username 和 email
        document.getElementById('userName').textContent = user.username;
        document.getElementById('email').textContent    = user.email;
        // registerDate 后端暂时没给，填一个占位
        document.getElementById('registerDate').textContent = '—';
      })
      .catch(err => console.error('加载用户信息失败', err));

  // 以下功能先保留空实现或注释，等后端完善再打开
  // renderDevices([]);
  // renderActivities([]);
  // ……其余侧边栏、导出 CSV、注销等保持不变
});

/**
 * 获取上下文路径
 */
function getContextPath() {
  return document.body.dataset.contextPath || '';
}
