/**
 * home.js - Handle animations and scroll effects on the homepage
 */
document.addEventListener('DOMContentLoaded', function() {
    // Animation effects
    const elements = document.querySelectorAll('.section-overview, .section-compare, .section-forum, .section-profile, .tech-section, .testimonials');

    // Initially make all elements visible
    elements.forEach(el => {
        el.classList.add('animate');
    });

    // Create an intersection observer to handle scroll-based animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate');
            }
        });
    }, { threshold: 0.1 });

    // Add observer to elements with scroll animation
    const scrollElements = document.querySelectorAll('.animate-on-scroll');
    scrollElements.forEach(el => {
        observer.observe(el);
    });

    // Smooth scrolling to anchor links
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

    // Video playback control
    const heroVideo = document.querySelector('.hero-video-card video');
    if (heroVideo) {
        // Ensure the video plays only when visible, to save resources
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
