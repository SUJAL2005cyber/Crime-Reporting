package com.servlet;

import com.dao.AdminDAO;
import com.dao.CrimeReportDAO;
import com.model.Admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Handles POST /AssignOfficerServlet — assigns (or unassigns) an officer
 * to a case. Only the Commissioner's office may do this, same
 * restriction pattern as OfficerPromotionServlet.
 *
 * Expects: reportId (required), adminId (optional — blank/omitted
 * unassigns the case).
 *
 * Always redirects back to AdminCaseDetailsServlet for that report,
 * with a session-flashed success/error message.
 */
@WebServlet("/AssignOfficerServlet")
public class AssignOfficerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final CrimeReportDAO crimeReportDAO = new CrimeReportDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// =====================================================
		// 1. CHECK ADMIN LOGIN + COMMISSIONER DESIGNATION
		// =====================================================

		HttpSession session = request.getSession(false);
		Admin admin = session == null ? null : (Admin) session.getAttribute("admin");

		if (admin == null) {
			response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
			return;
		}

		if (!"Commissioner".equalsIgnoreCase(admin.getDesignation())) {
			session.setAttribute("error", "Only the Commissioner's office can assign cases.");
			response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
			return;
		}

		// =====================================================
		// 2. READ PARAMETERS
		// =====================================================

		String reportIdParam = request.getParameter("reportId");
		String adminIdParam = request.getParameter("adminId");

		if (reportIdParam == null || reportIdParam.trim().isEmpty()) {
			session.setAttribute("error", "Report ID is required.");
			response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
			return;
		}

		try {
			int reportId = Integer.parseInt(reportIdParam.trim());

			// Blank selection ("— Unassigned —") unassigns the case.
			Integer targetAdminId = (adminIdParam == null || adminIdParam.trim().isEmpty())
					? null
					: Integer.valueOf(adminIdParam.trim());

			// =================================================
			// 3. UPDATE ASSIGNMENT
			// =================================================

			boolean updated = crimeReportDAO.assignOfficer(reportId, targetAdminId);

			session.setAttribute("message",
					updated
							? (targetAdminId == null ? "Case unassigned." : "Officer assigned to case.")
							: "Failed to update assignment.");

			// =================================================
			// 4. REDIRECT BACK TO CASE DETAILS
			// =================================================

			response.sendRedirect(
					request.getContextPath() + "/AdminCaseDetailsServlet?reportId=" + reportId);

		} catch (NumberFormatException e) {

			session.setAttribute("error", "Invalid Report ID or Admin ID.");
			response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");

		} catch (SQLException e) {

			e.printStackTrace();
			session.setAttribute("error", "Database error while assigning officer: " + e.getMessage());
			response.sendRedirect(
					request.getContextPath() + "/AdminCaseDetailsServlet?reportId=" + reportIdParam);
		}
	}
}
