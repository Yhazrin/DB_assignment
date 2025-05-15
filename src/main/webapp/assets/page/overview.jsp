<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overview - MobilePhoneSys</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/banner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/overview.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>

<div class="main-container">
    <!-- Top banner -->
    <div class="banner">
        <h1>Mobile Phone Overview</h1>
        <p>Browse all mobile phones in our database with detailed specifications</p>
    </div>
    
    <!-- Search bar -->
    <div class="search-bar">
        <input type="text" id="searchInput" class="search-input" placeholder="Enter keywords to filter data..." />
    
        <!-- Search type selection buttons -->
        <div class="search-type-buttons">
            <button class="search-type-btn active" data-index="0">name</button>
            <button class="search-type-btn" data-index="1">brand</button>
            <button class="search-type-btn" data-index="2">releaseDate</button>
            <button class="search-type-btn" data-index="3">processor</button>
            <button class="search-type-btn" data-index="4">display</button>
            <button class="search-type-btn" data-index="5">camera</button>
            <button class="search-type-btn" data-index="6">material</button>
            <button class="search-type-btn" data-index="7">price</button>
        </div>
    </div>

    <!-- Table header component -->
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

    <!-- Table body component -->
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

<jsp:include page="sub/scripts.jsp"/>
<script src="${pageContext.request.contextPath}/assets/js/overview.js"></script>

</body>
</html>