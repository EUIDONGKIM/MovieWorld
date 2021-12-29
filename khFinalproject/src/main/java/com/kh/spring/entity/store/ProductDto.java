package com.kh.spring.entity.store;

import lombok.Data;

@Data
public class ProductDto {

	private int productNo;
	private String productName;
	private int productPrice;
	private int productQuantity;
	private String productOrigin;
	private String productValidity;
	private String productIntro;
	private String productContent;
}