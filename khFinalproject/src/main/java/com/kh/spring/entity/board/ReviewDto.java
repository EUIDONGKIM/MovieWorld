package com.kh.spring.entity.board;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDto {
	private int movieNo;
	private int memberNo;
	private String reviewContent;
	private int reviewStarpoint;
	private Date reviewDate;
	private int reviewLike;
}
