package com.kh.spring.repository.actor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.actor.TotalRoleViewDto;

@Repository
public class TotalRoleViewDaoImpl implements TotalRoleViewDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<TotalRoleViewDto> listByJob(int movieNo, String actorJob) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo",movieNo);
		param.put("actorJob",actorJob);
		return sqlSession.selectList("totalRoleView.listByJob",param);
	}

	@Override
	public List<TotalRoleViewDto> listByActorNo(int actorNo) {
		return sqlSession.selectList("totalRoleView.listByActorNo",actorNo);
	}

	@Override
	public List<TotalRoleViewDto> listByMovieNo(int movieNo) {
		return sqlSession.selectList("totalRoleView.listByMovieNo",movieNo);
	}
}
