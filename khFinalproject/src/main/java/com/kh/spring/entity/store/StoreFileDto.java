package com.kh.spring.entity.store;

import lombok.Data;

@Data
public class StoreFileDto {
	private int productFileNo;
	private int productNo;
	private String productFileUploadName;
	private String productFileSaveName;
	private long productFileSize;
	private String productFileType;
}
