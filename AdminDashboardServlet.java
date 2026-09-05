package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.CrimeReport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Handles GET /AdminDashboardServlet — loads all crime reports plus
 * status-count summary for the admin dashboard. Access is restricted by
 * AdminAuthFilter, so no session check is duplicated here.
 */
@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private final CrimeReportDAO reportDAO = new CrimeReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<CrimeReport> allReports = reportDAO.getAllReports();
            Map<String, Integer> statusCounts = reportDAO.getStatusCounts();

            req.setAttribute("reports", allReports);
            req.setAttribute("statusCounts", statusCounts);
            req.setAttribute("totalReports", allReports.size());

            req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Could not load dashboard data: " + e.getMessage());
            req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
        }
    }
}
