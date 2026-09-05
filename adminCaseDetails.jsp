<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
request.setAttribute("pageTitle", "Case Details");
%>

<jsp:include page="header.jsp" />


<div class="container py-5">

	<div
		class="d-flex flex-column flex-md-row
		justify-content-between align-items-md-center
		gap-3 mb-4">

		<div>
			<h2 class="fw-bold mb-1">
				<i class="bi bi-folder2-open me-2"></i> Case Details
			</h2>

			<p class="text-muted mb-0">Review complete crime report
				information and uploaded evidence.</p>
		</div>

		<div>
			<a href="${pageContext.request.contextPath}/AdminDashboardServlet"
				class="btn btn-outline-secondary"> <i
				class="bi bi-arrow-left me-1"></i> Back to Dashboard

			</a>
		</div>

	</div>


	<c:choose>

		<c:when test="${not empty report}">

			<%-- CASE SUMMARY --%>

			<div class="card shadow-sm border-0 mb-4">

				<div class="card-header bg-white py-3">

					<div
						class="d-flex justify-content-between
						align-items-center flex-wrap gap-2">

						<div>

							<h5 class="fw-bold mb-1">

								<i class="bi bi-shield-check me-2"></i> Case <span
									class="text-primary"> <c:out value="${report.caseId}" />
								</span>

							</h5>

							<small class="text-muted"> Report ID: <c:out
									value="${report.reportId}" />
							</small>

						</div>


						<div>

							<c:choose>

								<c:when test="${report.currentStatus == 'Pending'}">

									<span class="badge bg-warning text-dark fs-6"> <i
										class="bi bi-clock me-1"></i> Pending
									</span>

								</c:when>

								<c:when test="${report.currentStatus == 'Investigating'}">

									<span class="badge bg-info text-dark fs-6"> <i
										class="bi bi-search me-1"></i> Investigating
									</span>

								</c:when>

								<c:when test="${report.currentStatus == 'Resolved'}">

									<span class="badge bg-success fs-6"> <i
										class="bi bi-check-circle me-1"></i> Resolved
									</span>

								</c:when>

								<c:when test="${report.currentStatus == 'Rejected'}">

									<span class="badge bg-danger fs-6"> <i
										class="bi bi-x-circle me-1"></i> Rejected
									</span>

								</c:when>

								<c:otherwise>

									<span class="badge bg-secondary fs-6"> <c:out
											value="${report.currentStatus}" default="Pending" />
									</span>

								</c:otherwise>

							</c:choose>

						</div>

					</div>

				</div>


				<div class="card-body">

					<div class="row g-4">

						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Reported By </small>

							<div class="fw-semibold">

								<i class="bi bi-person me-1"></i>

								<c:out value="${report.reporterName}" default="Unknown" />

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Reporter Email </small>

							<div>

								<i class="bi bi-envelope me-1"></i>

								<c:out value="${report.reporterEmail}" default="Not available" />

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Crime Type </small>

							<div class="fw-semibold">

								<i class="bi bi-exclamation-triangle me-1"></i>

								<c:out value="${report.crimeType}" />

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Report Submitted
							</small>

							<div>

								<c:choose>

									<c:when test="${not empty report.reportedAt}">

										<i class="bi bi-calendar3 me-1"></i>

										<fmt:formatDate value="${report.reportedAt}"
											pattern="dd MMM yyyy, hh:mm a" />

									</c:when>

									<c:otherwise>

										<span class="text-muted"> Not available </span>

									</c:otherwise>

								</c:choose>

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Incident Date </small>

							<div>

								<i class="bi bi-calendar-event me-1"></i>

								<c:choose>

									<c:when test="${not empty report.incidentDate}">

										<fmt:formatDate value="${report.incidentDate}"
											pattern="dd MMM yyyy" />

									</c:when>

									<c:otherwise>
										Not available
									</c:otherwise>

								</c:choose>

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Incident Time </small>

							<div>

								<i class="bi bi-clock me-1"></i>

								<c:out value="${report.incidentTime}" default="Not available" />

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> Location </small>

							<div>

								<i class="bi bi-geo-alt me-1"></i>

								<c:out value="${report.location}" />

							</div>

						</div>


						<div class="col-md-6">

							<small class="text-muted d-block mb-1"> City </small>

							<div>

								<i class="bi bi-building me-1"></i>

								<c:out value="${report.city}" />

							</div>

						</div>

					</div>

				</div>

			</div>


			<%-- INCIDENT DESCRIPTION --%>

			<div class="card shadow-sm border-0 mb-4">

				<div class="card-header bg-white py-3">

					<h5 class="fw-bold mb-0">
						<i class="bi bi-file-text me-2"></i> Incident Description
					</h5>

				</div>

				<div class="card-body">

					<p class="mb-0" style="white-space: pre-wrap;">
						<c:out value="${report.description}" />
					</p>

				</div>

			</div>


			<%-- STATUS INFORMATION --%>

			<div class="card shadow-sm border-0 mb-4">

				<div class="card-header bg-white py-3">

					<h5 class="fw-bold mb-0">
						<i class="bi bi-activity me-2"></i> Case Status
					</h5>

				</div>

				<div class="card-body">

					<div class="row g-4">

						<div class="col-md-4">

							<small class="text-muted d-block mb-1"> Current Status </small> <strong>
								<c:out value="${report.currentStatus}" default="Pending" />
							</strong>

						</div>


						<div class="col-md-4">

							<small class="text-muted d-block mb-1"> Assigned Admin </small>

							<c:choose>

								<c:when test="${not empty report.assignedAdmin}">

									<span class="badge bg-primary"> <i
										class="bi bi-person-badge me-1"></i> Admin #<c:out
											value="${report.assignedAdmin}" />

									</span>

								</c:when>

								<c:otherwise>

									<span class="text-muted"> Unassigned </span>

								</c:otherwise>

							</c:choose>

						</div>


						<div class="col-md-4">

							<small class="text-muted d-block mb-1"> Case ID </small> <strong>
								<c:out value="${report.caseId}" />
							</strong>

						</div>


						<div class="col-12">

							<small class="text-muted d-block mb-1"> Latest Remarks </small>

							<c:choose>

								<c:when test="${not empty report.statusRemarks}">

									<div class="alert alert-light border mb-0">

										<c:out value="${report.statusRemarks}" />

									</div>

								</c:when>

								<c:otherwise>

									<span class="text-muted"> No remarks available. </span>

								</c:otherwise>

							</c:choose>

						</div>

					</div>

				</div>

			</div>


			<%-- EVIDENCE SECTION --%>

			<div class="card shadow-sm border-0 mb-4">

				<div class="card-header bg-white py-3">

					<div
						class="d-flex justify-content-between
						align-items-center">

						<h5 class="fw-bold mb-0">

							<i class="bi bi-paperclip me-2"></i> Evidence

						</h5>

						<span class="badge bg-primary">

							${fn:length(report.evidenceList)} File(s) </span>

					</div>

				</div>


				<div class="card-body">

					<c:choose>

						<c:when test="${not empty report.evidenceList}">

							<div class="row g-3">

								<c:forEach var="e" items="${report.evidenceList}">

									<div class="col-lg-4 col-md-6">

										<div class="card h-100 border">

											<div class="card-body">

												<div class="d-flex
													align-items-start gap-3">

													<div class="fs-2">

														<c:choose>

															<c:when
																test="${e.fileType == 'jpg'
																|| e.fileType == 'jpeg'
																|| e.fileType == 'png'}">

																<i
																	class="bi bi-file-earmark-image
																	text-primary"></i>

															</c:when>

															<c:when test="${e.fileType == 'pdf'}">

																<i
																	class="bi bi-file-earmark-pdf
																	text-danger"></i>

															</c:when>

															<c:when test="${e.fileType == 'mp4'}">

																<i
																	class="bi bi-file-earmark-play
																	text-info"></i>

															</c:when>

															<c:when test="${e.fileType == 'docx'}">

																<i
																	class="bi bi-file-earmark-word
																	text-primary"></i>

															</c:when>

															<c:otherwise>

																<i
																	class="bi bi-file-earmark
																	text-secondary"></i>

															</c:otherwise>

														</c:choose>

													</div>


													<div class="flex-grow-1" style="min-width: 0;">

														<h6 class="mb-1 text-truncate">

															<c:out value="${e.fileName}" />

														</h6>


														<small class="text-muted d-block"> Type: <c:out
																value="${fn:toUpperCase(e.fileType)}" />

														</small> <small class="text-muted d-block"> Size: <c:choose>

																<c:when test="${e.fileSizeKb >= 1024}">

																	<fmt:formatNumber value="${e.fileSizeKb / 1024.0}"
																		maxFractionDigits="2" />

																	MB

																</c:when>

																<c:otherwise>

																	<c:out value="${e.fileSizeKb}" />
																	KB

																</c:otherwise>

															</c:choose>

														</small>


														<c:if test="${not empty e.uploadedAt}">

															<small class="text-muted d-block"> Uploaded: <fmt:formatDate
																	value="${e.uploadedAt}" pattern="dd MMM yyyy, hh:mm a" />

															</small>

														</c:if>

													</div>

												</div>


												<div class="mt-3 d-grid">

													<a
														href="${pageContext.request.contextPath}/ViewEvidenceServlet?evidenceId=${e.evidenceId}"
														target="_blank" class="btn btn-sm btn-outline-primary">

														<i class="bi bi-eye me-1"></i> View Evidence

													</a>

												</div>

											</div>

										</div>

									</div>

								</c:forEach>

							</div>

						</c:when>


						<c:otherwise>

							<div class="text-center py-5">

								<i class="bi bi-file-earmark-x
									fs-1 text-muted"></i>

								<h6 class="mt-3">No Evidence Uploaded</h6>

								<p class="text-muted mb-0">The citizen did not attach
									evidence to this report.</p>

							</div>

						</c:otherwise>

					</c:choose>

				</div>

			</div>


			<%-- ADMIN STATUS UPDATE --%>

			<div class="card shadow-sm border-0 mb-4">

				<div class="card-header bg-white py-3">

					<h5 class="fw-bold mb-0">
						<i class="bi bi-gear me-2"></i> Admin Action
					</h5>

				</div>


				<div class="card-body">

					<form
						action="${pageContext.request.contextPath}/UpdateStatusServlet"
						method="post">

						<input type="hidden" name="reportId" value="${report.reportId}">


						<div class="row g-3">

							<div class="col-md-4">

								<label for="status" class="form-label"> Update Status </label> <select
									name="status" id="status" class="form-select" required>

									<option value="Pending"
										${report.currentStatus == 'Pending'
										? 'selected' : ''}>
										Pending</option>

									<option value="Investigating"
										${report.currentStatus == 'Investigating'
										? 'selected' : ''}>
										Investigating</option>

									<option value="Resolved"
										${report.currentStatus == 'Resolved'
										? 'selected' : ''}>
										Resolved</option>

									<option value="Rejected"
										${report.currentStatus == 'Rejected'
										? 'selected' : ''}>
										Rejected</option>

								</select>

							</div>


							<div class="col-md-8">

								<label for="remarks" class="form-label"> Remarks </label> <input
									type="text" id="remarks" name="remarks" class="form-control"
									placeholder="Enter case remarks">

							</div>


							<div class="col-12">

								<button type="submit" class="btn btn-primary">

									<i class="bi bi-check-circle me-1"></i> Update Case Status

								</button>

							</div>

						</div>

					</form>

				</div>

			</div>

		</c:when>


		<c:otherwise>

			<div class="card shadow-sm border-0">

				<div class="card-body text-center py-5">

					<i class="bi bi-exclamation-triangle
						text-warning"
						style="font-size: 4rem;"></i>

					<h4 class="mt-3">Case Not Found</h4>

					<p class="text-muted">The requested crime report could not be
						found.</p>

					<a href="${pageContext.request.contextPath}/AdminDashboardServlet"
						class="btn btn-primary"> <i class="bi bi-arrow-left me-1"></i>
						Return to Dashboard

					</a>

				</div>

			</div>

		</c:otherwise>

	</c:choose>

</div>


<jsp:include page="footer.jsp" />