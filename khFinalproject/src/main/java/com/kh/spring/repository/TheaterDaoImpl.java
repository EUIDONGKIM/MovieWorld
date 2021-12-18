package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.TheaterDto;

@Repository
public class TheaterDaoImpl implements TheaterDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<TheaterDto> listByCity(String city) {
		return sqlSession.selectList("theater.listByCity",city);
	}

	@Override
	public List<TheaterDto> list() {
		return sqlSession.selectList("theater.list");
	}

}
