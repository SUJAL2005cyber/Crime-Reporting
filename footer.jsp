<footer class="site-footer">
    <div class="container">
        <div class="row gy-4">
            <div class="col-md-4">
                <a class="navbar-brand mb-2 d-inline-block" href="${pageContext.request.contextPath}/index.jsp">
                    <i class="bi bi-shield-shaded" style="color: var(--gold-500);"></i>
                    Crime<span style="color: var(--gold-500);">Report</span>
                </a>
                <p class="small mb-0">A secure platform for citizens to report incidents, upload evidence,
                    and track investigation status  connecting the public with local law enforcement.</p>
            </div>
            <div class="col-6 col-md-2">
                <h6>Navigate</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a></li>
                </ul>
            </div>
            <div class="col-6 col-md-3">
                <h6>Services</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/reportCrime.jsp">Report a Crime</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/trackStatus.jsp">Track Case Status</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/adminLogin.jsp">Admin / Officer Login</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Emergency</h6>
                <p class="small mb-1"><i class="bi bi-telephone-fill me-1"></i> Emergency Helpline: 100</p>
                <p class="small mb-0"><i class="bi bi-envelope-fill me-1"></i> support@crimereport.gov</p>
            </div>
        </div>
        <hr>
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center small">
            <span>&copy; 2026 Crime Reporting System. All rights reserved.</span>
            <span class="text-muted">Built for public safety &amp; transparency.</span>
        </div>
    </div>
</footer>
<footer>
    <!-- footer content -->
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}validation.js"></script>
<script src="${pageContext.request.contextPath}main.js"></script>
</body>
</html>
