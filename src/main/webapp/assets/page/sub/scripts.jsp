<%--
  Created by IntelliJ IDEA.
  User: 20544
  Date: 2025/4/30
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- scripts.jsp — 全站通用脚本 -->
<script src="${pageContext.request.contextPath}/assets/js/theme-toggle.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 通用脚本 - 包含在所有页面底部 -->


<!-- 主题切换功能 -->
<script>
// 检测系统主题偏好并设置相应的主题
function detectTheme() {
    const storedTheme = localStorage.getItem('preferred-theme');
    
    if (storedTheme) {
        document.documentElement.setAttribute('data-theme', storedTheme);
        updateThemeToggleState(storedTheme === 'dark');
    } else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.setAttribute('data-theme', 'dark');
        updateThemeToggleState(true);
    } else {
        document.documentElement.setAttribute('data-theme', 'light');
        updateThemeToggleState(false);
    }
}

// 更新主题切换按钮状态
function updateThemeToggleState(isDark) {
    const toggle = document.querySelector('.theme-toggle');
    if (toggle) {
        toggle.checked = isDark;
    }
}

// 切换主题
function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('preferred-theme', newTheme);
}

// 添加主题切换事件监听
document.addEventListener('DOMContentLoaded', function() {
    detectTheme();
    
    const toggle = document.querySelector('.theme-toggle');
    if (toggle) {
        toggle.addEventListener('change', toggleTheme);
    }
});
</script>

<!-- 通用工具函数 -->
<script>
// 防抖函数
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

// 限流函数
function throttle(func, limit) {
    let inThrottle;
    return function(...args) {
        if (!inThrottle) {
            func.apply(this, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// 格式化日期
function formatDate(date, format = 'yyyy-MM-dd') {
    if (!(date instanceof Date)) {
        date = new Date(date);
    }
    
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    
    return format
        .replace('yyyy', year)
        .replace('MM', month)
        .replace('dd', day)
        .replace('HH', hours)
        .replace('mm', minutes);
}
</script>
