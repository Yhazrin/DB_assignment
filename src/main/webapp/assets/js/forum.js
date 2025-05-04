/**
 * forum.js - 处理论坛页面的交互逻辑和功能
 */
document.addEventListener('DOMContentLoaded', function() {
    // 设置排序方式变更处理
    const sortSelector = document.getElementById('sortOrder');
    if (sortSelector) {
        sortSelector.addEventListener('change', changeSortOrder);
    }
    
    // 添加回到顶部功能
    addBackToTopButton();
    
    // 增强论坛帖子交互
    enhanceTopicItems();
    
    // 监听新主题按钮
    setupNewTopicButton();
});

/**
 * 更改排序方式
 */
function changeSortOrder() {
    const sortOrder = document.getElementById('sortOrder').value;
    const url = new URL(window.location.href);
    url.searchParams.set('sort', sortOrder);
    window.location.href = url.toString();
}

/**
 * 添加回到顶部按钮
 */
function addBackToTopButton() {
    // 创建回到顶部按钮
    const backToTop = document.createElement('button');
    backToTop.className = 'back-to-top';
    backToTop.innerHTML = '<i class="fas fa-arrow-up"></i>';
    document.body.appendChild(backToTop);
    
    // 监听滚动事件
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            backToTop.classList.add('show');
        } else {
            backToTop.classList.remove('show');
        }
    });
    
    // 点击回到顶部
    backToTop.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
}

/**
 * 增强论坛主题列表的交互功能
 */
function enhanceTopicItems() {
    // 添加鼠标悬停效果
    const topicItems = document.querySelectorAll('.topic-item');
    topicItems.forEach(item => {
        // 添加交互类表明这是可交互元素
        item.classList.add('interactive');
        
        // 悬停动画效果
        item.addEventListener('mouseenter', function() {
            this.classList.add('hover');
        });
        
        item.addEventListener('mouseleave', function() {
            this.classList.remove('hover');
        });
        
        // 双击直接进入主题
        item.addEventListener('dblclick', function() {
            const topicLink = this.querySelector('.topic-title a');
            if (topicLink) {
                window.location.href = topicLink.getAttribute('href');
            }
        });
    });
    
    // 为统计数据添加动画效果
    const statElements = document.querySelectorAll('.topic-stats .stat');
    statElements.forEach(stat => {
        stat.addEventListener('mouseenter', function() {
            this.classList.add('pulse');
        });
        
        stat.addEventListener('animationend', function() {
            this.classList.remove('pulse');
        });
    });
}

/**
 * 设置新主题按钮的交互
 */
function setupNewTopicButton() {
    const newTopicBtn = document.querySelector('a[href*="action=new"]');
    if (newTopicBtn) {
        newTopicBtn.addEventListener('click', function(e) {
            // 如果用户未登录，重定向到登录页面
            const isLoggedIn = document.body.dataset.userLoggedIn === 'true';
            if (!isLoggedIn) {
                e.preventDefault();
                const loginUrl = `${getContextPath()}/login?redirect=${encodeURIComponent(this.href)}`;
                window.location.href = loginUrl;
            }
        });
    }
}

/**
 * 获取应用程序上下文路径
 */
function getContextPath() {
    // 从body的data属性或从页面的第一个脚本标签中获取
    const bodyPath = document.body.dataset.contextPath;
    if (bodyPath) return bodyPath;
    
    // 尝试从第一个带有src属性的脚本标签中提取
    const scriptSrc = document.querySelector('script[src*="/assets/"]')?.getAttribute('src');
    if (scriptSrc) {
        const match = scriptSrc.match(/^(\/[^/]+)?\//);
        return match && match[1] ? match[1] : '';
    }
    
    return '';
}
