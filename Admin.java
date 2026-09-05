package com.model;

import java.sql.Timestamp;

public class Admin {
	 private int adminId;
	    private String adminName;
	    private String username;
	    private String email;
	    private String passwordHash;
	    private String passwordSalt;
	    private String designation;
	    private Timestamp createdAt;
		public int getAdminId() {
			return adminId;
		}
		public void setAdminId(int adminId) {
			this.adminId = adminId;
		}
		public String getAdminName() {
			return adminName;
		}
		public void setAdminName(String adminName) {
			this.adminName = adminName;
		}
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPasswordHash() {
			return passwordHash;
		}
		public void setPasswordHash(String passwordHash) {
			this.passwordHash = passwordHash;
		}
		public String getPasswordSalt() {
			return passwordSalt;
		}
		public void setPasswordSalt(String passwordSalt) {
			this.passwordSalt = passwordSalt;
		}
		public String getDesignation() {
			return designation;
		}
		public void setDesignation(String designation) {
			this.designation = designation;
		}
		public Timestamp getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(Timestamp createdAt) {
			this.createdAt = createdAt;
		}
		public Admin(int adminId, String adminName, String username, String email, String passwordHash,
				String passwordSalt, String designation, Timestamp createdAt) {
			super();
			this.adminId = adminId;
			this.adminName = adminName;
			this.username = username;
			this.email = email;
			this.passwordHash = passwordHash;
			this.passwordSalt = passwordSalt;
			this.designation = designation;
			this.createdAt = createdAt;
		}
		public Admin() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "Admin [adminId=" + adminId + ", adminName=" + adminName + ", username=" + username + ", email="
					+ email + ", passwordHash=" + passwordHash + ", passwordSalt=" + passwordSalt + ", designation="
					+ designation + ", createdAt=" + createdAt + "]";
		}
	    
	 

}
