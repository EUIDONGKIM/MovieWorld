package com.kh.spring.entity.board;

import java.sql.Date;

import lombok.Data;
@Data
public class ReviewDto {
	private int movieNo;
	private int memberNo;
	private String reviewContent;
	private int reviewStarpoint;
	private String reviewDate;
	private int reviewLike;
}