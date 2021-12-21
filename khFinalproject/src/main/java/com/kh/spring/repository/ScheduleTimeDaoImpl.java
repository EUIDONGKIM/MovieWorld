package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.ScheduleTimeDto;

@Repository
public class ScheduleTimeDaoImpl implements ScheduleTimeDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(ScheduleTimeDto scheduleTimeDto) {
		sqlSession.insert("scheduleTime.insert", scheduleTimeDto);
	}
	
}