package com.kh.spring.entity.board;

import java.util.Date;

import lombok.Data;
@Data
public class BoardDto {
	private int boardNo;
	private int boardTypeNo;
	private String memberEmail;
	private String title;
	private Date boardDate;
	private String boardContent;
	private int boardViews;
	private int boardSuperNo;
	private int boardGroupNo;
	private int boardDepth;

}
