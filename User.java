package com.model;

import java.sql.Timestamp;

public class User {
	 private int userId;
	    private String fullName;
	    private String email;
	    private String phone;
	    private String address;
	    private String passwordHash;
	    private String passwordSalt;
	    private Timestamp createdAt;
	    private boolean active;
		public int getUserId() {
			return userId;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		public String getFullName() {
			return fullName;
		}
		public void setFullName(String fullName) {
			this.fullName = fullName;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
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
		public Timestamp getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(Timestamp createdAt) {
			this.createdAt = createdAt;
		}
		public boolean isActive() {
			return active;
		}
		public void setActive(boolean active) {
			this.active = active;
		}
		public User(int userId, String fullName, String email, String phone, String address, String passwordHash,
				String passwordSalt, Timestamp createdAt, boolean active) {
			super();
			this.userId = userId;
			this.fullName = fullName;
			this.email = email;
			this.phone = phone;
			this.address = address;
			this.passwordHash = passwordHash;
			this.passwordSalt = passwordSalt;
			this.createdAt = createdAt;
			this.active = active;
		}
		public User() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "User [userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone
					+ ", address=" + address + ", passwordHash=" + passwordHash + ", passwordSalt=" + passwordSalt
					+ ", createdAt=" + createdAt + ", active=" + active + "]";
		}
	    
}
