package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.ScheduleDto;

@Repository
public class ScheduleDaoImpl implements ScheduleDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ScheduleDto schedulDto) {
		sqlSession.insert("schedule.insert",schedulDto);
	}

	@Override
	public List<ScheduleDto> list() {
		return sqlSession.selectList("schedule.list");
	}

}
