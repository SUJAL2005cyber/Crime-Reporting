<% request.setAttribute("pageTitle", "Manage Users"); %>
<%@ include file="header.jsp" %>

<section class="py-5 mt-2">
    <div class="container">
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-3">
            <div>
                <div class="section-eyebrow mb-2">USER MANAGEMENT</div>
                <h1 class="fw-semibold mb-0">Registered Citizens</h1>
            </div>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="btn btn-outline-navy">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> ${errorMessage}</div>
        </c:if>

        <div class="card-cts p-0">
            <div class="table-responsive">
                <table class="table table-cts mb-0">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Registered On</th>
                        <th>Status</th>
                        <th class="text-end">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td class="fw-semibold">${u.fullName}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td><fmt:formatDate value="${u.createdAt}" pattern="dd MMM yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.active}">
                                        <span class="status-badge status-resolved">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-rejected">Suspended</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <form action="${pageContext.request.contextPath}/ManageUsersServlet" method="post" class="d-inline">
                                    <input type="hidden" name="userId" value="${u.userId}">
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <input type="hidden" name="activate" value="false">
                                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                                <i class="bi bi-slash-circle"></i> Suspend
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="activate" value="true">
                                            <button type="submit" class="btn btn-outline-navy btn-sm">
                                                <i class="bi bi-check2-circle"></i> Reactivate
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr><td colspan="6" class="text-center py-4 text-muted-custom">No registered users yet.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
