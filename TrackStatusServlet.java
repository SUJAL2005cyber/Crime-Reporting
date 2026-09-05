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

/**
 * Handles GET/POST /TrackStatusServlet — public case-status lookup by Case ID.
 * No login required, so citizens who reported anonymously-by-desk can still
 * check status if they have the case ID (and the registered email, as a
 * lightweight verification step).
 */
@WebServlet("/TrackStatusServlet")
public class TrackStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private final CrimeReportDAO reportDAO = new CrimeReportDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String caseId = req.getParameter("caseId");

        if (caseId == null || caseId.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Please enter a Case ID.");
            req.getRequestDispatcher("/trackStatus.jsp").forward(req, resp);
            return;
        }

        try {
            CrimeReport report = reportDAO.getByCaseId(caseId.trim().toUpperCase());
            if (report == null) {
                req.setAttribute("errorMessage", "No report found for Case ID: " + caseId);
            } else {
                req.setAttribute("report", report);
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while tracking status: " + e.getMessage());
        }

        req.getRequestDispatcher("/trackStatus.jsp").forward(req, resp);
    }
}
