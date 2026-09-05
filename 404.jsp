<% request.setAttribute("pageTitle", "Page Not Found"); %>
<%@ include file="header.jsp" %>

<section class="py-5 mt-5 text-center">
    <div class="container" style="max-width: 520px;">
        <i class="bi bi-signpost-split fs-1" style="color: var(--gold-500);"></i>
        <h1 class="fw-semibold mt-3">404 — Page Not Found</h1>
        <p class="text-muted-custom mb-4">The page you're looking for doesn't exist or may have moved.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-navy">
            <i class="bi bi-house"></i> Back to Home
        </a>
    </div>
</section>

<%@ include file="footer.jsp" %>
