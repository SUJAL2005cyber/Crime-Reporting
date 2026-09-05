package com.dao;

import com.model.CrimeReport;
import com.model.Evidence;
import com.util.CaseIDGenerator;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CrimeReportDAO {


    // =========================================================
    // SUBMIT CRIME REPORT
    // =========================================================

    public String submitReport(
            CrimeReport report,
            List<Evidence> evidenceFiles)
            throws SQLException {

        String sql =
                "INSERT INTO crimereports "
                + "(caseid, userid, crimetype, description, "
                + "incidentdate, incidenttime, location, city) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);

            String caseId =
                    CaseIDGenerator.generate(con);

            int reportId;


            // -----------------------------------------------
            // INSERT REPORT
            // -----------------------------------------------

            try (PreparedStatement ps =
                         con.prepareStatement(
                                 sql,
                                 Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, caseId);

                ps.setInt(
                        2,
                        report.getUserId());

                ps.setString(
                        3,
                        report.getCrimeType());

                ps.setString(
                        4,
                        report.getDescription());

                ps.setDate(
                        5,
                        (Date) report.getIncidentDate());

                ps.setTime(
                        6,
                        report.getIncidentTime());

                ps.setString(
                        7,
                        report.getLocation());

                ps.setString(
                        8,
                        report.getCity());


                ps.executeUpdate();


                try (ResultSet keys =
                             ps.getGeneratedKeys()) {

                    if (!keys.next()) {

                        throw new SQLException(
                                "Unable to obtain Report ID."
                        );
                    }

                    reportId =
                            keys.getInt(1);
                }
            }


            // =================================================
            // INITIAL CASE STATUS
            // =================================================

            String statusSql =
                    "INSERT INTO casestatus "
                    + "(reportid, status, remarks) "
                    + "VALUES (?, 'Pending', ?)";


            try (PreparedStatement ps =
                         con.prepareStatement(statusSql)) {

                ps.setInt(
                        1,
                        reportId);

                ps.setString(
                        2,
                        "Report received and queued for review."
                );

                ps.executeUpdate();
            }


            // =================================================
            // SAVE EVIDENCE
            // =================================================

            if (evidenceFiles != null
                    && !evidenceFiles.isEmpty()) {


                String evidenceSql =
                        "INSERT INTO evidence "
                        + "(reportid, filename, storedpath, "
                        + "filetype, filesizekb) "
                        + "VALUES (?, ?, ?, ?, ?)";


                try (PreparedStatement ps =
                             con.prepareStatement(
                                     evidenceSql)) {


                    for (Evidence ev : evidenceFiles) {

                        ps.setInt(
                                1,
                                reportId);

                        ps.setString(
                                2,
                                ev.getFileName());

                        ps.setString(
                                3,
                                ev.getStoredPath());

                        ps.setString(
                                4,
                                ev.getFileType());

                        ps.setInt(
                                5,
                                ev.getFileSizeKb());


                        ps.addBatch();
                    }


                    ps.executeBatch();
                }
            }


            con.commit();

            return caseId;


        } catch (SQLException e) {

            if (con != null) {

                con.rollback();
            }

            throw e;


        } finally {

            if (con != null) {

                con.setAutoCommit(true);

                con.close();
            }
        }
    }


    // =========================================================
    // GET USER REPORTS
    // =========================================================

    public List<CrimeReport> getReportsByUser(
            int userId)
            throws SQLException {


        String sql =
                "SELECT r.*, "
                + "s.status AS currentstatus, "
                + "s.remarks AS statusremarks "
                + "FROM crimereports r "
                + "LEFT JOIN v_reportcurrentstatus s "
                + "ON r.reportid = s.reportid "
                + "WHERE r.userid = ? "
                + "ORDER BY r.reportedat DESC";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    userId);


            try (ResultSet rs =
                         ps.executeQuery()) {


                List<CrimeReport> reports =
                        mapList(rs);


                // Load evidence for every report
                for (CrimeReport report : reports) {

                    report.setEvidenceList(
                            getEvidenceForReport(
                                    con,
                                    report.getReportId()
                            )
                    );
                }


                return reports;
            }
        }
    }


    // =========================================================
    // GET ALL REPORTS - ADMIN
    // =========================================================

    public List<CrimeReport> getAllReports()
            throws SQLException {


        String sql =
                "SELECT r.*, "
                + "u.fullname AS reportername, "
                + "u.email AS reporteremail, "
                + "s.status AS currentstatus, "
                + "s.remarks AS statusremarks "
                + "FROM crimereports r "
                + "JOIN users u "
                + "ON r.userid = u.userid "
                + "LEFT JOIN v_reportcurrentstatus s "
                + "ON r.reportid = s.reportid "
                + "ORDER BY r.reportedat DESC";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql);

             ResultSet rs =
                     ps.executeQuery()) {


            List<CrimeReport> reports =
                    mapList(rs);


            /*
             * IMPORTANT
             *
             * Load evidence belonging to
             * every crime report.
             */
            for (CrimeReport report : reports) {

                List<Evidence> evidence =
                        getEvidenceForReport(
                                con,
                                report.getReportId()
                        );


                report.setEvidenceList(
                        evidence);
            }


            return reports;
        }
    }


    // =========================================================
    // GET REPORT USING CASE ID
    // =========================================================

    public CrimeReport getByCaseId(
            String caseId)
            throws SQLException {


        String sql =
                "SELECT r.*, "
                + "u.fullname AS reportername, "
                + "u.email AS reporteremail, "
                + "s.status AS currentstatus, "
                + "s.remarks AS statusremarks "
                + "FROM crimereports r "
                + "JOIN users u "
                + "ON r.userid = u.userid "
                + "LEFT JOIN v_reportcurrentstatus s "
                + "ON r.reportid = s.reportid "
                + "WHERE r.caseid = ?";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setString(
                    1,
                    caseId);


            try (ResultSet rs =
                         ps.executeQuery()) {


                if (rs.next()) {

                    CrimeReport report =
                            mapRow(rs);


                    report.setEvidenceList(
                            getEvidenceForReport(
                                    con,
                                    report.getReportId()
                            )
                    );


                    return report;
                }
            }
        }


        return null;
    }


    // =========================================================
    // GET REPORT USING REPORT ID
    // =========================================================

    public CrimeReport getById(
            int reportId)
            throws SQLException {


        String sql =
                "SELECT r.*, "
                + "u.fullname AS reportername, "
                + "u.email AS reporteremail, "
                + "s.status AS currentstatus, "
                + "s.remarks AS statusremarks "
                + "FROM crimereports r "
                + "JOIN users u "
                + "ON r.userid = u.userid "
                + "LEFT JOIN v_reportcurrentstatus s "
                + "ON r.reportid = s.reportid "
                + "WHERE r.reportid = ?";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    reportId);


            try (ResultSet rs =
                         ps.executeQuery()) {


                if (rs.next()) {

                    CrimeReport report =
                            mapRow(rs);


                    report.setEvidenceList(
                            getEvidenceForReport(
                                    con,
                                    report.getReportId()
                            )
                    );


                    return report;
                }
            }
        }


        return null;
    }


    // =========================================================
    // UPDATE STATUS
    // =========================================================

    public boolean updateStatus(
            int reportId,
            String newStatus,
            String remarks,
            int adminId)
            throws SQLException {


        String sql =
                "INSERT INTO casestatus "
                + "(reportid, status, remarks, updatedby) "
                + "VALUES (?, ?, ?, ?)";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    reportId);

            ps.setString(
                    2,
                    newStatus);

            ps.setString(
                    3,
                    remarks);

            ps.setInt(
                    4,
                    adminId);


            return ps.executeUpdate() > 0;
        }
    }


    // =========================================================
    // STATUS COUNTS
    // =========================================================

    public Map<String, Integer> getStatusCounts()
            throws SQLException {


        Map<String, Integer> counts =
                new LinkedHashMap<>();


        counts.put(
                "Pending",
                0);

        counts.put(
                "Investigating",
                0);

        counts.put(
                "Resolved",
                0);

        counts.put(
                "Rejected",
                0);


        String sql =
                "SELECT status, COUNT(*) AS cnt "
                + "FROM v_reportcurrentstatus "
                + "GROUP BY status";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql);

             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                counts.put(
                        rs.getString("status"),
                        rs.getInt("cnt")
                );
            }
        }


        return counts;
    }


    // =========================================================
    // GET EVIDENCE USING REPORT ID
    // =========================================================

    public List<Evidence> getEvidenceByReportId(
            int reportId)
            throws SQLException {


        try (Connection con =
                     DBConnection.getConnection()) {


            return getEvidenceForReport(
                    con,
                    reportId);
        }
    }


    // =========================================================
    // GET SINGLE EVIDENCE USING EVIDENCE ID
    // =========================================================

    public Evidence getEvidenceById(
            int evidenceId)
            throws SQLException {


        String sql =
                "SELECT evidenceid, reportid, filename, "
                + "storedpath, filetype, filesizekb, uploadedat "
                + "FROM evidence "
                + "WHERE evidenceid = ?";


        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    evidenceId);


            try (ResultSet rs =
                         ps.executeQuery()) {


                if (rs.next()) {


                    Evidence evidence =
                            new Evidence();


                    evidence.setEvidenceId(
                            rs.getInt(
                                    "evidenceid"));


                    evidence.setReportId(
                            rs.getInt(
                                    "reportid"));


                    evidence.setFileName(
                            rs.getString(
                                    "filename"));


                    evidence.setStoredPath(
                            rs.getString(
                                    "storedpath"));


                    evidence.setFileType(
                            rs.getString(
                                    "filetype"));


                    evidence.setFileSizeKb(
                            rs.getInt(
                                    "filesizekb"));


                    evidence.setUploadedAt(
                            rs.getTimestamp(
                                    "uploadedat"));


                    return evidence;
                }
            }
        }


        return null;
    }


    // =========================================================
    // INTERNAL EVIDENCE METHOD
    // =========================================================

    private List<Evidence> getEvidenceForReport(
            Connection con,
            int reportId)
            throws SQLException {


        List<Evidence> list =
                new ArrayList<>();


        String sql =
                "SELECT evidenceid, reportid, filename, "
                + "storedpath, filetype, filesizekb, uploadedat "
                + "FROM evidence "
                + "WHERE reportid = ? "
                + "ORDER BY uploadedat DESC";


        try (PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    reportId);


            try (ResultSet rs =
                         ps.executeQuery()) {


                while (rs.next()) {


                    Evidence ev =
                            new Evidence();


                    ev.setEvidenceId(
                            rs.getInt(
                                    "evidenceid"));


                    ev.setReportId(
                            rs.getInt(
                                    "reportid"));


                    ev.setFileName(
                            rs.getString(
                                    "filename"));


                    ev.setStoredPath(
                            rs.getString(
                                    "storedpath"));


                    ev.setFileType(
                            rs.getString(
                                    "filetype"));


                    ev.setFileSizeKb(
                            rs.getInt(
                                    "filesizekb"));


                    ev.setUploadedAt(
                            rs.getTimestamp(
                                    "uploadedat"));


                    list.add(ev);
                }
            }
        }


        return list;
    }


    // =========================================================
    // MAP RESULTSET TO LIST
    // =========================================================

    private List<CrimeReport> mapList(
            ResultSet rs)
            throws SQLException {


        List<CrimeReport> list =
                new ArrayList<>();


        while (rs.next()) {

            list.add(
                    mapRow(rs));
        }


        return list;
    }


    // =========================================================
    // MAP RESULTSET TO CRIME REPORT
    // =========================================================

    private CrimeReport mapRow(
            ResultSet rs)
            throws SQLException {


        CrimeReport r =
                new CrimeReport();


        r.setReportId(
                rs.getInt("reportid"));


        r.setCaseId(
                rs.getString("caseid"));


        r.setUserId(
                rs.getInt("userid"));


        r.setCrimeType(
                rs.getString("crimetype"));


        r.setDescription(
                rs.getString("description"));


        r.setIncidentDate(
                rs.getDate("incidentdate"));


        r.setIncidentTime(
                rs.getTime("incidenttime"));


        r.setLocation(
                rs.getString("location"));


        r.setCity(
                rs.getString("city"));


        r.setReportedAt(
                rs.getTimestamp("reportedat"));


        int assignedAdmin =
                rs.getInt("assignedadmin");


        r.setAssignedAdmin(
                rs.wasNull()
                        ? null
                        : assignedAdmin);


        r.setCurrentStatus(
                safeGetString(
                        rs,
                        "currentstatus",
                        "Pending"));


        r.setStatusRemarks(
                safeGetString(
                        rs,
                        "statusremarks",
                        ""));


        r.setReporterName(
                safeGetString(
                        rs,
                        "reportername",
                        ""));


        r.setReporterEmail(
                safeGetString(
                        rs,
                        "reporteremail",
                        ""));


        return r;
    }


    // =========================================================
    // SAFE GET STRING
    // =========================================================

    private String safeGetString(
            ResultSet rs,
            String column,
            String fallback) {


        try {

            String value =
                    rs.getString(column);


            return value != null
                    ? value
                    : fallback;


        } catch (SQLException e) {

            return fallback;
        }
    }
}