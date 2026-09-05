<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    request.setAttribute("pageTitle", "Track Status");
%>

<jsp:include page="header.jsp" />


<section class="py-5 mt-2">

    <div class="container" style="max-width: 720px;">


        <!-- Page Heading -->

        <div class="text-center mb-4">

            <div class="section-eyebrow mb-2">
                CASE STATUS TRACKER
            </div>

            <h1 class="fw-semibold">
                Track Your Case
            </h1>

            <p class="text-muted-custom">
                Enter the Case ID you received at submission
                (e.g. CR-2026-000042).
            </p>

        </div>


        <!-- Search Form -->

        <form
            action="${pageContext.request.contextPath}/TrackStatusServlet"
            method="get"
            class="form-cts d-flex gap-2 mb-4">

            <input
                type="text"
                class="form-control form-control-lg"
                name="caseId"
                placeholder="CR-2026-000042"
                value="<c:out value='${param.caseId}'/>"
                required>

            <button
                type="submit"
                class="btn btn-navy btn-lg px-4">

                <i class="bi bi-search"></i>

            </button>

        </form>


        <!-- Error Message -->

        <c:if test="${not empty errorMessage}">

            <div class="alert alert-warning">

                <i class="bi bi-exclamation-circle me-1"></i>

                <c:out value="${errorMessage}" />

            </div>

        </c:if>


        <!-- Case Result -->

        <c:if test="${not empty report}">

            <div class="case-card status-${fn:toLowerCase(report.currentStatus)} p-4">


                <!-- Case Header -->

                <div class="d-flex justify-content-between align-items-start mb-3 flex-wrap gap-2">

                    <div>

                        <span class="case-id-stamp fs-6">

                            <c:out value="${report.caseId}" />

                        </span>


                        <h5 class="mt-2 mb-0">

                            <c:out value="${report.crimeType}" />

                        </h5>

                    </div>


                    <span class="status-badge status-${fn:toLowerCase(report.currentStatus)} fs-6">

                        <c:out value="${report.currentStatus}" />

                    </span>

                </div>


                <!-- Description -->

                <p class="text-muted-custom">

                    <c:out value="${report.description}" />

                </p>


                <!-- Case Information -->

                <div class="row small text-muted-custom g-2 mb-3">


                    <!-- Location -->

                    <div class="col-sm-6">

                        <i class="bi bi-geo-alt me-1"></i>

                        <c:out value="${report.location}" />,

                        <c:out value="${report.city}" />

                    </div>


                    <!-- Incident Date -->

                    <div class="col-sm-6">

                        <i class="bi bi-calendar-event me-1"></i>

                        <fmt:formatDate
                            value="${report.incidentDate}"
                            pattern="dd MMM yyyy" />

                        at

                        <fmt:formatDate
                            value="${report.incidentTime}"
                            pattern="hh:mm a" />

                    </div>


                    <!-- Reported Date -->

                    <div class="col-sm-6">

                        <i class="bi bi-clock-history me-1"></i>

                        Filed on

                        <fmt:formatDate
                            value="${report.reportedAt}"
                            pattern="dd MMM yyyy, hh:mm a" />

                    </div>


                    <!-- Reporter -->

                    <div class="col-sm-6">

                        <i class="bi bi-person me-1"></i>

                        Reported by

                        <c:out value="${report.reporterName}" />

                    </div>

                </div>


                <!-- Latest Status Remark -->

                <c:if test="${not empty report.statusRemarks}">

                    <div class="status-update-box p-3 rounded-3">

                        <div class="small fw-semibold mb-1">

                            <i class="bi bi-chat-left-text me-1"></i>

                            Latest Update

                        </div>


                        <div class="small text-muted-custom">

                            <c:out value="${report.statusRemarks}" />

                        </div>

                    </div>

                </c:if>


                <!-- Evidence -->

                <c:if test="${not empty report.evidenceList}">

                    <div class="mt-4">

                        <div class="small fw-semibold mb-2">

                            <i class="bi bi-paperclip me-1"></i>

                            Evidence Files

                        </div>


                        <div class="d-flex flex-wrap gap-2">

                            <c:forEach
                                var="ev"
                                items="${report.evidenceList}">

                                <span class="evidence-chip">

                                    <i class="bi bi-file-earmark me-1"></i>

                                    <c:out value="${ev.fileName}" />

                                </span>

                            </c:forEach>

                        </div>

                    </div>

                </c:if>


                <!-- Status Progress -->

                <div class="mt-4">

                    <div class="d-flex justify-content-between small text-muted-custom mb-2">

                        <span>Pending</span>

                        <span>Investigating</span>

                        <span>Resolved</span>

                    </div>


                    <div
                        class="progress"
                        style="height: 8px; border-radius: 6px;">


                        <c:choose>


                            <c:when test="${report.currentStatus eq 'Pending'}">

                                <div
                                    class="progress-bar status-progress-pending"
                                    style="width: 15%;">
                                </div>

                            </c:when>


                            <c:when test="${report.currentStatus eq 'Investigating'}">

                                <div
                                    class="progress-bar status-progress-investigating"
                                    style="width: 55%;">
                                </div>

                            </c:when>


                            <c:when test="${report.currentStatus eq 'Resolved'}">

                                <div
                                    class="progress-bar status-progress-resolved"
                                    style="width: 100%;">
                                </div>

                            </c:when>


                            <c:otherwise>

                                <div
                                    class="progress-bar status-progress-rejected"
                                    style="width: 100%;">
                                </div>

                            </c:otherwise>


                        </c:choose>


                    </div>

                </div>


            </div>

        </c:if>


    </div>

</section>


<jsp:include page="footer.jsp" />