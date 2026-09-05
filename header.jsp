<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <c:choose>
            <c:when test="${not empty pageTitle}">
                <c:out value="${pageTitle}" /> | Crime Reporting System
            </c:when>
            <c:otherwise>
                Crime Reporting System
            </c:otherwise>
        </c:choose>
    </title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- Google Fonts -->
    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          >

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Oswald:wght@400;500;600;700&family=Roboto+Mono:wght@400;500;600&display=swap"
        rel="stylesheet">

   <link
    href="${pageContext.request.contextPath}/css/style.css"
    rel="stylesheet">

<link
    href="${pageContext.request.contextPath}/css/darkstyle.css"
    rel="stylesheet">
</head>

<body>

<script>
(function () {

    try {

        const savedTheme = localStorage.getItem("crsTheme");

        if (savedTheme === "dark") {
            document.body.classList.add("dark-theme");
        }

    } catch (error) {
        console.log("Theme preference could not be loaded.");
    }

})();
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {

    const themeButton = document.getElementById("themeToggle");
    const themeIcon = document.getElementById("themeIcon");
    const themeText = document.getElementById("themeText");

    const savedTheme = localStorage.getItem("crimeReportTheme");

    function updateThemeUI() {

        const dark =
            document.body.classList.contains("dark-theme");

        if (themeIcon) {
            themeIcon.className = dark
                ? "bi bi-sun-fill"
                : "bi bi-moon-stars-fill";
        }

        if (themeText) {
            themeText.textContent = dark
                ? "Light"
                : "Dark";
        }
    }

    if (savedTheme === "dark") {
        document.body.classList.add("dark-theme");
    }

    updateThemeUI();

    if (themeButton) {

        themeButton.addEventListener("click", function () {

            document.body.classList.toggle("dark-theme");

            const dark =
                document.body.classList.contains("dark-theme");

            localStorage.setItem(
                "crimeReportTheme",
                dark ? "dark" : "light"
            );

            updateThemeUI();
        });
    }

});
</script>


<nav class="navbar navbar-expand-lg navbar-dark navbar-cts sticky-top">

    <div class="container-fluid px-lg-4">

        <!-- BRAND -->
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/index.jsp">

            <i class="bi bi-shield-shaded brand-icon"></i>

            <span>
                Crime<span class="brand-highlight">Report</span>
            </span>

        </a>


        <!-- MOBILE TOGGLER -->
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#mainNavbar"
            aria-controls="mainNavbar"
            aria-expanded="false"
            aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>


        <div class="collapse navbar-collapse"
             id="mainNavbar">


            <!-- =================================================
                 MAIN NAVIGATION
                 ================================================= -->

            <ul class="navbar-nav me-auto ms-lg-4 mb-2 mb-lg-0">


                <!-- ALWAYS VISIBLE -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/index.jsp">

                        <i class="bi bi-house-door nav-menu-icon"></i>

                        Home

                    </a>

                </li>


                <!-- ALWAYS VISIBLE -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/about.jsp">

                        <i class="bi bi-info-circle nav-menu-icon"></i>

                        About

                    </a>

                </li>


                <!-- USER ONLY -->

                <c:if test="${not empty sessionScope.user}">

                    <li class="nav-item">

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/reportCrime.jsp">

                            <i class="bi bi-file-earmark-plus nav-menu-icon"></i>

                            Report Crime

                        </a>

                    </li>


                    <li class="nav-item">

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/ViewReportsServlet">

                            <i class="bi bi-folder2-open nav-menu-icon"></i>

                            My Reports

                        </a>

                    </li>

                </c:if>


                <!-- ALWAYS VISIBLE -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/trackStatus.jsp">

                        <i class="bi bi-search nav-menu-icon"></i>

                        Track Status

                    </a>

                </li>


                <!-- ALWAYS VISIBLE -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/contact.jsp">

                        <i class="bi bi-envelope nav-menu-icon"></i>

                        Contact

                    </a>

                </li>


                <!-- ADMIN ONLY -->

                <c:if test="${not empty sessionScope.admin}">

                    <li class="nav-item">

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/AdminDashboardServlet">

                            <i class="bi bi-speedometer2 nav-menu-icon"></i>

                            Dashboard

                        </a>

                    </li>

                </c:if>


            </ul>


            <!-- =================================================
                 RIGHT SIDE
                 ================================================= -->

            <div class="navbar-actions">


                <!-- DARK/LIGHT TOGGLE -->

                <button
                    type="button"
                    id="themeToggle"
                    class="theme-toggle-btn"
                    title="Change theme"
                    aria-label="Switch theme">

                    <i
                        id="themeIcon"
                        class="bi bi-moon-stars-fill">
                    </i>

                    <span id="themeText">
                        Dark
                    </span>

                </button>


                <!-- =================================================
                     LOGIN / USER / ADMIN
                     ================================================= -->

                <c:choose>


                    <c:when test="${not empty sessionScope.user}">

                        <div class="nav-account">

                            <i class="bi bi-person-circle"></i>

                            <span class="d-none d-xl-inline">

                                <c:out value="${sessionScope.user.fullName}" />

                            </span>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/logout"
                            class="btn nav-outline-btn">

                            <i class="bi bi-box-arrow-right"></i>

                            <span class="d-none d-xl-inline">
                                Logout
                            </span>

                        </a>

                    </c:when>


                    <c:when test="${not empty sessionScope.admin}">

                        <div class="nav-account admin-account">

                            <i class="bi bi-shield-lock"></i>

                            <span class="d-none d-xl-inline">

                                <c:choose>
                                    <c:when test="${not empty sessionScope.admin.adminName}">
                                        <c:out value="${sessionScope.admin.adminName}" />
                                    </c:when>
                                    <c:otherwise>
                                        Admin
                                    </c:otherwise>
                                </c:choose>

                            </span>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/LogoutServlet"
                            class="btn nav-outline-btn">

                            <i class="bi bi-box-arrow-right"></i>

                            <span class="d-none d-xl-inline">
                                Logout
                            </span>

                        </a>

                    </c:when>


                    <c:otherwise>


                        <a
                            href="${pageContext.request.contextPath}/login.jsp"
                            class="btn nav-outline-btn">

                            <i class="bi bi-box-arrow-in-right"></i>

                            Login

                        </a>


                        <a
                            href="${pageContext.request.contextPath}/register.jsp"
                            class="btn btn-gold">

                            <i class="bi bi-person-plus"></i>

                            Register

                        </a>


                        <a
                            href="${pageContext.request.contextPath}/adminLogin.jsp"
                            class="btn nav-admin-btn">

                            <i class="bi bi-shield-lock"></i>

                            Admin

                        </a>


                    </c:otherwise>


                </c:choose>


            </div>

        </div>

    </div>

</nav>


<!-- =========================================================
     DARK/LIGHT THEME JAVASCRIPT
     ========================================================= -->

