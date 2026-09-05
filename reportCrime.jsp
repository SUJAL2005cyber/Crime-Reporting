<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.model.User"%>

<%
User loggedInUser = (User) session.getAttribute("user");

if (loggedInUser == null) {
	response.sendRedirect("login.jsp");
	return;
}

String errorMessage = (String) request.getAttribute("errorMessage");
%>

<jsp:include page="header.jsp" />

<div class="container my-5">

	<div class="row justify-content-center">

		<div class="col-lg-9">

			<div class="card crs-card">

				<div class="card-body p-4">

					<h2 class="mb-3">Report a Crime</h2>

					<p class="text-muted">Please provide accurate information about
						the incident.</p>

					<!-- Display server-side error -->
					<%
					if (errorMessage != null) {
					%>

					<div class="alert alert-danger">
						<%=errorMessage%>
					</div>

					<%
					}
					%>

					<form
						action="${pageContext.request.contextPath}/ReportCrimeServlet"
						method="post" enctype="multipart/form-data" id="crimeReportForm"
						class="needs-validation" novalidate>

						<div class="row g-3">

							<div class="col-md-6">

								<label for="crimeType" class="form-label"> Crime Type </label> <select
									id="crimeType" name="crimeType" class="form-select"
									data-validate="required" data-label="Crime type">

									<option value="">Select Crime Type</option>

									<option value="Theft">Theft</option>

									<option value="Robbery">Robbery</option>

									<option value="Cyber Crime">Cyber Crime</option>

									<option value="Fraud">Fraud</option>

									<option value="Harassment">Harassment</option>

									<option value="Assault">Assault</option>

									<option value="Other">Other</option>

								</select>

								<div class="invalid-feedback">Please select a crime type.
								</div>

							</div>


							<div class="col-md-3">

								<label for="incidentDate" class="form-label"> Incident
									Date </label> <input type="date" id="incidentDate" name="incidentDate"
									class="form-control" data-validate="pastDate"
									data-label="Incident date">

								<div class="invalid-feedback">Enter a valid incident date.
								</div>

							</div>


							<div class="col-md-3">

								<label for="incidentTime" class="form-label"> Incident
									Time </label> <input type="time" id="incidentTime" name="incidentTime"
									class="form-control" data-validate="required"
									data-label="Incident time">

								<div class="invalid-feedback">Incident time is required.</div>

							</div>


							<div class="col-md-6">

								<label for="location" class="form-label"> Location </label> <input
									type="text" id="location" name="location" class="form-control"
									placeholder="Enter incident location" data-validate="minLength"
									data-min="5" data-label="Location">

								<div class="invalid-feedback">Enter a specific location.</div>

							</div>


							<div class="col-md-6">

								<label for="city" class="form-label"> City </label> <input
									type="text" id="city" name="city" class="form-control"
									placeholder="Enter city" data-validate="required"
									data-label="City">

								<div class="invalid-feedback">City is required.</div>

							</div>


							<div class="col-12">

								<label for="description" class="form-label"> Description
								</label>

								<textarea id="description" name="description"
									class="form-control" rows="5"
									placeholder="Describe what happened..."
									data-validate="minLength" data-min="20"
									data-label="Description"></textarea>

								<div class="invalid-feedback">Description must contain at
									least 20 characters.</div>

							</div>

							<div class="col-12">

								<label class="form-label"> Evidence (optional) </label>

								<div class="border rounded-3 p-4 text-center">

									<i class="bi bi-paperclip fs-2 text-primary"></i>

									<h6 class="mt-2 mb-1">Attach Evidence</h6>

									<p class="text-muted small mb-3">Select images, documents
										or video evidence</p>


									<!--
										Actual file input.

										It stays hidden because the label below
										works as our Choose Evidence button.
									-->
									<input type="file" id="evidenceFiles" name="evidenceFiles"
										multiple accept=".jpg,.jpeg,.png,.pdf,.docx,.mp4"
										class="d-none">


									<!--
										This is intentionally a LABEL instead
										of a JavaScript-controlled button.

										Clicking it automatically opens
										evidenceFiles because of:

										for="evidenceFiles"
									-->
									<label for="evidenceFiles" class="btn btn-outline-primary"
										style="cursor: pointer;"> <i
										class="bi bi-folder2-open me-2"></i> Choose Evidence

									</label>


									<div class="mt-2">

										<small class="text-muted"> JPG, JPEG, PNG, PDF, DOCX,
											MP4 &mdash; maximum 100MB each </small>

									</div>

								</div>


								<!-- Selected file information -->
								<div id="evidenceChips" class="mt-3"></div>


								<!-- File validation error -->
								<div id="evidenceError" class="text-danger small mt-2"></div>

							</div>

							<div class="col-12 mt-4">

								<button type="submit" class="btn btn-primary">

									<i class="bi bi-send me-2"></i> Submit Crime Report

								</button>

							</div>


						</div>

					</form>

				</div>

			</div>

		</div>

	</div>

</div>

<script src="${pageContext.request.contextPath}validation.js"></script>
<jsp:include page="footer.jsp" />