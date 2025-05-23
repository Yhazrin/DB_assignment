<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overview - MobilePhoneSys</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/overview.css">
    <script src="${pageContext.request.contextPath}/assets/js/overview.js" defer></script>
</head>
<body>
<jsp:include page="sub/header.jsp"/>
<jsp:include page="sub/scripts.jsp"/>
<main class="main-container">
    <section class="search-bar">
        <section class="search-baba">
            <input type="text" id="searchInput" class="search-input" placeholder="Enter No. or Model name to filter data..." />
            <button id="searchBtn" class="search-btn">Search</button>
        </section>
        <section class="filter-toolbar">
            <button id="btnBrand" class="color-btn" data-page="mobile_brands">Brand</button>
            <button id="btnModel" class="color-btn" data-page="smartphones">Model</button>
            <button id="btnComponent" class="color-btn" data-page="component">Component</button>
            <button id="btnSales" class="color-btn" data-page="smartphone_sales_all_countries">Sales</button>
            <button id="btnVendor" class="color-btn" data-page="supplier">Supplier</button>




            <div class="range-filter" data-field="price">
                <label>Price:</label>
                <input type="number" class="min" placeholder="min USD">
                <span>—</span>
                <input type="number" class="max" placeholder="max USD">
                <button type="button" class="apply color-btn">OK</button>

            </div>
            <div class="range-filter" data-field="battery">
                <label>Battery:</label>
                <input type="number" class="min" placeholder="min mAh">
                <span>—</span>
                <input type="number" class="max" placeholder="max mAh">
                <button type="button" class="apply color-btn">OK</button>

            </div>

            <section class="info-display">
                <div class="scroll-container">
                    <p id="infoText">这里是滚动提示内容</p>
                </div>
            </section>

        </section>

    </section>



    <table id="overview-table" class="overview-table">
        <thead></thead>

        <tbody>
        <!-- JS 动态插入行 -->
        </tbody>
    </table>
</main>



</body>
</html>
