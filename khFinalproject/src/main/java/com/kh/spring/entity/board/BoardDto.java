package com.kh.spring.entity.board;

import java.util.Date;

import lombok.Data;
@Data
public class BoardDto {
	private int boardNo;
	private int boardtypeName;
	private String memberEmail;
	private String boardTitle;
	private Date boardDate;
	private String boardContent;
	private int boardViews;
	private int boardSuperno;
	private int boardGroupno;
	private int boardDepth;

	//추가 : 답변글인지 확인하는 메소드
	public boolean hasDepth() {
		return this.boardDepth > 0;
	}
}