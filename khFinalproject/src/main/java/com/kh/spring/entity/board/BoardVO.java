package com.kh.spring.entity.board;

import java.sql.Date;

import lombok.Data;
@Data
public class BoardVO {
	private int boardNo;
	private int boardtypeName;
	private String memberEmail;
	private String memberNick;
	private String boardTitle;
	private Date boardDate;
	private String boardContent;
	private int boardViews;
	private int boardSuperno;
	private int boardGroupno;
	private int boardDepth;
//	private List<BoardDto> list;
//	private String memberNick;
	
	//추가 : 답변글인지 확인하는 메소드
	public boolean hasDepth() {
		return this.boardDepth > 0;
	}
}
