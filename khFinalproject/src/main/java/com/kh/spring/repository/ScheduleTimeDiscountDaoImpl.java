package com.kh.spring.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.ScheduleTimeDiscountDto;

@Repository
public class ScheduleTimeDiscountDaoImpl implements ScheduleTimeDiscountDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ScheduleTimeDiscountDto> list() {
		return sqlSession.selectList("scheduleTimeDiscount.list");
	}
	
}
