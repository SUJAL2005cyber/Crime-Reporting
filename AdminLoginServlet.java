package com.servlet;

import com.dao.AdminDAO;
import com.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final AdminDAO adminDAO = new AdminDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Get login details
		String username = req.getParameter("username");

		String password = req.getParameter("password");

		// Validate fields
		if (isBlank(username) || isBlank(password)) {

			req.setAttribute("errorMessage", "Username and password are required.");

			req.getRequestDispatcher("/adminLogin.jsp").forward(req, resp);

			return;
		}

		try {

			// Authenticate admin
			Admin admin = adminDAO.authenticate(username.trim(), password);

			// Login successful
			if (admin != null) {

				HttpSession session = req.getSession(true);

				/*
				 * Store complete admin object. AdminAuthFilter checks this.
				 */
				session.setAttribute("admin", admin);

				/*
				 * Also store commonly used admin information.
				 */
				session.setAttribute("adminId", admin.getAdminId());

				session.setAttribute("adminName", admin.getAdminName());

				session.setAttribute("adminUsername", admin.getUsername());

				session.setAttribute("adminDesignation", admin.getDesignation());

				// 30 minute session
				session.setMaxInactiveInterval(30 * 60);

				System.out.println("ADMIN LOGIN SUCCESS");

				System.out.println("Admin ID: " + admin.getAdminId());

				System.out.println("Admin Username: " + admin.getUsername());

				// Redirect to dashboard servlet
				resp.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");

				return;
			}

			// Invalid credentials
			req.setAttribute("errorMessage", "Invalid username or password.");

			req.setAttribute("username", username);

			req.getRequestDispatcher("/adminLogin.jsp").forward(req, resp);

		} catch (SQLException e) {

			e.printStackTrace();

			req.setAttribute("errorMessage", "Database error during login: " + e.getMessage());

			req.getRequestDispatcher("/adminLogin.jsp").forward(req, resp);
		}
	}

	private boolean isBlank(String value) {

		return value == null || value.trim().isEmpty();
	}
}