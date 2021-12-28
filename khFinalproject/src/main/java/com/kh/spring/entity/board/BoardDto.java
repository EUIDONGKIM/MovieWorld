package com.kh.spring.entity.board;

import java.util.Date;

import lombok.Data;
@Data
public class BoardDto {
	private int boardNo;
	private int boardTypeNo;
	private String memberEmail;
	private String boardTitle;
	private Date boardDate;
	private String boardContent;
	private int boardReply;
	private int boardViews;
	private int boardSuperNo;
	private int boardGroupNo;
	private int boardDepth;

//	//추가 : 댓글이 존재하는지 확인하는 메소드
	public boolean isReplyExist() {
		return this.boardReply > 0;
	}
	//추가 : 답변글인지 확인하는 메소드
	public boolean hasDepth() {
		return this.boardDepth > 0;
	}
}