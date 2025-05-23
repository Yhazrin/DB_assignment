<%--
  header.jsp
  公共导航栏片段，自动高亮当前页面
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
<%
    // 通过脚本片段获取当前 JSP 名称（不含扩展名）
    String uri = request.getRequestURI();
    int slash = uri.lastIndexOf('/');
    int dot = uri.lastIndexOf('.');
    String currentPage = (slash >= 0 && dot > slash) ? uri.substring(slash + 1, dot) : "";
    request.setAttribute("currentPage", currentPage);
%>

<script>
    // 全局上下文和管理员标志
    window.CONTEXT_PATH = "${pageContext.request.contextPath}";
    // 注意 JSP EL 会自动把 Boolean 转成 "true"/"false"
    window.IS_ADMIN    = "${sessionScope.isAdmin}";
</script>
<script>
    window.CONTEXT_PATH = "${pageContext.request.contextPath}";
    window.IS_ADMIN    = "${sessionScope.isAdmin}";
    console.log("调试 ⇒ window.IS_ADMIN =", window.IS_ADMIN);
</script>

<nav class="navbar">
    <div class="logo">MobilePhoneSys</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/assets/page/home.jsp"
           class="${currentPage == 'home' ? 'active' : ''}">Home</a>
        <a href="${pageContext.request.contextPath}/assets/page/overview.jsp"
           class="${currentPage == 'overview' ? 'active' : ''}">Overview</a>
        <a href="${pageContext.request.contextPath}/assets/page/compare.jsp"
           class="${currentPage == 'compare' ? 'active' : ''}">Compare</a>
        <a href="${pageContext.request.contextPath}/assets/page/forum.jsp"
           class="${currentPage == 'forum' ? 'active' : ''}">Forum</a>
        <a href="${pageContext.request.contextPath}/assets/page/profile.jsp"
           class="${currentPage == 'profile' ? 'active' : ''}">Profile</a>

        <c:if test="${sessionScope.username == 'admin'}">
            <a href="${pageContext.request.contextPath}/assets/page/console.jsp"
               class="${currentPage=='console'?'active':''}">
                Console
            </a>
        </c:if>

        <!-- 把登录/欢迎也当成 nav-link -->
        <c:choose>
            <c:when test="${empty sessionScope.username}">
                <a href="${pageContext.request.contextPath}/assets/page/login.jsp"
                   class="${currentPage == 'login' ? 'active' : ''}">
                    LogIn
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/assets/page/profile.jsp"
                   class="${currentPage == 'profile' ? 'active' : ''}">
                    Welcome, ${sessionScope.username}
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <button class="theme-toggle-btn" type="button">
        <img id="icon-toggle"
             src="${pageContext.request.contextPath}/assets/icons/sn.svg"
             alt="Toggle Theme">
    </button>

    <script src="${pageContext.request.contextPath}/assets/js/header.js"></script>
</nav>

