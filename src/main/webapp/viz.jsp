<%@ page contentType="text/html; charset=UTF-8" %>
<h2>用户数据可视化</h2>
<form id="vizForm">
  <label>筛选用户类别：</label><br>
  <select id="userFilter" name="userFilter" multiple size="4" style="width:100%;margin:8px 0;">
    <option value="new">新用户</option>
    <option value="active">活跃用户</option>
    <option value="inactive">沉睡用户</option>
    <option value="vip">VIP 用户</option>
  </select><br>
  <button type="button" id="btnUpdate">更新图表</button>
</form>

<!-- 图表容器 -->
<canvas id="chartCanvas" width="600" height="300" style="margin-top:24px;"></canvas>

<!-- 引入 Chart.js（如果没有本地，请用 CDN） -->
<script src="assets/js/chart.min.js"></script>
<script>
  const ctx = document.getElementById('chartCanvas').getContext('2d');
  let chart = null;

  function loadDataAndRender() {
    const opts = Array.from(document.getElementById('userFilter').selectedOptions)
            .map(o=>o.value).join(',');
    fetch('VisualizationDataServlet?filter=' + opts)
            .then(res=>res.json())
            .then(data=>{
              if (chart) chart.destroy();
              chart = new Chart(ctx, {
                type: 'bar',
                data: {
                  labels: data.labels,
                  datasets: [{
                    label: '用户数量',
                    data: data.values
                  }]
                },
                options: {}
              });
            });
  }

  document.getElementById('btnUpdate').onclick = loadDataAndRender;

  // 页面初始加载一次
  loadDataAndRender();
</script>
