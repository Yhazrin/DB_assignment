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
</head>
<body>
<jsp:include page="sub/header.jsp"/>
<jsp:include page="sub/scripts.jsp"/>
<main class="main-container">
    <section class="search-bar">
        <input type="text" id="searchInput" class="search-input" placeholder="Enter keywords to filter data..." />
        <section class="filter-toolbar">
            <button id="btnBrand" class="color-btn" data-page="mobile_brands">Brand</button>
            <button id="btnModel" class="color-btn" data-page="smartphones">Model</button>
            <button id="btnComponent" class="color-btn" data-page="component">Component</button>
            <button id="btnSales" class="color-btn" data-page="smartphone_sales_all_countries_1">Sales</button>
            <button id="btnVendor" class="color-btn" data-page="supplier">Supplier</button>




            <div class="range-filter" data-field="price">
                <label>Price:</label>
                <input type="number" class="min" placeholder="min USD">
                <span>—</span>
                <input type="number" class="max" placeholder="max USD">
                <button class="apply color-btn">OK</button>
            </div>
            <div class="range-filter" data-field="battery">
                <label>Battery:</label>
                <input type="number" class="min" placeholder="min mAh">
                <span>—</span>
                <input type="number" class="max" placeholder="max mAh">
                <button class="apply color-btn">OK</button>
            </div>
            <section class="info-display">
                <div class="scroll-container">
                    <p id="infoText">这里是滚动提示内容</p>
                </div>
            </section>

        </section>

    </section>



    <table id="overview-table" class="overview-table">
        <thead>
        <tr>
            <th>No</th>
            <th>Model</th>
            <th>Brand</th>
            <th>Price (USD)</th>
            <th>SIM</th>
            <th>Processor</th>
            <th>RAM</th>
            <th>Battery</th>
            <th>Charging</th>
            <th>Rear Camera</th>
            <th>Front Camera</th>
            <th>Card Slot</th>
            <th>OS</th>
        </tr>
        </thead>
        <tbody>
        <!-- JS 动态插入行 -->
        </tbody>
    </table>
</main>

</body>
</html>
