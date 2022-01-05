package com.kh.spring.repository.movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.movie.VideoDto;

@Repository
public class VideoDaoImpl implements VideoDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(VideoDto videoDto) {
		sqlSession.insert("video.insert",videoDto);
	}

	@Override
	public List<VideoDto> listByMovie(int movieNo) {
		return sqlSession.selectList("video.listByMovie",movieNo);
	}

	@Override
	public boolean delete(int videoNo) {
		return sqlSession.delete("video.delete",videoNo)>0;
	}

}
