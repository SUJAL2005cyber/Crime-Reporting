package com.servlet;

import com.dao.UserDAO;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

/**
 * Handles POST /RegisterServlet — creates a new user account.
 * Server-side validation always re-checks everything the client-side JS
 * already validated, since client checks can be bypassed.
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[6-9]\\d{9}$"); // 10-digit mobile number

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = trim(req.getParameter("fullName"));
        String email = trim(req.getParameter("email"));
        String phone = trim(req.getParameter("phone"));
        String address = trim(req.getParameter("address"));
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        String error = validate(fullName, email, phone, address, password, confirmPassword);

        if (error == null) {
            try {
                if (userDAO.emailExists(email)) {
                    error = "An account with this email already exists.";
                } else {
                    User user = new User();
                    user.setFullName(fullName);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setAddress(address);

                    int newId = userDAO.registerUser(user, password);
                    if (newId > 0) {
                        req.setAttribute("successMessage",
                                "Registration successful! Please log in to continue.");
                        req.getRequestDispatcher("/login.jsp").forward(req, resp);
                        return;
                    } else {
                        error = "Registration failed. Please try again.";
                    }
                }
            } catch (SQLException e) {
                error = "Database error during registration: " + e.getMessage();
            }
        }

        // Validation failed or DB error: redisplay form with sticky values
        req.setAttribute("errorMessage", error);
        req.setAttribute("fullName", fullName);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
        req.setAttribute("address", address);
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    private String validate(String fullName, String email, String phone, String address,
                             String password, String confirmPassword) {
        if (isBlank(fullName) || fullName.length() < 3) {
            return "Full name must be at least 3 characters.";
        }
        if (isBlank(email) || !EMAIL_PATTERN.matcher(email).matches()) {
            return "Please provide a valid email address.";
        }
        if (isBlank(phone) || !PHONE_PATTERN.matcher(phone).matches()) {
            return "Phone number must be a valid 10-digit mobile number.";
        }
        if (isBlank(address) || address.length() < 5) {
            return "Please provide a complete address.";
        }
        if (isBlank(password) || password.length() < 8
                || !password.matches(".*[A-Z].*")
                || !password.matches(".*[a-z].*")
                || !password.matches(".*\\d.*")
                || !password.matches(".*[!@#$%^&*()_+\\-=].*")) {
            return "Password must be 8+ characters and include uppercase, lowercase, "
                    + "a number, and a special character.";
        }
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }
        return null;
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
