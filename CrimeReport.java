package com.model;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CrimeReport {
	 private int reportId;
	    private String caseId;
	    private int userId;
	    private String crimeType;
	    private String description;
	    private Date incidentDate;
	    private Time incidentTime;
	    private String location;
	    private String city;
	    private Timestamp reportedAt;
	    private Integer assignedAdmin;

	    
	    private String reporterName;   
	    private String reporterEmail;  
	    private String currentStatus;  
	    private String statusRemarks;
	    private List<Evidence> evidenceList = new ArrayList<>();
		public int getReportId() {
			return reportId;
		}
		public void setReportId(int reportId) {
			this.reportId = reportId;
		}
		public String getCaseId() {
			return caseId;
		}
		public void setCaseId(String caseId) {
			this.caseId = caseId;
		}
		public int getUserId() {
			return userId;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		public String getCrimeType() {
			return crimeType;
		}
		public void setCrimeType(String crimeType) {
			this.crimeType = crimeType;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public Date getIncidentDate() {
			return incidentDate;
		}
		public void setIncidentDate(Date incidentDate) {
			this.incidentDate = incidentDate;
		}
		public Time getIncidentTime() {
			return incidentTime;
		}
		public void setIncidentTime(Time incidentTime) {
			this.incidentTime = incidentTime;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}
		public String getCity() {
			return city;
		}
		public void setCity(String city) {
			this.city = city;
		}
		public Timestamp getReportedAt() {
			return reportedAt;
		}
		public void setReportedAt(Timestamp reportedAt) {
			this.reportedAt = reportedAt;
		}
		public Integer getAssignedAdmin() {
			return assignedAdmin;
		}
		public void setAssignedAdmin(Integer assignedAdmin) {
			this.assignedAdmin = assignedAdmin;
		}
		public String getReporterName() {
			return reporterName;
		}
		public void setReporterName(String reporterName) {
			this.reporterName = reporterName;
		}
		public String getReporterEmail() {
			return reporterEmail;
		}
		public void setReporterEmail(String reporterEmail) {
			this.reporterEmail = reporterEmail;
		}
		public String getCurrentStatus() {
			return currentStatus;
		}
		public void setCurrentStatus(String currentStatus) {
			this.currentStatus = currentStatus;
		}
		public String getStatusRemarks() {
			return statusRemarks;
		}
		public void setStatusRemarks(String statusRemarks) {
			this.statusRemarks = statusRemarks;
		}
		public List<Evidence> getEvidenceList() {
			return evidenceList;
		}
		public void setEvidenceList(List<Evidence> evidenceList) {
			this.evidenceList = evidenceList;
		}
		public CrimeReport(int reportId, String caseId, int userId, String crimeType, String description,
				Date incidentDate, Time incidentTime, String location, String city, Timestamp reportedAt,
				Integer assignedAdmin, String reporterName, String reporterEmail, String currentStatus,
				String statusRemarks, List<Evidence> evidenceList) {
			super();
			this.reportId = reportId;
			this.caseId = caseId;
			this.userId = userId;
			this.crimeType = crimeType;
			this.description = description;
			this.incidentDate = incidentDate;
			this.incidentTime = incidentTime;
			this.location = location;
			this.city = city;
			this.reportedAt = reportedAt;
			this.assignedAdmin = assignedAdmin;
			this.reporterName = reporterName;
			this.reporterEmail = reporterEmail;
			this.currentStatus = currentStatus;
			this.statusRemarks = statusRemarks;
			this.evidenceList = evidenceList;
		}
		public CrimeReport() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "CrimeReport [reportId=" + reportId + ", caseId=" + caseId + ", userId=" + userId + ", crimeType="
					+ crimeType + ", description=" + description + ", incidentDate=" + incidentDate + ", incidentTime="
					+ incidentTime + ", location=" + location + ", city=" + city + ", reportedAt=" + reportedAt
					+ ", assignedAdmin=" + assignedAdmin + ", reporterName=" + reporterName + ", reporterEmail="
					+ reporterEmail + ", currentStatus=" + currentStatus + ", statusRemarks=" + statusRemarks
					+ ", evidenceList=" + evidenceList + "]";
		}
	    
}
