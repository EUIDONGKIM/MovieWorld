package com.kh.spring.repository.actor;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.RoleDto;

@Repository
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

	@Override
	public List<ActorDto> listByJob(String actorJob) {
		return sqlSession.selectList("actor.listByJob",actorJob);
	}

	
}
