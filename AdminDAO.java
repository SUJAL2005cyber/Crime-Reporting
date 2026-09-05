package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Admin;
import com.model.User;
import com.util.DBConnection;


public class AdminDAO {

    // =========================================================
    // ADMIN LOGIN
    // =========================================================
	public Admin authenticate(String username, String plainPassword)
	        throws SQLException {

	    String sql = "SELECT * FROM admin WHERE username = ?";

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)
	    ) {

	        ps.setString(1, username);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {

	                String storedPassword =
	                        rs.getString("passwordhash");

	                if (plainPassword.equals(storedPassword)) {

	                    Admin admin = new Admin();

	                    admin.setAdminId(
	                            rs.getInt("adminid"));

	                    admin.setAdminName(
	                            rs.getString("adminname"));

	                    admin.setUsername(
	                            rs.getString("username"));

	                    admin.setEmail(
	                            rs.getString("email"));

	                    admin.setDesignation(
	                            rs.getString("designation"));

	                    admin.setCreatedAt(
	                            rs.getTimestamp("createdat"));

	                    return admin;
	                }
	            }
	        }
	    }

	    return null;
	}


    // =========================================================
    // GET ALL USERS
    // =========================================================
    public List<User> getAllUsers()
            throws SQLException {

        List<User> list =
                new ArrayList<>();

        String sql =
                "SELECT * FROM users "
                + "ORDER BY createdat DESC";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery()
        ) {

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("userid"));

                user.setFullName(
                        rs.getString("fullname"));

                user.setEmail(
                        rs.getString("email"));

                user.setPhone(
                        rs.getString("phone"));

                user.setAddress(
                        rs.getString("address"));

                user.setCreatedAt(
                        rs.getTimestamp("createdat"));

                user.setActive(
                        rs.getBoolean("isactive"));

                list.add(user);
            }
        }

        return list;
    }


    // =========================================================
    // ACTIVATE / DEACTIVATE USER
    // =========================================================
    public boolean setUserActive(
            int userId,
            boolean active)
            throws SQLException {

        String sql =
                "UPDATE users "
                + "SET isactive = ? "
                + "WHERE userid = ?";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql)
        ) {

            ps.setBoolean(1, active);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        }
    }
}