package com.kh.spring.repository.board;

import java.util.List;

import com.kh.spring.entity.board.BoardDto;

public interface BoardDao {
	//게시글작성
	void write(BoardDto boardDto);
	
	//게시글 단일조회
	BoardDto get(int boardNo);
	
	//특정 사용자가 작성한 게시글 조회
	List<BoardDto> getUserWrite(String memberEmail);
	
	//시퀸스번호 미리뽑기
	int getSequence();
	//목록
	List<BoardDto> list();
	
	//게시글삭제
	boolean delete (int boardNo);
	boolean edit (BoardDto boardDto);
	boolean viewUp(int boardNo);
	//검색
	List<BoardDto> search(String column, String keyword, int begin, int end);


	int count(String column, String keyword);

	void write1(BoardDto boardDto);

	void write2(BoardDto boardDto);

	int count1(String column, String keyword, String memberEmail);

	List<BoardDto> search1(String column, String keyword, int begin, int end, String memberEmail);
}
