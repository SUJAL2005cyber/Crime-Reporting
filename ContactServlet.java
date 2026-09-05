package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Handles POST /ContactServlet — processes the public "Contact Us" form.
 * In this teaching build the message is simply validated and logged; wire
 * this up to an email service or a `contact_messages` table for production.
 */
@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(ContactServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        if (isBlank(name) || isBlank(email) || isBlank(message)) {
            req.setAttribute("errorMessage", "Name, email, and message are required.");
            req.getRequestDispatcher("/contact.jsp").forward(req, resp);
            return;
        }

        LOGGER.info("Contact form submission from " + name + " <" + email + ">: " + subject);

        req.setAttribute("successMessage",
                "Thank you, " + name + ". Your message has been received and our team will respond shortly.");
        req.getRequestDispatcher("/contact.jsp").forward(req, resp);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
