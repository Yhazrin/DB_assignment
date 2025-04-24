<!-- forum.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  // 登录校验
  if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  // 从 request 中取出 posts 列表
  @SuppressWarnings("unchecked")
  java.util.List<String[]> posts =
          (java.util.List<String[]>) request.getAttribute("posts");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Forum - Database Information System</title>
  <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
  <h1>Forum</h1>

  <%  // 遍历并显示帖子的用户、时间、内容
    if (posts != null) {
      for (String[] p : posts) {
  %>
  <div class="post">
    <strong><%= p[0] %></strong> at <em><%= p[2] %></em><br/>
    <%= p[1] %>
  </div>
  <hr/>
  <%      }
  }
  %>

  <!-- 发帖表单 -->
  <form action="forum" method="post">
            <textarea name="content" rows="4" cols="50"
                      placeholder="Write your post here..." required></textarea><br/>
    <button type="submit">Post</button>
  </form>

  <p><a href="main">Back to Main</a></p>
</div>
</body>
</html>
