package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.CrimeReport;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminCaseDetailsServlet")
public class AdminCaseDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CrimeReportDAO crimeReportDAO;

    @Override
    public void init() throws ServletException {

        crimeReportDAO = new CrimeReportDAO();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // 1. CHECK ADMIN LOGIN
        // =====================================================

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/adminLogin.jsp"
            );

            return;
        }


        // =====================================================
        // 2. GET REPORT ID FROM URL
        // =====================================================

        String reportIdParam =
                request.getParameter("reportId");


        if (reportIdParam == null ||
                reportIdParam.trim().isEmpty()) {

            session.setAttribute(
                    "error",
                    "Report ID is required."
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/AdminDashboardServlet"
            );

            return;
        }


        try {

            // Convert reportId into integer
            int reportId =
                    Integer.parseInt(
                            reportIdParam
                    );


            // =================================================
            // 3. GET REPORT FROM DATABASE
            // =================================================

            CrimeReport report =
                    crimeReportDAO.getById(
                            reportId
                    );


            // =================================================
            // 4. CHECK REPORT
            // =================================================

            if (report == null) {

                session.setAttribute(
                        "error",
                        "Crime report not found."
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminDashboardServlet"
                );

                return;
            }


            // =================================================
            // 5. SET REPORT FOR JSP
            // =================================================

            /*
             * Your getById() method already loads:
             *
             * report details
             * reporter details
             * current status
             * status remarks
             * evidenceList
             */

            request.setAttribute(
                    "report",
                    report
            );


            // =================================================
            // 6. FORWARD TO JSP
            // =================================================

            request.getRequestDispatcher(
                    "/adminCaseDetails.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            session.setAttribute(
                    "error",
                    "Invalid Report ID."
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/AdminDashboardServlet"
            );


        } catch (SQLException e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load case details: "
                    + e.getMessage(),
                    e
            );
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(
                request,
                response
        );
    }
}