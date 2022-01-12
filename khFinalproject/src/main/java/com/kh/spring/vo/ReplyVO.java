package com.kh.spring.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int movieNo;
	private int memberNo;
	private String reviewContent;
	private int reviewStarpoint;
	private String reviewDate;
	private int reviewLike;
	private String memberNick;
}
