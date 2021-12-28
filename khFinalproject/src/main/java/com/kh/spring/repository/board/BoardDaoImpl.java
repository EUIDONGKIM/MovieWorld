package com.kh.spring.repository.board;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.board.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlsession;
	@Override
	public void write(BoardDto boardDto) {
		System.err.println("1");
		sqlsession.insert("board.wirte",boardDto);
	}

}
