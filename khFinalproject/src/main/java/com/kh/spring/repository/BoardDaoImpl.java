package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlsession;
	@Override
	public void write(BoardDto boardDto) {
		sqlsession.insert("board.write",boardDto);
	}
	@Override
	public List<BoardDto> list() {
		return sqlsession.selectList("board.list");
	}
	@Override
	public List<BoardDto> get(int boardNo) {
		return sqlsession.selectOne("board.get",boardNo);
	}

}
