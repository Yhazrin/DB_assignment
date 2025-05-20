<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Compare - Mobile Phone Data Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- 引入已经复刻了登录卡片样式的 compare.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/compare.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>

<!-- 整个对比内容都放进一个和登录页一样的卡片里 -->
<div class="container">
    <div class="compare-card">
        <h2>Compare Phones</h2>

        <div class="controls">
            <div class="control-group">
                <label for="numModels">Compare count:</label>
                <select id="numModels">
                    <option value="2">2 models</option>
                    <option value="3" selected>3 models</option>
                    <option value="4">4 models</option>
                    <option value="5">5 models</option>
                </select>
            </div>
            <div class="control-group">
                <button id="reset-btn" class="btn color-btn">Reset</button>
                <button id="compare-btn" class="btn color-btn">Start Comparison</button>
            </div>
        </div>

        <div class="selectors" id="deviceSelectors">
        </div>

        <div id="compareResults">
            <c:choose>
                <c:when test="${not empty selectedPhones}">
                    <table class="compare-table">
                        <tr>
                            <th>Specification</th>
                            <c:forEach var="phone" items="${selectedPhones}">
                                <th>${phone.brand} ${phone.name}</th>
                            </c:forEach>
                        </tr>
                        <c:forEach var="specEntry" items="${specs}">
                            <tr>
                                <td class="spec-label">${specEntry.value.name}</td>
                                <c:forEach var="phone" items="${selectedPhones}">
                                    <td>
                                        <c:choose>
                                            <c:when test="${specEntry.key == 'releaseDate'}">
                                                <fmt:formatDate value="${phone.releaseDate}" pattern="yyyy-MM-dd"/>
                                            </c:when>
                                            <c:when test="${specEntry.key == 'price'}">
                                                $${phone.price}
                                            </c:when>
                                            <c:otherwise>
                                                ${phone[specEntry.key]}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="message">请选择要对比的手机型号后点击“开始对比”</div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="action-bar">
            <button id="print-btn" class="btn color-btn">Print Results</button>
            <button id="share-btn" class="btn color-btn">Share Comparison</button>
            <button id="add-to-favorites" class="btn color-btn">Save to Favorites</button>
        </div>
    </div>
</div>

<jsp:include page="sub/scripts.jsp"/>

<!-- 手机数据 -->
<script id="phoneDataScript">
    const allPhoneData = [
        <c:forEach var="phone" items="${allPhones}" varStatus="st">
        {
            id: ${st.index},
            name: "${phone.name}",
            brand: "${phone.brand}",
            releaseDate: "<fmt:formatDate value='${phone.releaseDate}' pattern='yyyy-MM-dd' />",
            processor: "${phone.processor}",
            display: "${phone.display}",
            camera: "${phone.camera}",
            material: "${phone.material}",
            price: ${phone.price}
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];
</script>

<script src="${pageContext.request.contextPath}/assets/js/compare-init.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/compare.js"></script>
</body>
</html>
