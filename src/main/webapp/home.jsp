<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Phone Data Center - Explore, Compare, Share</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/home/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/theme-toggle.css">
</head>
<body>
<jsp:include page="sub/header.jsp"/>

<!-- Hero Section -->
<section class="hero section-fullwidth">
    <div class="section-container">
        <div class="hero-content">
            <div class="hero-headings">
                <div class="hero-title hero-title-1">Explore the World of</div>
                <div class="hero-title hero-title-2">Mobile Phones</div>
            </div>
        </div>
        <div class="hero-image">
            <div class="hero-video-card">
                <video autoplay muted playsinline preload="auto">
                    <source src="${pageContext.request.contextPath}/assets/videos/hero.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
        </div>
    </div>
</section>
<div class="hero-card-connector"></div>

<!-- Features Overview -->
<section class="features-overview section-fullwidth">
    <div class="section-container">
        <h2>Our Core Features</h2>
        <div class="features-grid">
            <div class="feature-card">
                <i class="fas fa-mobile-alt"></i>
                <h3>Browse Phone Data</h3>
                <p>Explore the latest models with detailed specifications to make informed decisions</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-balance-scale"></i>
                <h3>Multi-dimensional Comparison</h3>
                <p>Compare multiple phones simultaneously to find the perfect match for your needs</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-comments"></i>
                <h3>Community Discussion</h3>
                <p>Join our forum to share experiences and get feedback from real users</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-user-circle"></i>
                <h3>Personal Collections</h3>
                <p>Create your personal favorites list and save comparison results</p>
            </div>
        </div>
    </div>
</section>

<!-- Phone Browse Feature -->
<section class="section-overview section-fullwidth">
    <div class="section-container">
        <div class="section-content">
            <h2>Comprehensive Phone Database</h2>
            <p>Our database includes detailed specifications for virtually all mainstream phones on the market. From processors to cameras, screens to batteries, everything you need is here.</p>
            <ul class="feature-list">
                <li><i class="fas fa-check-circle"></i> Detailed technical specifications</li>
                <li><i class="fas fa-check-circle"></i> Release dates and pricing information</li>
                <li><i class="fas fa-check-circle"></i> High-quality images</li>
                <li><i class="fas fa-check-circle"></i> Multi-dimensional filtering</li>
            </ul>
            <a href="${pageContext.request.contextPath}/overview.jsp" class="btn primary">Explore Phone Database</a>
        </div>
        <div class="section-image">
            <img src="${pageContext.request.contextPath}/assets/images/overview-demo.svg" alt="Phone Database Browsing">
        </div>
    </div>
</section>

<!-- Comparison Feature -->
<section class="section-compare section-fullwidth">
    <div class="section-container">
        <div class="section-image">
            <img src="${pageContext.request.contextPath}/assets/images/compare-demo.svg" alt="Phone Comparison Feature">
        </div>
        <div class="section-content">
            <h2>Powerful Comparison Tool</h2>
            <p>Select up to five phones for detailed specification comparison. Find the strengths and weaknesses across multiple dimensions to make the best choice for your needs.</p>
            <ul class="feature-list">
                <li><i class="fas fa-check-circle"></i> Compare multiple phones simultaneously</li>
                <li><i class="fas fa-check-circle"></i> Automatic highlighting of advantages</li>
                <li><i class="fas fa-check-circle"></i> Shareable comparison results</li>
                <li><i class="fas fa-check-circle"></i> Print and save functionality</li>
            </ul>
            <a href="${pageContext.request.contextPath}/compare.jsp" class="btn primary">Start Comparing</a>
        </div>
    </div>
</section>

<!-- Forum Community -->
<section class="section-forum section-fullwidth">
    <div class="section-container">
        <div class="section-content">
            <h2>Active User Community</h2>
            <p>Join our forum community to exchange experiences with other phone enthusiasts, share usage tips, and get advice on purchases and issues.</p>
            <ul class="feature-list">
                <li><i class="fas fa-check-circle"></i> Real user reviews</li>
                <li><i class="fas fa-check-circle"></i> Expert discussion boards</li>
                $1
                <li><i class="fas fa-check-circle"></i> Latest phone news</li>
            </ul>
            <a href="${pageContext.request.contextPath}/forum.jsp" class="btn primary">Join Discussions</a>
        </div>
        <div class="section-image">
            <img src="${pageContext.request.contextPath}/assets/images/forum-demo.svg" alt="Forum Community">
        </div>
    </div>
</section>

<!-- User Profile -->
<section class="section-profile section-fullwidth">
    <div class="section-container">
        <div class="section-image">
            <img src="${pageContext.request.contextPath}/assets/images/profile-demo.svg" alt="User Profile">
        </div>
        <div class="section-content">
            <h2>Personalized User Experience</h2>
            <p>Create your personal account to bookmark favorite phone models, save comparison results, set preferences, and receive customized recommendations.</p>
            <ul class="feature-list">
                <li><i class="fas fa-check-circle"></i> Personal favorites collection</li>
                <li><i class="fas fa-check-circle"></i> Browsing history</li>
                <li><i class="fas fa-check-circle"></i> Save comparison results</li>
                <li><i class="fas fa-check-circle"></i> Personalized recommendations</li>
            </ul>
            <a href="${pageContext.request.contextPath}/profile.jsp" class="btn primary">My Profile</a>
        </div>
    </div>
</section>

<!-- Data & Technology -->
<section class="tech-section section-fullwidth">
    <div class="section-container">
        <h2>Our Data & Technology</h2>
        <div class="tech-grid">
            <div class="tech-card">
                <i class="fas fa-database"></i>
                <h3>Rich Data Sources</h3>
                <p>Our data comes from official specifications, professional reviews, and real user feedback to ensure comprehensive accuracy</p>
            </div>
            <div class="tech-card">
                <i class="fas fa-sync-alt"></i>
                <h3>Real-time Updates</h3>
                <p>We continuously track the latest phone releases and update our database promptly</p>
            </div>
            <div class="tech-card">
                <i class="fas fa-shield-alt"></i>
                <h3>Secure & Reliable</h3>
                <p>Using the latest security technologies to protect user data and privacy</p>
            </div>
            <div class="tech-card">
                <i class="fas fa-tachometer-alt"></i>
                <h3>High Performance</h3>
                <p>Optimized frontend experience and backend processing for fast responses and smooth interactions</p>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="cta-section section-fullwidth">
    <div class="section-container">
        <h2>Start Exploring and Find Your Ideal Phone</h2>
        <p>Whether you want to learn about the latest phone specifications or need a detailed comparison of different models, we're here to help you make the most informed choice.</p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/overview.jsp" class="btn secondary">Browse Phone Database</a>
            <a href="${pageContext.request.contextPath}/compare.jsp" class="btn secondary">Compare Specs</a>
            <a href="${pageContext.request.contextPath}/forum.jsp" class="btn secondary">Join Discussions</a>
        </div>
    </div>
</section>

<jsp:include page="sub/scripts.jsp"/>
<script src="${pageContext.request.contextPath}/assets/js/home.js"></script>
</body>
</html>
