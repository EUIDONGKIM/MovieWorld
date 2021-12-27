package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.spring.entity.ActorDto;

public class ActorDaoImpl implements ActorDao{
	
	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public List<ActorDto> list() {

		return sqlSession.selectList("actor.list");
	}

	@Override
	public ActorDto get(int actorNo) {
		
		return sqlSession.selectOne("actor.get", actorNo);
	}
	
	
}
