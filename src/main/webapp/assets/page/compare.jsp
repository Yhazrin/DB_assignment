<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/> <!-- Set character encoding to UTF-8 -->
    <title>Smartphone Compare - MobilePhoneSys</title> <!-- Set the title of the webpage -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/> <!-- Set the viewport to make the webpage responsive on different devices -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/compare.css"> <!-- Include the CSS stylesheet -->
</head>
<body>
<jsp:include page="sub/header.jsp"/> <!-- Include the header page -->
<jsp:include page="sub/scripts.jsp"/> <!-- Include the scripts page -->
<div class="main-container">
    <div class="compare-card">
        <div style="margin-bottom:16px;">
            <input type="number" id="searchNoInput" min="1" placeholder="Enter Phone No"/> <!-- Input field for entering phone number, minimum value is 1 -->
            <button id="searchNoBtn" class="color-btn">Search</button> <!-- Search button -->
            <button id="resetBtn" class="color-btn">Reset</button> <!-- Reset button -->
        </div>
        <div id="compareResult"></div> <!-- Container to display comparison results -->

    </div>
</div>
<script src="../js/compare.js"></script> <!-- Include the JavaScript script file -->
</body>
</html>
