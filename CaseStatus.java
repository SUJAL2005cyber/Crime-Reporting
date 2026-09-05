package com.model;

import java.sql.Timestamp;

public class CaseStatus {
	 private int statusId;
	    private int reportId;
	    private String status;     
	    private String remarks;
	    private Integer updatedBy;  
	    private Timestamp updatedAt;
		public int getStatusId() {
			return statusId;
		}
		public void setStatusId(int statusId) {
			this.statusId = statusId;
		}
		public int getReportId() {
			return reportId;
		}
		public void setReportId(int reportId) {
			this.reportId = reportId;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		public Integer getUpdatedBy() {
			return updatedBy;
		}
		public void setUpdatedBy(Integer updatedBy) {
			this.updatedBy = updatedBy;
		}
		public Timestamp getUpdatedAt() {
			return updatedAt;
		}
		public void setUpdatedAt(Timestamp updatedAt) {
			this.updatedAt = updatedAt;
		}
		public CaseStatus(int statusId, int reportId, String status, String remarks, Integer updatedBy,
				Timestamp updatedAt) {
			super();
			this.statusId = statusId;
			this.reportId = reportId;
			this.status = status;
			this.remarks = remarks;
			this.updatedBy = updatedBy;
			this.updatedAt = updatedAt;
		}
		public CaseStatus() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "CaseStatus [statusId=" + statusId + ", reportId=" + reportId + ", status=" + status + ", remarks="
					+ remarks + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt + "]";
		}

}
