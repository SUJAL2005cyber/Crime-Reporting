package com.model;

import java.sql.Timestamp;

public class Evidence {
	 private int evidenceId;
	    private int reportId;
	    private String fileName;
	    private String storedPath;
	    private String fileType;
	    private int fileSizeKb;
	    private Timestamp uploadedAt;
		public int getEvidenceId() {
			return evidenceId;
		}
		public void setEvidenceId(int evidenceId) {
			this.evidenceId = evidenceId;
		}
		public int getReportId() {
			return reportId;
		}
		public void setReportId(int reportId) {
			this.reportId = reportId;
		}
		public String getFileName() {
			return fileName;
		}
		public void setFileName(String fileName) {
			this.fileName = fileName;
		}
		public String getStoredPath() {
			return storedPath;
		}
		public void setStoredPath(String storedPath) {
			this.storedPath = storedPath;
		}
		public String getFileType() {
			return fileType;
		}
		public void setFileType(String fileType) {
			this.fileType = fileType;
		}
		public int getFileSizeKb() {
			return fileSizeKb;
		}
		public void setFileSizeKb(int fileSizeKb) {
			this.fileSizeKb = fileSizeKb;
		}
		public Timestamp getUploadedAt() {
			return uploadedAt;
		}
		public void setUploadedAt(Timestamp uploadedAt) {
			this.uploadedAt = uploadedAt;
		}
		public Evidence(int evidenceId, int reportId, String fileName, String storedPath, String fileType,
				int fileSizeKb, Timestamp uploadedAt) {
			super();
			this.evidenceId = evidenceId;
			this.reportId = reportId;
			this.fileName = fileName;
			this.storedPath = storedPath;
			this.fileType = fileType;
			this.fileSizeKb = fileSizeKb;
			this.uploadedAt = uploadedAt;
		}
		public Evidence() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "Evidence [evidenceId=" + evidenceId + ", reportId=" + reportId + ", fileName=" + fileName
					+ ", storedPath=" + storedPath + ", fileType=" + fileType + ", fileSizeKb=" + fileSizeKb
					+ ", uploadedAt=" + uploadedAt + "]";
		}

	    
}
