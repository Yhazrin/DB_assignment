<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 取 tab 参数，默认 “overview”
    String tab = request.getParameter("tab");
    if (tab == null) tab = "overview";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系统主页面</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<!-- 顶部导航 -->
<div class="navbar">
    <a href="index.jsp?tab=overview"
       class="<%= tab.equals("overview")?"active":"" %>">
        数据库总览
    </a>
    <a href="index.jsp?tab=forum"
       class="<%= tab.equals("forum")?"active":"" %>">
        论坛
    </a>
    <a href="index.jsp?tab=viz"
       class="<%= tab.equals("viz")?"active":"" %>">
        数据可视化
    </a>
</div>

<!-- 子页面内容 -->
<div class="tab-content">
    <% if (tab.equals("overview")) { %>
    <jsp:include page="overview.jsp"/>
    <% } else if (tab.equals("forum")) { %>
    <jsp:include page="forum.jsp"/>
    <% } else { %>
    <jsp:include page="viz.jsp"/>
    <% } %>
</div>
</body>
</html>
