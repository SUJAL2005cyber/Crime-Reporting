<% request.setAttribute("pageTitle", "Contact Us"); %>
<%@ include file="header.jsp" %>

<section class="py-5 mt-2">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-5">
                <div class="section-eyebrow mb-2">GET IN TOUCH</div>
                <h1 class="fw-semibold mb-3">Contact Us</h1>
                <p class="text-muted-custom mb-4">Have a question about an existing case, or feedback on the
                    platform? Send us a message and our support team will respond within 1–2 business days.
                    For emergencies, always call 100.</p>

                <div class="d-flex gap-3 mb-3">
                    <div class="icon-tile"><i class="bi bi-telephone"></i></div>
                    <div>
                        <div class="fw-semibold">Helpline</div>
                        <div class="small text-muted-custom">100 (Emergency) / 1091 (Women's Helpline)</div>
                    </div>
                </div>
                <div class="d-flex gap-3 mb-3">
                    <div class="icon-tile"><i class="bi bi-envelope"></i></div>
                    <div>
                        <div class="fw-semibold">Email</div>
                        <div class="small text-muted-custom">support@crimereport.gov</div>
                    </div>
                </div>
                <div class="d-flex gap-3">
                    <div class="icon-tile"><i class="bi bi-geo-alt"></i></div>
                    <div>
                        <div class="fw-semibold">Head Office</div>
                        <div class="small text-muted-custom">District Police Headquarters, Civil Lines</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="card-cts p-4 p-md-5">
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-auto-dismiss"><i class="bi bi-check-circle"></i> ${successMessage}</div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> ${errorMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/ContactServlet" method="post" class="form-cts needs-validation" novalidate>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Your Name *</label>
                                <input type="text" class="form-control" id="name" name="name"
                                       data-validate="fullName" data-label="Name" required>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email Address *</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       data-validate="email" data-label="Email" required>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-12">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject">
                            </div>
                            <div class="col-12">
                                <label for="message" class="form-label">Message *</label>
                                <textarea class="form-control" id="message" name="message" rows="5"
                                          data-validate="minLength" data-min="10" data-label="Message" required></textarea>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-navy w-100 py-2 mt-4">
                            <i class="bi bi-send"></i> Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
