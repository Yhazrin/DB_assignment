<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"/>
    <title>对比 - 手机数据中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/compare.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>

<div class="container">
    <h1>手机参数对比</h1>
    <div class="controls">
        <div class="control-group">
            <label for="numModels">对比数量:</label>
            <select id="numModels">
                <option value="2">2款</option>
                <option value="3" selected>3款</option>
                <option value="4">4款</option>
                <option value="5">5款</option>
            </select>
        </div>
        <div class="control-group">
            <button id="reset-btn" class="secondary">重置</button>
            <button id="compare-btn" class="primary">开始对比</button>
        </div>
    </div>

    <div class="selectors" id="deviceSelectors">
        <!-- 设备选择器将在页面加载时由JS动态生成 -->
    </div>

    <div id="compareResults">
        <c:choose>
            <c:when test="${not empty selectedPhones}">
                <table class="compare-table">
                    <tr>
                        <th>规格</th>
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
        <button id="print-btn">打印对比结果</button>
        <button id="share-btn">分享对比</button>
        <button id="add-to-favorites">收藏对比</button>
    </div>
</div>

<jsp:include page="sub/scripts.jsp"/>
<script>
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
<script>
    document.addEventListener('DOMContentLoaded', () => updateSelectors?.());
</script>
</body>
</html>
