package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.model.User;
import com.util.DBConnection;

public class UserDAO {

	/*
	 * Register a new user.
	 *
	 * Password is stored directly in passwordhash, matching the password setup
	 * currently used for admin.
	 */
	public int registerUser(User user, String password) throws SQLException {

		String sql = "INSERT INTO users " + "(fullname, email, phone, address, passwordhash, passwordsalt) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setString(1, user.getFullName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getAddress());

			// Store password directly.
			ps.setString(5, password);

			// Salt is not being used with this setup.
			ps.setString(6, "");

			int rows = ps.executeUpdate();

			if (rows == 0) {
				return -1;
			}

			try (ResultSet keys = ps.getGeneratedKeys()) {

				if (keys.next()) {
					return keys.getInt(1);
				}
			}
		}

		return -1;
	}

	/*
	 * Check whether an email address is already registered.
	 */
	public boolean emailExists(String email) throws SQLException {

		String sql = "SELECT userid FROM users WHERE email = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);

			try (ResultSet rs = ps.executeQuery()) {

				return rs.next();
			}
		}
	}

	/*
	 * Authenticate user.
	 */
	public User authenticate(String email, String password) throws SQLException {

		String sql = "SELECT * FROM users " + "WHERE email = ? AND isactive = 1";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);

			try (ResultSet rs = ps.executeQuery()) {

				if (rs.next()) {

					// Get password stored in database.
					String storedPassword = rs.getString("passwordhash");

					/*
					 * Compare entered password with database password.
					 */
					if (password != null && password.equals(storedPassword)) {

						return mapRow(rs);
					}
				}
			}
		}

		// Wrong email/password or inactive user.
		return null;
	}

	/*
	 * Find user using User ID.
	 */
	public User findById(int userId) throws SQLException {

		String sql = "SELECT * FROM users WHERE userid = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, userId);

			try (ResultSet rs = ps.executeQuery()) {

				if (rs.next()) {
					return mapRow(rs);
				}
			}
		}

		return null;
	}

	/*
	 * Convert one database row into User object.
	 */
	private User mapRow(ResultSet rs) throws SQLException {

		User u = new User();

		u.setUserId(rs.getInt("userid"));

		u.setFullName(rs.getString("fullname"));

		u.setEmail(rs.getString("email"));

		u.setPhone(rs.getString("phone"));

		u.setAddress(rs.getString("address"));

		u.setPasswordHash(rs.getString("passwordhash"));

		u.setPasswordSalt(rs.getString("passwordsalt"));

		u.setCreatedAt(rs.getTimestamp("createdat"));

		u.setActive(rs.getBoolean("isactive"));

		return u;
	}
}