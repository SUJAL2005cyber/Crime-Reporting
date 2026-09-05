<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Check admin login --%>

<c:if test="${empty sessionScope.adminId}">
	<c:redirect url="/adminLogin.jsp" />
</c:if>

<jsp:include page="header.jsp" />

<div class="container-fluid px-4 py-4">

	<div
		class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">

		<div>
			<h2 class="fw-bold mb-1">Admin Dashboard</h2>

			<p class="text-muted mb-0">
				Welcome, <strong> <c:out value="${sessionScope.adminName}"
						default="Administrator" />
				</strong>
			</p>
		</div>

		<div>
			<a href="${pageContext.request.contextPath}/logout"
				class="btn btn-outline-danger"> <i
				class="bi bi-box-arrow-right me-1"></i> Logout

			</a>
		</div>

	</div>


	<%-- Success Message --%>

	<c:if test="${not empty sessionScope.message}">

		<div class="alert alert-success alert-dismissible fade show"
			role="alert">

			<i class="bi bi-check-circle-fill me-2"></i>

			<c:out value="${sessionScope.message}" />

			<button type="button" class="btn-close" data-bs-dismiss="alert">
			</button>

		</div>

		<c:remove var="message" scope="session" />

	</c:if>


	<%-- Error Message --%>

	<c:if test="${not empty sessionScope.error}">

		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">

			<i class="bi bi-exclamation-triangle-fill me-2"></i>

			<c:out value="${sessionScope.error}" />

			<button type="button" class="btn-close" data-bs-dismiss="alert">
			</button>

		</div>

		<c:remove var="error" scope="session" />

	</c:if>


	<%-- Dashboard Statistics --%>

	<div class="row g-3 mb-4">

		<div class="col-xl-3 col-md-6">

			<div class="card shadow-sm border-0 h-100">

				<div class="card-body">

					<div class="d-flex justify-content-between align-items-center">

						<div>
							<p class="text-muted mb-1">Total Reports</p>

							<h3 class="fw-bold mb-0">
								<c:out value="${totalReports}" default="0" />
							</h3>
						</div>

						<div class="fs-2 text-primary">
							<i class="bi bi-folder2-open"></i>
						</div>

					</div>

				</div>

			</div>

		</div>


		<div class="col-xl-3 col-md-6">

			<div class="card shadow-sm border-0 h-100">

				<div class="card-body">

					<div class="d-flex justify-content-between align-items-center">

						<div>
							<p class="text-muted mb-1">Pending</p>

							<h3 class="fw-bold mb-0">
								<c:out value="${statusCounts['Pending']}" default="0" />
							</h3>
						</div>

						<div class="fs-2 text-warning">
							<i class="bi bi-hourglass-split"></i>
						</div>

					</div>

				</div>

			</div>

		</div>


		<div class="col-xl-3 col-md-6">

			<div class="card shadow-sm border-0 h-100">

				<div class="card-body">

					<div class="d-flex justify-content-between align-items-center">

						<div>
							<p class="text-muted mb-1">Investigating</p>

							<h3 class="fw-bold mb-0">
								<c:out value="${statusCounts['Investigating']}" default="0" />
							</h3>
						</div>

						<div class="fs-2 text-info">
							<i class="bi bi-search"></i>
						</div>

					</div>

				</div>

			</div>

		</div>


		<div class="col-xl-3 col-md-6">

			<div class="card shadow-sm border-0 h-100">

				<div class="card-body">

					<div class="d-flex justify-content-between align-items-center">

						<div>
							<p class="text-muted mb-1">Resolved</p>

							<h3 class="fw-bold mb-0">
								<c:out value="${statusCounts['Resolved']}" default="0" />
							</h3>
						</div>

						<div class="fs-2 text-success">
							<i class="bi bi-check-circle"></i>
						</div>

					</div>

				</div>

			</div>

		</div>

	</div>


	<%-- Filter Section --%>

	<div class="card shadow-sm border-0 mb-4">

		<div class="card-body">

			<form
				action="${pageContext.request.contextPath}/AdminDashboardServlet"
				method="get" class="row g-3 align-items-end">

				<div class="col-md-4">

					<label for="status" class="form-label"> Filter by Status </label> <select
						id="status" name="status" class="form-select">

						<option value="">All Statuses</option>

						<option value="Pending"
							${param.status == 'Pending' ? 'selected' : ''}>Pending</option>

						<option value="Investigating"
							${param.status == 'Investigating' ? 'selected' : ''}>
							Investigating</option>

						<option value="Resolved"
							${param.status == 'Resolved' ? 'selected' : ''}>
							Resolved</option>

						<option value="Rejected"
							${param.status == 'Rejected' ? 'selected' : ''}>
							Rejected</option>

					</select>

				</div>

				<div class="col-md-auto">

					<button type="submit" class="btn btn-primary">

						<i class="bi bi-funnel me-1"></i> Filter

					</button>

				</div>

				<div class="col-md-auto">

					<a href="${pageContext.request.contextPath}/AdminDashboardServlet"
						class="btn btn-outline-secondary"> Clear </a>

				</div>

			</form>

		</div>

	</div>


	<%-- Crime Reports Table --%>

	<div class="card shadow-sm border-0">

		<div
			class="card-header bg-white d-flex justify-content-between align-items-center py-3">

			<h5 class="mb-0 fw-bold">

				<i class="bi bi-list-ul me-2"></i> Crime Reports

			</h5>

			<span class="badge bg-primary"> ${fn:length(reports)} Reports
			</span>

		</div>


		<div class="card-body p-0">

			<div class="table-responsive">

				<table class="table table-hover align-middle mb-0">

					<thead class="table-light">

						<tr>

							<th class="px-3">Case ID</th>

							<th>Reporter</th>

							<th>Crime Type</th>

							<th>Location</th>

							<th>Filed On</th>

							<th>Status</th>

							<th>Evidence</th>

							<th class="text-end px-3">Action</th>

						</tr>

					</thead>


					<tbody>

						<c:choose>

							<c:when test="${empty reports}">

								<tr>

									<td colspan="8" class="text-center py-5">

										<div class="text-muted">

											<i class="bi bi-inbox" style="font-size: 3rem;"> </i>

											<h5 class="mt-3">No Crime Reports Found</h5>

											<p class="mb-0">There are currently no reports available.
											</p>

										</div>

									</td>

								</tr>

							</c:when>


							<c:otherwise>

								<c:forEach var="r" items="${reports}">

									<tr>

										<%-- Case ID --%>

										<td class="px-3"><strong class="text-primary"> <c:out
													value="${r.caseId}" />

										</strong></td>


										<%-- Reporter --%>

										<td>

											<div class="fw-semibold">

												<c:out value="${r.reporterName}" default="Unknown" />

											</div> <small class="text-muted"> <c:out
													value="${r.reporterEmail}" />

										</small>

										</td>


										<%-- Crime Type --%>

										<td><c:out value="${r.crimeType}" /></td>


										<%-- Location --%>

										<td>

											<div>

												<i class="bi bi-geo-alt me-1 text-danger"></i>

												<c:out value="${r.location}" />

											</div> <small class="text-muted"> <c:out value="${r.city}" />

										</small>

										</td>


										<%-- Filed Date --%>

										<td><c:choose>

												<c:when test="${not empty r.reportedAt}">

													<fmt:formatDate value="${r.reportedAt}"
														pattern="dd MMM yyyy" />

													<br>

													<small class="text-muted"> <fmt:formatDate
															value="${r.reportedAt}" pattern="hh:mm a" />

													</small>

												</c:when>

												<c:otherwise>

													<span class="text-muted"> - </span>

												</c:otherwise>

											</c:choose></td>


										<%-- Status --%>

										<td><c:choose>

												<c:when test="${r.currentStatus == 'Pending'}">

													<span class="badge bg-warning text-dark"> <i
														class="bi bi-clock me-1"></i> Pending

													</span>

												</c:when>


												<c:when test="${r.currentStatus == 'Investigating'}">

													<span class="badge bg-info text-dark"> <i
														class="bi bi-search me-1"></i> Investigating

													</span>

												</c:when>


												<c:when test="${r.currentStatus == 'Resolved'}">

													<span class="badge bg-success"> <i
														class="bi bi-check-circle me-1"></i> Resolved

													</span>

												</c:when>


												<c:when test="${r.currentStatus == 'Rejected'}">

													<span class="badge bg-danger"> <i
														class="bi bi-x-circle me-1"></i> Rejected

													</span>

												</c:when>


												<c:otherwise>

													<span class="badge bg-secondary"> <c:out
															value="${r.currentStatus}" default="Pending" />

													</span>

												</c:otherwise>

											</c:choose></td>


										<%-- Evidence --%>

										<td><c:choose>

												<c:when test="${not empty r.evidenceList}">

													<div class="dropdown">

														<button type="button"
															class="btn btn-sm btn-outline-primary dropdown-toggle"
															data-bs-toggle="dropdown" aria-expanded="false">

															<i class="bi bi-paperclip me-1"></i> Evidence <span
																class="badge bg-primary ms-1">
																${fn:length(r.evidenceList)} </span>

														</button>


														<ul class="dropdown-menu shadow" style="min-width: 310px;">

															<li>

																<h6 class="dropdown-header">Uploaded Evidence</h6>

															</li>

															<li>
																<hr class="dropdown-divider">
															</li>


															<c:forEach var="e" items="${r.evidenceList}">

																<li><a
																	class="dropdown-item d-flex align-items-center gap-2 py-2"
																	href="${pageContext.request.contextPath}/ViewEvidenceServlet?evidenceId=${e.evidenceId}"
																	target="_blank"> <c:choose>

																			<c:when
																				test="${e.fileType == 'jpg'
																				|| e.fileType == 'jpeg'
																				|| e.fileType == 'png'}">

																				<i
																					class="bi bi-file-earmark-image fs-4 text-primary">
																				</i>

																			</c:when>


																			<c:when test="${e.fileType == 'pdf'}">

																				<i class="bi bi-file-earmark-pdf fs-4 text-danger">
																				</i>

																			</c:when>


																			<c:when test="${e.fileType == 'mp4'}">

																				<i class="bi bi-file-earmark-play fs-4 text-info">
																				</i>

																			</c:when>


																			<c:when test="${e.fileType == 'docx'}">

																				<i class="bi bi-file-earmark-word fs-4 text-primary">
																				</i>

																			</c:when>


																			<c:otherwise>

																				<i class="bi bi-file-earmark fs-4"> </i>

																			</c:otherwise>

																		</c:choose>


																		<div class="flex-grow-1" style="min-width: 0;">

																			<div class="fw-semibold text-truncate"
																				style="max-width: 200px;">

																				<c:out value="${e.fileName}" />

																			</div>


																			<small class="text-muted"> <c:out
																					value="${fn:toUpperCase(e.fileType)}" /> <c:if
																					test="${e.fileSizeKb > 0}">

																					&bull;

																					<c:choose>

																						<c:when test="${e.fileSizeKb >= 1024}">

																							<fmt:formatNumber
																								value="${e.fileSizeKb / 1024.0}"
																								maxFractionDigits="2" />

																							MB

																						</c:when>

																						<c:otherwise>

																							<c:out value="${e.fileSizeKb}" />

																							KB

																						</c:otherwise>

																					</c:choose>

																				</c:if>

																			</small>

																		</div> <i class="bi bi-box-arrow-up-right text-muted"> </i>

																</a></li>

															</c:forEach>

														</ul>

													</div>

												</c:when>


												<c:otherwise>

													<span class="text-muted small"> <i
														class="bi bi-dash-circle me-1"></i> No Evidence

													</span>

												</c:otherwise>

											</c:choose></td>


										<%-- Action --%>

										<td class="text-end px-3"><a
											href="${pageContext.request.contextPath}/AdminCaseDetailsServlet?reportId=${r.reportId}"
											class="btn btn-sm btn-outline-primary"> <i
												class="bi bi-eye me-1"></i> View Case

										</a></td>

									</tr>

								</c:forEach>

							</c:otherwise>

						</c:choose>

					</tbody>

				</table>

			</div>

		</div>

	</div>

</div>


<div class="container-fluid px-4 pb-4">

	<div class="alert alert-light border small text-muted mb-0">

		<i class="bi bi-shield-lock me-2"></i> Evidence files are available
		only to authorized administrators. Click an evidence file to view it.

	</div>

</div>


<jsp:include page="footer.jsp" />