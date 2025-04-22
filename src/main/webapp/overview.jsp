<%@ page contentType="text/html; charset=UTF-8" %>
<h2>数据库总览</h2>
<form action="OverviewServlet" method="get">
    <label>请选择筛选标签（Ctrl/Cmd 可多选）：</label><br>
    <select name="tags" multiple size="5" style="width:100%;margin:8px 0;">
        <option value="用户">用户</option>
        <option value="订单">订单</option>
        <option value="产品">产品</option>
        <option value="评价">评价</option>
        <option value="日志">日志</option>
    </select><br>
    <button type="submit">搜索</button>
</form>

<!-- 查询结果展示（示例表格） -->
<table border="1" cellpadding="6" cellspacing="0" style="margin-top:16px;width:100%;">
    <tr><th>表名</th><th>记录数</th><th>最后更新</th></tr>
    <!-- 由 OverviewServlet 填充 -->
    <!--
    <tr><td>用户</td><td>123</td><td>2025-05-01 10:12</td></tr>
    -->
</table>
