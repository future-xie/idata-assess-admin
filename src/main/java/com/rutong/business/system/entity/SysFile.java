package com.rutong.business.system.entity;

import com.rutong.business.common.entity.BaseEntity;

import java.math.BigDecimal;

public class SysFile extends BaseEntity {
	  /**
     * 文件名称
     */
    private String fileName;
    
    /**
     * 文件类型
     */
    private String fileType;  

    /**
     * 文件MD5
     */
    private String fileMd5;

    /**
     * 文件相对路径
     */
    private String filePath;
	
	
    /**
     * 文件大小(字节)
     */
    private BigDecimal fileSize;

	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getFileType() {
		return fileType;
	}


	public void setFileType(String fileType) {
		this.fileType = fileType;
	}


	public String getFileMd5() {
		return fileMd5;
	}


	public void setFileMd5(String fileMd5) {
		this.fileMd5 = fileMd5;
	}


	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	public BigDecimal getFileSize() {
		return fileSize;
	}


	public void setFileSize(BigDecimal fileSize) {
		this.fileSize = fileSize;
	}

}
