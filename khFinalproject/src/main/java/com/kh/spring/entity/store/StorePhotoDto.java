package com.kh.spring.entity.store;

import lombok.Data;

@Data
public class StorePhotoDto {
	private int productPhotoNo;
	private int productNo;
	private String productPhotoUploadName;
	private String productPhotoSaveName;
	private long productPhotoSize;
	private String productPhotoType;
}
