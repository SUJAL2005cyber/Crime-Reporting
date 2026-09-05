<% request.setAttribute("pageTitle", "About"); %>
<%@ include file="header.jsp" %>

<section class="py-5 mt-3">
    <div class="container">
        <div class="row g-5 align-items-center">
            <div class="col-lg-6">
                <div class="section-eyebrow mb-2">ABOUT THE PLATFORM</div>
                <h1 class="fw-semibold mb-3">Bridging citizens and law enforcement</h1>
                <p class="text-muted-custom">The Crime Reporting System is a web platform that lets residents
                    file non-emergency crime reports online, attach supporting evidence, and track investigation
                    progress in real time. It gives police administrators a single dashboard to triage, assign,
                    and update the status of every case filed in their jurisdiction.</p>
                <p class="text-muted-custom">Built on a Java Servlet/JSP MVC architecture with a MySQL backend,
                    the system emphasizes data integrity (referential foreign keys between users, reports,
                    evidence, and status history) and basic security practice (hashed passwords, parameterized
                    SQL, and session-based role separation between citizens and administrators).</p>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="card-cts p-4 text-center h-100">
                            <i class="bi bi-people fs-1 mb-2" style="color: var(--steel-600);"></i>
                            <div class="h4 mb-0">Citizens</div>
                            <div class="small text-muted-custom">File &amp; track reports</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card-cts p-4 text-center h-100">
                            <i class="bi bi-shield-lock fs-1 mb-2" style="color: var(--gold-600);"></i>
                            <div class="h4 mb-0">Officers</div>
                            <div class="small text-muted-custom">Investigate &amp; resolve</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card-cts p-4 text-center h-100">
                            <i class="bi bi-folder2-open fs-1 mb-2" style="color: var(--status-resolved);"></i>
                            <div class="h4 mb-0">Evidence</div>
                            <div class="small text-muted-custom">Photos, PDFs &amp; docs</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card-cts p-4 text-center h-100">
                            <i class="bi bi-clipboard-data fs-1 mb-2" style="color: var(--status-rejected);"></i>
                            <div class="h4 mb-0">Audit Trail</div>
                            <div class="small text-muted-custom">Full status history</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5" style="background: var(--surface);">
    <div class="container">
        <div class="text-center mb-5">
            <div class="section-eyebrow mb-2">OUR MISSION</div>
            <h2 class="fw-semibold">Making crime reporting accessible</h2>
            <hr class="divider-gold mx-auto">
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="d-flex gap-3">
                    <div class="icon-tile"><i class="bi bi-lightning-charge"></i></div>
                    <div>
                        <h6 class="mb-1">Fast</h6>
                        <p class="small text-muted-custom mb-0">File a report in minutes, from any device, at any hour.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="d-flex gap-3">
                    <div class="icon-tile"><i class="bi bi-eye"></i></div>
                    <div>
                        <h6 class="mb-1">Transparent</h6>
                        <p class="small text-muted-custom mb-0">Track exactly where your case stands, with a status
                            history you can see for yourself.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="d-flex gap-3">
                    <div class="icon-tile"><i class="bi bi-lock"></i></div>
                    <div>
                        <h6 class="mb-1">Secure</h6>
                        <p class="small text-muted-custom mb-0">Passwords are hashed and salted; all database
                            queries use parameterized statements.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
