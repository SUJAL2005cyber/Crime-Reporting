<% request.setAttribute("pageTitle", "Home"); %>
<%@ include file="header.jsp" %>

<!-- HERO -->
<section class="hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <div class="eyebrow mb-3"><i class="bi bi-broadcast-pin"></i> PUBLIC SAFETY PLATFORM</div>
                <h1 class="mb-3">Report. Track. <span style="color: var(--gold-500);">Resolve.</span></h1>
                <p class="lead mb-4">A secure, transparent way to report crimes, submit evidence, and follow
                    your case from filing to resolution from any device.</p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="${pageContext.request.contextPath}/reportCrime.jsp" class="btn btn-gold btn-lg px-4">
                        <i class="bi bi-file-earmark-plus"></i> Report a Crime
                    </a>
                    <a href="${pageContext.request.contextPath}/trackStatus.jsp" class="btn btn-outline-light btn-lg px-4">
                        <i class="bi bi-search"></i> Track Case Status
                    </a>
                </div>
                <div class="row mt-5 g-3 text-center text-lg-start">
                    <div class="col-4">
                        <div class="h3 mb-0" style="color:#fff;">24/7</div>
                        <div class="small text-white-50">Report Filing</div>
                    </div>
                    <div class="col-4">
                        <div class="h3 mb-0" style="color:#fff;">100%</div>
                        <div class="small text-white-50">Case Traceability</div>
                    </div>
                    <div class="col-4">
                        <div class="h3 mb-0" style="color:#fff;">Secure</div>
                        <div class="small text-white-50">Encrypted Data</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-block text-center">
                <i class="bi bi-shield-shaded" style="font-size: 15rem; color: rgba(200,155,60,0.18);"></i>
            </div>
        </div>
    </div>
</section>

<!-- FEATURES -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <div class="section-eyebrow mb-2">HOW IT WORKS</div>
            <h2 class="fw-semibold">Three steps to a filed case</h2>
            <hr class="divider-gold mx-auto">
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card-cts p-4 h-100">
                    <div class="icon-tile mb-3"><i class="bi bi-person-plus"></i></div>
                    <h5 class="mb-2">1. Create an Account</h5>
                    <p class="text-muted-custom small mb-0">Register with your contact details in under a minute.
                        Your identity stays linked only to your own case history.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-cts p-4 h-100">
                    <div class="icon-tile mb-3"><i class="bi bi-file-earmark-text"></i></div>
                    <h5 class="mb-2">2. File Your Report</h5>
                    <p class="text-muted-custom small mb-0">Describe the incident, add the date, time and location,
                        and attach photos or documents as evidence.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-cts p-4 h-100">
                    <div class="icon-tile mb-3"><i class="bi bi-graph-up-arrow"></i></div>
                    <h5 class="mb-2">3. Track Progress</h5>
                    <p class="text-muted-custom small mb-0">Follow your Case ID as it moves from
                        Pending &rarr; Investigating &rarr; Resolved.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- STATUS LEGEND -->
<section class="py-5" style="background: var(--surface);">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-lg-5">
                <div class="section-eyebrow mb-2">CASE STATUS</div>
                <h2 class="fw-semibold mb-3">Always know where your case stands</h2>
                <p class="text-muted-custom">Every report moves through a clear lifecycle. Color-coded status
                    badges make it easy to see progress at a glance, on your dashboard or the public tracker.</p>
                <a href="${pageContext.request.contextPath}/trackStatus.jsp" class="btn btn-outline-navy mt-2">
                    Check a Case ID <i class="bi bi-arrow-right"></i>
                </a>
            </div>
            <div class="col-lg-7">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <div class="case-card status-pending">
                            <span class="status-badge status-pending mb-2">Pending</span>
                            <p class="small text-muted-custom mb-0">Report received and awaiting review by an officer.</p>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="case-card status-investigating">
                            <span class="status-badge status-investigating mb-2">Investigating</span>
                            <p class="small text-muted-custom mb-0">An officer has been assigned and is actively investigating.</p>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="case-card status-resolved">
                            <span class="status-badge status-resolved mb-2">Resolved</span>
                            <p class="small text-muted-custom mb-0">The case has been closed with an outcome on file.</p>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="case-card status-rejected">
                            <span class="status-badge status-rejected mb-2">Rejected</span>
                            <p class="small text-muted-custom mb-0">The report did not meet criteria for investigation.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-5">
    <div class="container">
        <div class="rounded-4 p-5 text-center" style="background: var(--navy-950);">
            <h3 class="mb-2" style="color: #fff;">Witnessed or experienced an incident?</h3>
            <p class="text-white-50 mb-4">Every report helps build a safer community. It only takes a few minutes.</p>
            <a href="${pageContext.request.contextPath}/reportCrime.jsp" class="btn btn-gold btn-lg px-5">
                <i class="bi bi-file-earmark-plus"></i> File a Report Now
            </a>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
