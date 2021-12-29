package com.kh.spring.repository.board;

import java.util.List;

import com.kh.spring.entity.board.BoardDto;

public interface BoardDao {
	//게시글작성
	int write(BoardDto boardDto);
	
	//게시글 단일조회
	BoardDto get(int boardNo);
	
	//시퀸스번호 미리뽑기
	int getSequence();
	//목록
	List<BoardDto> list();
	
	//게시글삭제
	boolean delete (int boardNo);
	boolean edit (BoardDto boardDto);
	boolean viewUp(int boardNo);
}
