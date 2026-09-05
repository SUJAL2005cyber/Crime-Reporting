<% request.setAttribute("pageTitle", "Register"); %>
<%@ include file="header.jsp" %>

<section class="auth-wrapper">
    <div class="container-fluid p-0">
        <div class="row g-0 h-100">
            <div class="col-lg-5 auth-side">
                <i class="bi bi-shield-shaded fs-1 mb-3" style="color: var(--gold-500);"></i>
                <h2 style="color:#fff;">Join the platform</h2>
                <p class="text-white-50">Create an account to file crime reports, upload evidence, and track
                    the status of every case you submit.</p>
                <ul class="list-unstyled text-white-50 small mt-4">
                    <li class="mb-2"><i class="bi bi-check2-circle" style="color: var(--gold-500);"></i> Free &amp; takes under a minute</li>
                    <li class="mb-2"><i class="bi bi-check2-circle" style="color: var(--gold-500);"></i> Your data is encrypted at rest</li>
                    <li class="mb-2"><i class="bi bi-check2-circle" style="color: var(--gold-500);"></i> Track unlimited reports</li>
                </ul>
            </div>
            <div class="col-lg-7 auth-form-side d-flex align-items-center">
                <div class="w-100 mx-auto" style="max-width: 480px;">
                    <h3 class="mb-1">Create Your Account</h3>
                    <p class="text-muted-custom mb-4">Fields marked * are required.</p>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-triangle"></i> ${errorMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="form-cts needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name *</label>
                            <input type="text" class="form-control" id="fullName" name="fullName"
                                   value="${fullName}" data-validate="fullName" data-label="Full name" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address *</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   value="${email}" data-validate="email" data-label="Email" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number *</label>
                            <input type="tel" class="form-control" id="phone" name="phone" maxlength="10"
                                   value="${phone}" data-validate="phone" data-label="Phone number" required placeholder="10-digit mobile number">
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address *</label>
                            <textarea class="form-control" id="address" name="address" rows="2"
                                      data-validate="address" data-label="Address" required>${address}</textarea>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password *</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   data-validate="password" data-label="Password" required>
                            <div class="invalid-feedback"></div>
                            <div class="password-strength-bar"><div class="fill"></div></div>
                            <small id="passwordStrengthLabel" class="fw-semibold"></small>
                        </div>
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">Confirm Password *</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                   data-validate="confirmPassword" data-label="Confirm password" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <button type="submit" class="btn btn-navy w-100 py-2">
                            <i class="bi bi-person-plus"></i> Create Account
                        </button>
                        <p class="text-center small text-muted-custom mt-3 mb-0">
                            Already have an account?
                            <a href="${pageContext.request.contextPath}/login.jsp">Log in</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
