<% request.setAttribute("pageTitle", "Login"); %>
<%@ include file="header.jsp" %>

<section class="auth-wrapper">
    <div class="container-fluid p-0">
        <div class="row g-0 h-100">
            <div class="col-lg-5 auth-side">
                <i class="bi bi-shield-check fs-1 mb-3" style="color: var(--gold-500);"></i>
                <h2 style="color:#fff;">Welcome back</h2>
                <p class="text-white-50">Log in to file a new report, view your submission history, or check
                    the latest status updates on your open cases.</p>
            </div>
            <div class="col-lg-7 auth-form-side d-flex align-items-center">
                <div class="w-100 mx-auto" style="max-width: 440px;">
                    <h3 class="mb-1">User Login</h3>
                    <p class="text-muted-custom mb-4">Enter your credentials to continue.</p>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-triangle"></i> ${errorMessage}</div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-auto-dismiss"><i class="bi bi-check-circle"></i> ${successMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="form-cts needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   value="${email}" data-validate="email" data-label="Email" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   data-validate="required" data-label="Password" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <button type="submit" class="btn btn-navy w-100 py-2">
                            <i class="bi bi-box-arrow-in-right"></i> Log In
                        </button>
                        <p class="text-center small text-muted-custom mt-3 mb-0">
                            Don't have an account?
                            <a href="${pageContext.request.contextPath}/register.jsp">Register here</a>
                        </p>
                        <p class="text-center small mt-2 mb-0">
                            <a href="${pageContext.request.contextPath}/adminLogin.jsp"><i class="bi bi-shield-lock"></i> Login as Admin instead</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
