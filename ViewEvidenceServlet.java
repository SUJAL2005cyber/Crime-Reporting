package com.servlet;

import com.dao.CrimeReportDAO;
import com.model.Evidence;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/ViewEvidenceServlet")
public class ViewEvidenceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final CrimeReportDAO reportDAO =
            new CrimeReportDAO();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // CHECK ADMIN LOGIN
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
                session.getAttribute("adminId") == null) {


            response.sendRedirect(
                    request.getContextPath()
                            + "/adminLogin.jsp"
            );

            return;
        }


        // =====================================================
        // GET EVIDENCE ID
        // =====================================================

        String evidenceIdParameter =
                request.getParameter(
                        "evidenceId");


        if (evidenceIdParameter == null ||
                evidenceIdParameter.trim().isEmpty()) {


            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Evidence ID is required."
            );

            return;
        }


        try {


            int evidenceId =
                    Integer.parseInt(
                            evidenceIdParameter);


            // =================================================
            // GET EVIDENCE FROM DATABASE
            // =================================================

            Evidence evidence =
                    reportDAO.getEvidenceById(
                            evidenceId);


            if (evidence == null) {


                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Evidence record not found."
                );

                return;
            }


            // =================================================
            // GET FILE
            // =================================================

            File file =
                    new File(
                            evidence.getStoredPath());


            if (!file.exists()) {


                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Evidence file not found on server."
                );

                return;
            }


            if (!file.isFile()) {


                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid evidence file."
                );

                return;
            }


            // =================================================
            // DETECT FILE TYPE
            // =================================================

            String mimeType =
                    getServletContext()
                            .getMimeType(
                                    evidence.getFileName());


            if (mimeType == null) {

                mimeType =
                        "application/octet-stream";
            }


            // =================================================
            // RESPONSE SETTINGS
            // =================================================

            response.setContentType(
                    mimeType);


            response.setContentLengthLong(
                    file.length());


            String safeFileName =
                    evidence.getFileName()
                            .replace("\"", "");


            /*
             * INLINE:
             *
             * Browser will display JPG, PNG,
             * PDF and MP4 when supported.
             */
            response.setHeader(
                    "Content-Disposition",
                    "inline; filename=\""
                            + safeFileName
                            + "\""
            );


            response.setHeader(
                    "X-Content-Type-Options",
                    "nosniff"
            );


            // =================================================
            // READ FILE
            // =================================================

            try (
                    FileInputStream input =
                            new FileInputStream(file);

                    OutputStream output =
                            response.getOutputStream()
            ) {


                byte[] buffer =
                        new byte[8192];


                int bytesRead;


                while (
                        (bytesRead =
                                input.read(buffer))
                                != -1
                ) {


                    output.write(
                            buffer,
                            0,
                            bytesRead
                    );
                }


                output.flush();
            }


        } catch (NumberFormatException e) {


            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Evidence ID."
            );


        } catch (Exception e) {


            e.printStackTrace();


            if (!response.isCommitted()) {

                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to open evidence file."
                );
            }
        }
    }
}