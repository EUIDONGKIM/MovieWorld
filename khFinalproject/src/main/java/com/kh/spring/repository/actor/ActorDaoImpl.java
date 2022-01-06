package com.kh.spring.repository.actor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.actor.ActorDto;

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

	@Override
	public void insert(ActorDto actorDto) {
		sqlSession.insert("actor.insert", actorDto);
		
	}

	@Override
	public boolean delete(int actorNo) {
		return sqlSession.delete("actor.delete",actorNo)>0;
	}

	@Override
	public int count(String actorJob, String actorName) {
		Map<String,Object> param = new HashMap<>();
		param.put("actorJob",actorJob);
		param.put("actorName",actorName);
		return sqlSession.selectOne("actor.count",param);
	}

	@Override
	public List<ActorDto> search(String actorJob, String actorName, int begin, int end) {
		Map<String,Object> param = new HashMap<>();
		param.put("actorJob",actorJob);
		param.put("actorName",actorName);
		param.put("begin",begin);
		param.put("end",end);
		return sqlSession.selectList("actor.search",param);
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("actor.getSequence");
	}

	@Override
	public void update(ActorDto actorDto) {
		sqlSession.update("actor.update",actorDto);
	}

	
}
