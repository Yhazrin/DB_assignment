<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Phone Compare – InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/compare.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>
<div class="main-container">
    <div class="compare-card">
        <h2>Phone Comparison</h2>
        <div style="margin-bottom:16px;">
            <input type="number" id="searchNoInput" min="1" placeholder="Enter Phone No"/>
            <button id="searchNoBtn" class="btn color-btn">Search</button>
            <button id="resetBtn" class="btn color-btn">Reset</button>
        </div>
        <div id="compareResult"></div>

    </div>
</div>


<script src="../js/compare.js"></script>
</body>
</html>
