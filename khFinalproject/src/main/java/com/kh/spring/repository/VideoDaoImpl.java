package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.VideoDto;

@Repository
public class VideoDaoImpl implements VideoDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(VideoDto videoDto) {
		sqlSession.insert("video.insert",videoDto);
	}

}
