package com.kh.spring.entity;

import lombok.Data;

@Data
public class MemberDiscountDto {
	private String memberGrade;
	private int memberDiscountPrice;
}
