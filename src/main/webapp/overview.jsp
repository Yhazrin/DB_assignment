<%-- overview.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 登录校验
//    if (session == null || session.getAttribute("username") == null) {
//        response.sendRedirect("login.jsp");
//        return;
//    }
    java.util.List<String[]> phones = (java.util.List<String[]>) request.getAttribute("phones");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mobile Overview - Database Information System</title>
    <link rel="stylesheet" href="assets/css/overview.css">
</head>
<body>
<div class="overview-container">
    <!-- 搜索框 -->
    <div class="search-bar">
        <input type="text"
               class="search-input"
               placeholder="Search by product name or manufacturer...">
    </div>

    <!-- 数据展示区 -->
    <div class="data-wrapper">
        <!-- 表头 -->
        <div class="data-header">
            <div>产品名称</div>
            <div>发布厂商</div>
            <div>发布日期</div>
            <div>处理器</div>
            <div>屏幕</div>
            <div>摄像头规格</div>
            <div>机身材质</div>
            <div>价格</div>
        </div>

        <!-- 数据行 -->
        <div class="data-content">
            <c:forEach var="phone" items="${phones}">
                <div class="data-row">
                    <div>${phone[0]}</div>
                    <div>${phone[1]}</div>
                    <div>${phone[2]}</div>
                    <div>${phone[3]}</div>
                    <div>${phone[4]}</div>
                    <div>${phone[5]}</div>
                    <div>${phone[6]}</div>
                    <div>${phone[7]}</div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>