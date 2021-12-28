package com.kh.spring.repository.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.board.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlsession;
	@Override
	public int write(BoardDto boardDto) {
		int boardNo = sqlsession.selectOne("board.getSeq");
		boardDto.setBoardNo(boardNo);
		sqlsession.insert("board.write",boardDto);
		return boardNo;
	}
	
	@Override
	public List<BoardDto> list() {
		return sqlsession.selectList("board.list");
	}

	@Override
	public BoardDto get(int boardNo) {
		return sqlsession.selectOne("board.get",boardNo);
	}

	@Override
	public int getSequence() {
		return sqlsession.selectOne("board.getSeq");
	}

	@Override
	public boolean delete(int boardNo) {
		BoardDto boardDto = new BoardDto();
		boardDto.setBoardNo(boardNo);
		int count = sqlsession.delete("board.delete",boardDto);
		return count>0;
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlsession.update("board.edit",boardDto);
		return count>0;
	}



}
