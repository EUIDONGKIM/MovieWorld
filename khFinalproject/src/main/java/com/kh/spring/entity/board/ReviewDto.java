package com.kh.spring.entity.board;

import java.sql.Date;

import lombok.Data;
@Data
public class ReviewDto {
	
	private String reviewContent;
	private float reviewStarPoinr;
	private Date reviewDate;
	private int reviewLike;
	
}
