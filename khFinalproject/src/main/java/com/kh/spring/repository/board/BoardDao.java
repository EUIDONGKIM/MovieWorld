package com.kh.spring.repository.board;

import java.util.List;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.entity.board.BoardVO;

public interface BoardDao {
	//게시글작성
	void write(BoardDto boardDto);
	
	//게시글 단일조회
	BoardDto get(int boardNo);
	
	//특정 사용자가 작성한 게시글 조회
	List<BoardVO> getUserWrite(String memberEmail);
	
	//시퀸스번호 미리뽑기
	int getSequence();
	//목록
	List<BoardVO> list();
	
	//게시글삭제
	boolean delete (int boardNo);
	boolean edit (BoardDto boardDto);
	boolean viewUp(int boardNo);
	//검색
	List<BoardVO> search(String column, String keyword, int begin, int end, int boardTypeName);


	int count(String column, String keyword ,int boardTypeNo);

	void write1(BoardDto boardDto);

	void write2(BoardDto boardDto);

	int count1(String column, String keyword, String memberEmail);

	List<BoardVO> search1(String column, String keyword, int begin, int end, String memberEmail);
}
