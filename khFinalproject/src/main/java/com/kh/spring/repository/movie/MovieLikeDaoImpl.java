package com.kh.spring.repository.movie;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.movie.MovieLikeDto;

@Repository
public class MovieLikeDaoImpl implements MovieLikeDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MovieLikeDto movieLikeDto) {
		sqlSession.insert("movieLike.insert",movieLikeDto);
	}

	@Override
	public void delete(MovieLikeDto movieLikeDto) {
		sqlSession.delete("movieLike.delete",movieLikeDto);
	}

}
