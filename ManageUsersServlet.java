package com.servlet;

import com.dao.AdminDAO;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Handles GET /ManageUsersServlet — lists all registered citizen accounts
 * for the admin, and POST toggles a user's active/suspended state.
 * Access restricted by AdminAuthFilter.
 */
@WebServlet("/ManageUsersServlet")
public class ManageUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<User> users = adminDAO.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/manageUsers.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Could not load users: " + e.getMessage());
            req.getRequestDispatcher("/manageUsers.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int userId = parseIntSafe(req.getParameter("userId"));
        boolean activate = "true".equals(req.getParameter("activate"));

        if (userId > 0) {
            try {
                adminDAO.setUserActive(userId, activate);
            } catch (SQLException e) {
                req.getSession().setAttribute("errorMessage", "Failed to update user: " + e.getMessage());
            }
        }
        resp.sendRedirect("ManageUsersServlet");
    }

    private int parseIntSafe(String s) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return -1;
        }
    }
}
