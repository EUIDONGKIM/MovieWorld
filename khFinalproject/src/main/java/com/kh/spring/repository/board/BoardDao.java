package com.kh.spring.repository.board;

import java.util.List;

import com.kh.spring.entity.board.BoardDto;

public interface BoardDao {
	//게시글작성
	void write(BoardDto boardDto);
	
	//게시글 단일조회
	BoardDto get(int boardNo);
	//목록
	List<BoardDto> list();
}
