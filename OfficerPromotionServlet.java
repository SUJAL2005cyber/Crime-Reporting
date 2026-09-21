package com.servlet;

import com.dao.AdminDAO;
import com.model.Admin;
import com.model.OfficerPerformance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles GET /OfficerPromotionServlet — lists all officers with their
 * case-solving stats for the Commissioner's office, filtered by
 * designation and/or minimum number of solved cases.
 *
 * Handles POST /OfficerPromotionServlet — promotes a selected officer to
 * the next rank on the career ladder.
 *
 * Only accessible to an admin whose own designation is "Commissioner".
 * Access to the underlying servlet URL is also gated by AdminAuthFilter
 * (must be logged in as *some* admin); the Commissioner-only check below
 * additionally protects this specific screen.
 */
@WebServlet("/OfficerPromotionServlet")
public class OfficerPromotionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final AdminDAO adminDAO = new AdminDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if (!isCommissioner(req)) {
			req.getSession().setAttribute("error", "Only the Commissioner's office can access officer promotions.");
			resp.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");
			return;
		}

		String designationFilter = req.getParameter("designation");
		String minResolvedParam = req.getParameter("minResolved");

		int minResolved = parseIntSafe(minResolvedParam, 0);

		try {
			List<OfficerPerformance> officers = adminDAO.getOfficerPerformance();
			List<OfficerPerformance> filtered = new ArrayList<>();

			for (OfficerPerformance officer : officers) {

				boolean matchesDesignation =
						isBlank(designationFilter)
						|| "All".equalsIgnoreCase(designationFilter)
						|| designationFilter.equalsIgnoreCase(officer.getAdmin().getDesignation());

				boolean matchesMinResolved = officer.getResolvedCases() >= minResolved;

				if (matchesDesignation && matchesMinResolved) {
					filtered.add(officer);
				}
			}

			req.setAttribute("officers", filtered);
			req.setAttribute("ranks", AdminDAO.RANK_LADDER);
			req.setAttribute("selectedDesignation", isBlank(designationFilter) ? "All" : designationFilter);
			req.setAttribute("minResolved", minResolved);

			req.getRequestDispatcher("/officerPromotion.jsp").forward(req, resp);

		} catch (SQLException e) {
			req.setAttribute("errorMessage", "Could not load officer performance: " + e.getMessage());
			req.setAttribute("ranks", AdminDAO.RANK_LADDER);
			req.getRequestDispatcher("/officerPromotion.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if (!isCommissioner(req)) {
			req.getSession().setAttribute("error", "Only the Commissioner's office can promote officers.");
			resp.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");
			return;
		}

		int adminId = parseIntSafe(req.getParameter("adminId"), -1);
		String currentDesignation = req.getParameter("currentDesignation");

		String nextRank = AdminDAO.getNextRank(currentDesignation);

		HttpSession session = req.getSession();

		if (adminId <= 0 || nextRank == null) {
			session.setAttribute("error", "This officer cannot be promoted further (already at the top rank).");
		} else {
			try {
				adminDAO.promoteOfficer(adminId, nextRank);
				session.setAttribute("message", "Officer promoted to " + nextRank + ".");
			} catch (SQLException e) {
				session.setAttribute("error", "Failed to promote officer: " + e.getMessage());
			}
		}

		// Preserve whatever filter the commissioner had applied.
		String redirect = req.getContextPath() + "/OfficerPromotionServlet";
		String designationFilter = req.getParameter("designationFilter");
		String minResolvedFilter = req.getParameter("minResolvedFilter");

		StringBuilder query = new StringBuilder();
		if (!isBlank(designationFilter)) {
			query.append(query.length() == 0 ? "?" : "&").append("designation=").append(designationFilter);
		}
		if (!isBlank(minResolvedFilter)) {
			query.append(query.length() == 0 ? "?" : "&").append("minResolved=").append(minResolvedFilter);
		}

		resp.sendRedirect(redirect + query);
	}

	/**
	 * Commissioner-only gate. Relies on AdminLoginServlet storing the
	 * plain designation string in session as "adminDesignation".
	 */
	private boolean isCommissioner(HttpServletRequest req) {

		HttpSession session = req.getSession(false);

		if (session == null) {
			return false;
		}

		Admin admin = (Admin) session.getAttribute("admin");
		String designation = (String) session.getAttribute("adminDesignation");

		if (admin != null && admin.getDesignation() != null) {
			designation = admin.getDesignation();
		}

		return "Commissioner".equalsIgnoreCase(designation);
	}

	private boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}

	private int parseIntSafe(String value, int fallback) {
		try {
			return Integer.parseInt(value.trim());
		} catch (Exception e) {
			return fallback;
		}
	}
}
