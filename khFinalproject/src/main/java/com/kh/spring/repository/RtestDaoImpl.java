package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.RtestDto;

@Repository
public class RtestDaoImpl implements RtestDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<RtestDto> list(int scheduleTimeNo) {
		return sqlSession.selectList("rtest.list",scheduleTimeNo);
	}

}
