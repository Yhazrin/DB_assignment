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
        <input type="text" id="searchInput" class="search-input" placeholder="搜索..." />
        
        <!-- 搜索类型选择按钮 -->
        <div class="search-type-buttons">
            <button class="search-type-btn active" data-index="0">Product Name</button>
            <button class="search-type-btn" data-index="1">Manufacturer</button>
            <button class="search-type-btn" data-index="2">Release Date</button>
            <button class="search-type-btn" data-index="3">Processor</button>
            <button class="search-type-btn" data-index="4">Display</button>
            <button class="search-type-btn" data-index="5">Camera</button>
            <button class="search-type-btn" data-index="6">Material</button>
            <button class="search-type-btn" data-index="7">Price</button>
        </div>
    </div>

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
<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const dataRows = document.querySelectorAll('.data-row');
    const searchTypeButtons = document.querySelectorAll('.search-type-btn');
    
    // 当前搜索的列索引，默认为产品名称(0)
    let currentSearchIndex = 0;
    
    // 为搜索类型按钮添加点击事件
    searchTypeButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 移除所有按钮的active类
            searchTypeButtons.forEach(btn => btn.classList.remove('active'));
            // 为当前点击的按钮添加active类
            this.classList.add('active');
            // 更新当前搜索列索引
            currentSearchIndex = parseInt(this.dataset.index);
            // 重新执行搜索
            performSearch();
        });
    });
    
    // 防抖函数定义
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
    
    // 搜索逻辑函数
    function performSearch() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        
        let visibleCount = 0;
        dataRows.forEach(row => {
            // 获取当前选中列的文本
            const cellText = row.children[currentSearchIndex].textContent.toLowerCase();
            
            // 如果搜索词在选中列中出现，则显示该行
            if (cellText.includes(searchTerm)) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });
        
        // 显示结果数量
        const resultCountEl = document.querySelector('.search-results-count') || document.createElement('div');
        resultCountEl.className = 'search-results-count';
        resultCountEl.textContent = `找到 ${visibleCount} 条结果`;
        
        // 如果结果计数元素不在DOM中则添加它
        if (!resultCountEl.parentNode) {
            document.querySelector('.search-bar').appendChild(resultCountEl);
        }
    }
    
    // 使用防抖动应用搜索逻辑
    searchInput.addEventListener('input', debounce(performSearch, 300));
});
</script>
<script>
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// 使用防抖动
searchInput.addEventListener('input', debounce(function() {
    // 原有的搜索逻辑
}, 300));
</script>