package com.kh.spring.entity;

import lombok.Data;

@Data
public class MoviePhotoDto {
	private int moviePhotoNo;
	private int movieNo;
	private String moviePhotoUploadName;
	private String moviePhotoSaveName;
	private long moviePhotoSize;
	private String moviePhotoType;
}
