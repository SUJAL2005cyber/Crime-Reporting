package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.CrimeReport;
import com.model.Evidence;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;

import java.time.LocalDate;
import java.time.LocalTime;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

/*
 * ReportCrimeServlet
 * ---------------------------------------------------------
 * Receives crime-report information from reportCrime.jsp.
 *
 * It also receives evidence files selected by the user,
 * saves them to the D drive, and passes their information
 * to CrimeReportDAO.
 */
@WebServlet("/ReportCrimeServlet")

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 100L * 1024 * 1024, maxRequestSize = 500L * 1024 * 1024)

public class ReportCrimeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/*
	 * Folder where evidence files will be stored.
	 */
	private static final String UPLOAD_DIRECTORY = "D:\\UploadJavaFileHandling\\CrimeEvidence";

	/*
	 * Allowed evidence extensions.
	 */
	private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "pdf", "docx", "mp4");

	/*
	 * DAO used to save crime-report information.
	 */
	private final CrimeReportDAO reportDAO = new CrimeReportDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {

		/*
		 * ================================================= STEP 1 CHECK LOGIN
		 * =================================================
		 */

		HttpSession session = request.getSession(false);

		User loggedInUser = session != null ? (User) session.getAttribute("user") : null;

		if (loggedInUser == null) {

			response.sendRedirect(request.getContextPath() + "/login.jsp");

			return;
		}

		/*
		 * ================================================= STEP 2 READ FORM DATA
		 * =================================================
		 */

		String crimeType = request.getParameter("crimeType");

		String description = request.getParameter("description");

		String incidentDateString = request.getParameter("incidentDate");

		String incidentTimeString = request.getParameter("incidentTime");

		String location = request.getParameter("location");

		String city = request.getParameter("city");

		/*
		 * ================================================= STEP 3 VALIDATE REPORT
		 * INFORMATION =================================================
		 */

		String validationError = validate(

				crimeType,

				description,

				incidentDateString,

				incidentTimeString,

				location,

				city

		);

		if (validationError != null) {

			request.setAttribute("errorMessage", validationError);

			request.getRequestDispatcher("/reportCrime.jsp").forward(request, response);

			return;
		}

		try {

			/*
			 * ================================================= STEP 4 CREATE CRIME REPORT
			 * OBJECT =================================================
			 */

			CrimeReport report = new CrimeReport();

			report.setUserId(loggedInUser.getUserId());

			report.setCrimeType(crimeType);

			report.setDescription(description);

			LocalDate incidentDate = LocalDate.parse(incidentDateString);

			report.setIncidentDate(Date.valueOf(incidentDate));

			LocalTime incidentTime = LocalTime.parse(incidentTimeString);

			report.setIncidentTime(Time.valueOf(incidentTime));

			report.setLocation(location);

			report.setCity(city);

			/*
			 * ================================================= STEP 5 SAVE SELECTED
			 * EVIDENCE =================================================
			 */

			List<Evidence> evidenceFiles = handleFileUploads(request);

			/*
			 * ================================================= STEP 6 SAVE REPORT INTO
			 * DATABASE =================================================
			 */

			String caseId = reportDAO.submitReport(

					report,

					evidenceFiles

			);

			/*
			 * ================================================= STEP 7 SHOW SUCCESS PAGE
			 * =================================================
			 */

			request.setAttribute("caseId", caseId);

			request.setAttribute(

					"successMessage",

					"Your report has been submitted successfully. " + "Please save your Case ID to track its status."

			);

			request.getRequestDispatcher("/reportSuccess.jsp").forward(request, response);

		}

		catch (SQLException e) {

			e.printStackTrace();

			request.setAttribute(

					"errorMessage",

					"Database error while submitting report: " + e.getMessage()

			);

			request.getRequestDispatcher("/reportCrime.jsp").forward(request, response);

		}

		catch (Exception e) {

			e.printStackTrace();

			request.setAttribute(

					"errorMessage",

					"Unable to submit report: " + e.getMessage()

			);

			request.getRequestDispatcher("/reportCrime.jsp").forward(request, response);

		}

	}

	/*
	 * ===================================================== HANDLE EVIDENCE FILES
	 * =====================================================
	 */
	private List<Evidence> handleFileUploads(HttpServletRequest request)

			throws IOException, ServletException {

		List<Evidence> evidenceList = new ArrayList<>();

		/*
		 * Create upload folder.
		 */
		File uploadDirectory = new File(UPLOAD_DIRECTORY);

		if (!uploadDirectory.exists()) {

			boolean directoryCreated = uploadDirectory.mkdirs();

			if (!directoryCreated && !uploadDirectory.exists()) {

				throw new IOException(

						"Unable to create upload directory: " + UPLOAD_DIRECTORY

				);

			}

		}

		System.out.println("========================================");

		System.out.println("STARTING EVIDENCE UPLOAD");

		System.out.println(

				"Request Content Type: " + request.getContentType()

		);

		/*
		 * Get all multipart request elements.
		 */
		for (Part part : request.getParts()) {

			/*
			 * We only want:
			 *
			 * <input name="evidenceFiles">
			 */
			if (!"evidenceFiles".equals(part.getName())) {

				continue;

			}

			/*
			 * Ignore empty file selection.
			 */
			if (part.getSize() <= 0) {

				continue;

			}

			/*
			 * Get original filename.
			 */
			String originalFileName = part.getSubmittedFileName();

			if (originalFileName == null || originalFileName.trim().isEmpty()) {

				continue;

			}

			/*
			 * Remove any browser supplied directory.
			 */
			originalFileName = new File(originalFileName).getName();

			System.out.println("Received File: " + originalFileName);

			/*
			 * Get extension.
			 */
			String extension = getExtension(originalFileName).toLowerCase();

			/*
			 * Reject files without an extension.
			 */
			if (extension.isEmpty()) {

				throw new ServletException(

						"File extension missing for: " + originalFileName

				);

			}

			/*
			 * Server-side extension validation.
			 */
			if (!ALLOWED_EXTENSIONS.contains(extension)) {

				throw new ServletException(

						"Unsupported evidence type: " + originalFileName

				);

			}

			/*
			 * Maximum file size = 100 MB.
			 */
			long maximumSize = 100L * 1024 * 1024;

			if (part.getSize() > maximumSize) {

				throw new ServletException(

						originalFileName + " exceeds the 100MB file limit."

				);

			}

			/*
			 * Generate a unique filename.
			 *
			 * Example:
			 *
			 * 57bb82e9-48d5-4b9c.jpg
			 */
			String storedFileName = UUID.randomUUID().toString() + "." + extension;

			/*
			 * Create destination.
			 */
			File destination = new File(

					uploadDirectory,

					storedFileName

			);

			/*
			 * Write file to disk.
			 */
			part.write(destination.getAbsolutePath());

			/*
			 * Verify that the file was created.
			 */
			if (!destination.exists()) {

				throw new IOException(

						"File could not be saved: " + originalFileName

				);

			}

			/*
			 * Create Evidence object.
			 */
			Evidence evidence = new Evidence();

			/*
			 * Store original filename.
			 */
			evidence.setFileName(originalFileName);

			/*
			 * Store actual physical location.
			 */
			evidence.setStoredPath(destination.getAbsolutePath());

			evidence.setFileType(extension);

			/*
			 * Convert file size from bytes to KB.
			 */
			int sizeKb = (int) Math.ceil(

					part.getSize() / 1024.0

			);

			evidence.setFileSizeKb(sizeKb);

			/*
			 * Add evidence to list.
			 */
			evidenceList.add(evidence);

			System.out.println("Evidence saved successfully.");

			System.out.println("Original Name : " + originalFileName);

			System.out.println("Stored Name   : " + storedFileName);

			System.out.println("Saved Path    : " + destination.getAbsolutePath());

			System.out.println("Size          : " + sizeKb + " KB");

			System.out.println("----------------------------------------");

		}

		System.out.println(

				"Total Evidence Files: " + evidenceList.size()

		);

		System.out.println("END EVIDENCE UPLOAD");

		System.out.println("========================================");

		return evidenceList;

	}

	/*
	 * ===================================================== GET FILE EXTENSION
	 * =====================================================
	 */
	private String getExtension(String fileName) {

		int dot = fileName.lastIndexOf('.');

		if (dot == -1 || dot == fileName.length() - 1) {

			return "";

		}

		return fileName.substring(dot + 1);

	}

	/*
	 * ===================================================== VALIDATE REPORT
	 * =====================================================
	 */
	private String validate(

			String crimeType,

			String description,

			String incidentDate,

			String incidentTime,

			String location,

			String city) {

		if (isBlank(crimeType)) {

			return "Please select a crime type.";

		}

		if (isBlank(description) || description.trim().length() < 20) {

			return "Description must be at least 20 characters.";

		}

		if (isBlank(incidentDate)) {

			return "Incident date is required.";

		}

		try {

			LocalDate date = LocalDate.parse(incidentDate);

			if (date.isAfter(LocalDate.now())) {

				return "Incident date cannot be in the future.";

			}

		}

		catch (Exception e) {

			return "Invalid incident date format.";

		}

		if (isBlank(incidentTime)) {

			return "Incident time is required.";

		}

		try {

			LocalTime.parse(incidentTime);

		}

		catch (Exception e) {

			return "Invalid incident time format.";

		}

		if (isBlank(location) || location.trim().length() < 5) {

			return "Please provide a specific location/address.";

		}

		if (isBlank(city)) {

			return "City is required.";

		}

		return null;

	}

	/*
	 * Checks whether text is null or empty.
	 */
	private boolean isBlank(String value) {

		return value == null || value.trim().isEmpty();

	}

}