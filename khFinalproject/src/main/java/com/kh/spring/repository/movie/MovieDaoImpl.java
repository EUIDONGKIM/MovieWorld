package com.kh.spring.repository.movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.movie.MovieDto;

@Repository
public class MovieDaoImpl implements MovieDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MovieDto> list() {
		return sqlSession.selectList("movie.list");
	}

	@Override
	public MovieDto get(int movieNo) {
		return sqlSession.selectOne("movie.get", movieNo);
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("movie.getSequence");
	}

	@Override
	public void insert(MovieDto movieDto) {
		sqlSession.insert("movie.insert",movieDto);
	}

	@Override
	public List<MovieDto> listWithoutDuplicate(int theaterNo) {
		return sqlSession.selectList("movie.listWithoutDuplicate", theaterNo);
	}
		
	@Override
	public List<MovieDto> listByOpening() {
		return sqlSession.selectList("movie.listByOpening");
	}

}
