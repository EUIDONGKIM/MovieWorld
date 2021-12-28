package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.BoardDto;

public interface BoardDao {
	//게시글 작성 
	void write(BoardDto boardDto);
	
	
	//게시글 리스트
	List<BoardDto> list();
	List<BoardDto> get(int boardNo); 
}
