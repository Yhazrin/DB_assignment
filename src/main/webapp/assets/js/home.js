/**
 * home.js - 处理首页的动画和滚动效果
 */
document.addEventListener('DOMContentLoaded', function() {
    // 动画效果
    const elements = document.querySelectorAll('.section-overview, .section-compare, .section-forum, .section-profile, .tech-section, .testimonials');

    // 首先让所有元素在初始时可见
    elements.forEach(el => {
        el.classList.add('animate');
    });
    
    // 创建交叉观察器来处理基于滚动的动画
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate');
            }
        });
    }, { threshold: 0.1 });

    // 为需要滚动动画的元素添加观察器
    const scrollElements = document.querySelectorAll('.animate-on-scroll');
    scrollElements.forEach(el => {
        observer.observe(el);
    });
    
    // 只对交互元素添加悬停效果类
    document.querySelectorAll('a, button, .feature-card a, .tech-card a, .cta-buttons a').forEach(element => {
        element.classList.add('interactive');
    });
    
    // 平滑滚动到锚点链接
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // 视频播放控制
    const heroVideo = document.querySelector('.hero-video-card video');
    if (heroVideo) {
        // 确保视频在可见区域时才播放，节省资源
        const videoObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    if (heroVideo.paused) heroVideo.play();
                } else {
                    if (!heroVideo.paused) heroVideo.pause();
                }
            });
        }, { threshold: 0.3 });
        
        videoObserver.observe(heroVideo);
    }
});
