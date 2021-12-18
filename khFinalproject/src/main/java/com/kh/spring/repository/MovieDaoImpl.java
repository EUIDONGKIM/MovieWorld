package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.MovieDto;

@Repository
public class MovieDaoImpl implements MovieDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MovieDto> list() {
		return sqlSession.selectList("movie.list");
	}

}
