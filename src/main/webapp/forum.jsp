<%@ page contentType="text/html; charset=UTF-8" %>
<h2>产品论坛</h2>
<form action="ForumServlet" method="post">
  <label>选择产品：</label><br>
  <select name="productId" required style="width:100%;margin:8px 0;">
    <!-- 由 ForumServlet 或页面初始化时填充 -->
    <option value="1">产品 A</option>
    <option value="2">产品 B</option>
  </select><br>

  <label>您的评价：</label><br>
  <textarea name="review" rows="5" style="width:100%;margin:8px 0;" required></textarea><br>

  <button type="submit">提交评价</button>
</form>

<hr style="margin:24px 0;">

<h3>历史评价</h3>
<ul>
  <!-- 由 ForumServlet 填充： -->
  <!-- <li>产品A – 很好 👌 — 2025-05-02</li> -->
</ul>
