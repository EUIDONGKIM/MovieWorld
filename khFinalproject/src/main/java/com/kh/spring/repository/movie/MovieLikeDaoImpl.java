package com.kh.spring.repository.movie;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public boolean get(int movieNo, int memberNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("movieNo", movieNo);
		param.put("memberNo", memberNo);
		return sqlSession.selectList("movieLike.get",param).size() > 0;
	}

}
