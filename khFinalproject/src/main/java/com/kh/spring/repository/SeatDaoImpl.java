package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.SeatDto;

@Repository
public class SeatDaoImpl implements SeatDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(SeatDto seatDto) {
		sqlSession.insert("seat.insert",seatDto);
	}

}
