package com.kh.spring.entity.store;



import lombok.Data;

@Data
public class StoreDto {

	private int productNo;//상품 번호
	private String productType;//상품 종류
	private String productName;//상품 이름
	private int productPrice;//상품 가격
	private String productOrigin;//원산지
	private String productIntro;//상품 소개
	private String productContent;//상품 내용
}