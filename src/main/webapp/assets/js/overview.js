/**
 * overview.js - 处理手机概览页面的搜索和筛选功能
 */
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const dataRows = document.querySelectorAll('.data-row');
    const searchTypeButtons = document.querySelectorAll('.search-type-btn');

    // 当前搜索列索引，默认为产品名称(0)
    let currentSearchIndex = 0;
    
    // 为搜索类型按钮添加点击事件
    searchTypeButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 移除所有按钮的活动类
            searchTypeButtons.forEach(btn => btn.classList.remove('active'));
            // 给点击的按钮添加活动类
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
            // 获取当前选择列的文本
            const cellText = row.children[currentSearchIndex].textContent.toLowerCase();
            
            // 如果搜索词出现在选定的列中，则显示行
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
        
        // 如果结果计数元素不在DOM中，则添加它
        if (!resultCountEl.parentNode) {
            document.querySelector('.search-bar').appendChild(resultCountEl);
        }
    }

    // 应用带防抖的搜索逻辑
    searchInput.addEventListener('input', debounce(performSearch, 300));
});
