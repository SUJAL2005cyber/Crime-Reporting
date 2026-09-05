package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

/**
 * Handles POST /UpdateStatusServlet — an admin updates a report's
 * investigation status (Pending / Investigating / Resolved / Rejected)
 * and adds an optional remark. Access restricted by AdminAuthFilter.
 */
@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

	private static final List<String> VALID_STATUSES =
            Arrays.asList("Pending", "Investigating", "Resolved", "Rejected");

    private final CrimeReportDAO reportDAO = new CrimeReportDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        int reportId = parseIntSafe(req.getParameter("reportId"));
        String newStatus = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        if (admin == null || reportId <= 0 || !VALID_STATUSES.contains(newStatus)) {
            resp.sendRedirect("AdminDashboardServlet");
            return;
        }

        try {
            reportDAO.updateStatus(reportId, newStatus, remarks, admin.getAdminId());
        } catch (SQLException e) {
            req.getSession().setAttribute("errorMessage", "Failed to update status: " + e.getMessage());
        }

        resp.sendRedirect("AdminDashboardServlet");
    }

    private int parseIntSafe(String s) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return -1;
        }
    }
}
