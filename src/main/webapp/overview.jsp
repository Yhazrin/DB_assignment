<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 如果 dataList 不存在，说明没有经过 OverviewServlet
    if (request.getAttribute("dataList") == null) {
        // 重定向到 Servlet 映射路径，让它来初始化 dataList
        response.sendRedirect(request.getContextPath() + "/overview");
        return;
    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overview - MobilePhoneSys</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/overview.css">
</head>
<body>
<jsp:include page="/sub/header.jsp"/>

<div class="overview-container">
    <!-- 搜索栏 -->
    <div class="search-bar">
        <input type="text" class="search-input" placeholder="Search by product name or manufacturer..." />
    </div>

    <!-- 调试：检查 dataList -->
    <c:if test="${empty dataList}">
        <p style="color:red; text-align:center;">错误：dataList 为空或未传递到页面</p>
    </c:if>

    <!-- 表头组件 -->
    <div class="table-header-wrapper">
        <div class="data-header">
            <div>Product Name</div>
            <div>Manufacturer</div>
            <div>Release Date</div>
            <div>Processor</div>
            <div>Display</div>
            <div>Camera</div>
            <div>Material</div>
            <div>Price</div>
        </div>
    </div>

    <!-- 数据体组件 -->
    <div class="table-body-wrapper">
        <c:forEach var="item" items="${dataList}">
            <div class="data-row">
                <div>${item.name}</div>
                <div>${item.brand}</div>
                <div><fmt:formatDate value="${item.releaseDate}" pattern="yyyy-MM-dd"/></div>
                <div>${item.processor}</div>
                <div>${item.display}</div>
                <div>${item.camera}</div>
                <div>${item.material}</div>
                <div>${item.price}</div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/sub/scripts.jsp"/>
</body>
</html>
