<% request.setAttribute("pageTitle", "Report Submitted"); %>
<%@ include file="header.jsp" %>

<section class="py-5 mt-3">
    <div class="container text-center" style="max-width: 620px;">
        <i class="bi bi-check-circle-fill" style="font-size: 4rem; color: var(--status-resolved);"></i>
        <h1 class="fw-semibold mt-3 mb-2">Report Submitted</h1>
        <p class="text-muted-custom mb-4">${successMessage}</p>

        <div class="card-cts p-4 mb-4">
            <div class="small text-muted-custom mb-1">YOUR CASE ID</div>
            <div class="d-flex align-items-center justify-content-center gap-3">
                <span class="case-id-stamp fs-5">${caseId}</span>
                <button class="btn btn-outline-navy btn-sm copy-case-id" data-case-id="${caseId}">
                    <i class="bi bi-clipboard"></i> Copy
                </button>
            </div>
            <p class="small text-muted-custom mt-3 mb-0">
                Save this Case ID — you'll need it to track your report's status.
            </p>
        </div>

        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/trackStatus.jsp?caseId=${caseId}" class="btn btn-navy">
                <i class="bi bi-search"></i> Track This Case
            </a>
            <a href="${pageContext.request.contextPath}/ViewReportsServlet" class="btn btn-outline-navy">
                <i class="bi bi-list-ul"></i> View My Reports
            </a>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
