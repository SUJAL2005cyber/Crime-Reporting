<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
request.setAttribute("pageTitle", "My Reports");
%>

<jsp:include page="header.jsp" />


<section class="py-5 mt-2">

	<div class="container">


		<div
			class="d-flex flex-wrap
                    justify-content-between
                    align-items-end
                    mb-4 gap-3">

			<div>

				<div class="section-eyebrow mb-2">MY SUBMISSIONS</div>

				<h1 class="fw-semibold mb-0">My Reported Crimes</h1>

			</div>


			<a href="${pageContext.request.contextPath}/reportCrime.jsp"
				class="btn btn-navy"> <i class="bi bi-file-earmark-plus"></i>

				File New Report

			</a>

		</div>


		<c:if test="${not empty errorMessage}">

			<div class="alert alert-danger">

				<i class="bi bi-exclamation-triangle me-1"></i>

				<c:out value="${errorMessage}" />

			</div>

		</c:if>


		<c:choose>


			<c:when test="${empty reports}">

				<div class="card-cts p-5 text-center">

					<i
						class="bi bi-inbox
                              fs-1
                              text-muted-custom
                              mb-3">
					</i>


					<h5>No reports yet</h5>


					<p class="text-muted-custom">You haven't filed any crime
						reports. Reports you submit will appear here with their live
						status.</p>


					<a href="${pageContext.request.contextPath}/reportCrime.jsp"
						class="btn btn-gold mx-auto mt-2"> <i
						class="bi bi-file-earmark-plus me-1"></i> File Your First Report

					</a>

				</div>

			</c:when>


			<c:otherwise>


				<div class="row g-4">


					<c:forEach var="r" items="${reports}">


						<div class="col-12 col-md-6">


							<div
								class="case-card
                                        status-${fn:toLowerCase(r.currentStatus)}
                                        h-100
                                        p-4">


								<div
									class="d-flex
                                            justify-content-between
                                            align-items-start
                                            flex-wrap
                                            gap-2
                                            mb-3">


									<span class="case-id-stamp"> <c:out value="${r.caseId}" />

									</span> <span
										class="status-badge
                                                status-${fn:toLowerCase(r.currentStatus)}">

										<c:out value="${r.currentStatus}" />

									</span>


								</div>


								<h5 class="mb-2">

									<c:out value="${r.crimeType}" />

								</h5>


								<p
									class="small
                                          text-muted-custom
                                          report-description
                                          mb-3">

									<c:out value="${r.description}" />

								</p>


								<div class="report-information">


									<div
										class="small
                                                text-muted-custom
                                                mb-2">

										<i class="bi bi-geo-alt me-1"></i>

										<c:out value="${r.location}" />

										<c:if test="${not empty r.city}">
                                            ,
                                            <c:out value="${r.city}" />
										</c:if>

									</div>


									<div
										class="small
                                                text-muted-custom
                                                mb-2">

										<i class="bi bi-calendar-event me-1"></i>

										<fmt:formatDate value="${r.incidentDate}"
											pattern="dd MMM yyyy" />

										<c:if test="${not empty r.incidentTime}">

                                            at

                                            <fmt:formatDate
												value="${r.incidentTime}" pattern="hh:mm a" />

										</c:if>

									</div>


									<c:if test="${not empty r.reportedAt}">

										<div
											class="small
                                                    text-muted-custom
                                                    mb-2">

											<i class="bi bi-clock-history me-1"></i> Filed

											<fmt:formatDate value="${r.reportedAt}"
												pattern="dd MMM yyyy, hh:mm a" />

										</div>

									</c:if>


								</div>


								<c:if test="${not empty r.evidenceList}">

									<div
										class="report-evidence-info
                                                small
                                                mt-3">

										<i class="bi bi-paperclip me-1"></i> <strong> <c:out
												value="${fn:length(r.evidenceList)}" />

										</strong> evidence file(s) attached

									</div>

								</c:if>


								<c:if test="${not empty r.statusRemarks}">

									<div
										class="status-update-box
                                                small
                                                mt-3
                                                p-3
                                                rounded-3">

										<div class="fw-semibold mb-1">

											<i class="bi bi-chat-left-text me-1"></i> Latest Update

										</div>


										<div class="text-muted-custom">

											<c:out value="${r.statusRemarks}" />

										</div>

									</div>

								</c:if>


								<div class="mt-4 pt-3 report-card-footer">

									<a
										href="${pageContext.request.contextPath}/TrackStatusServlet?caseId=${r.caseId}"
										class="btn btn-outline-primary btn-sm"> <i
										class="bi bi-search me-1"></i> View Status

									</a>

								</div>


							</div>


						</div>


					</c:forEach>


				</div>


			</c:otherwise>


		</c:choose>


	</div>

</section>


<jsp:include page="footer.jsp" />