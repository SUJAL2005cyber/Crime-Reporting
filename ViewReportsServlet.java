package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.CrimeReport;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/** Handles GET /ViewReportsServlet — lists all reports filed by the logged-in user. */
@WebServlet("/ViewReportsServlet")
public class ViewReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private final CrimeReportDAO reportDAO = new CrimeReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            List<CrimeReport> reports = reportDAO.getReportsByUser(user.getUserId());
            req.setAttribute("reports", reports);
            req.getRequestDispatcher("/viewReports.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Could not load your reports: " + e.getMessage());
            req.getRequestDispatcher("/viewReports.jsp").forward(req, resp);
        }
    }
}
