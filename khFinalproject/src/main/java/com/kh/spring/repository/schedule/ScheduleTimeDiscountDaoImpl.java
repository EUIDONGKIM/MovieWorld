package com.kh.spring.repository.schedule;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.schedule.ScheduleTimeDiscountDto;

@Repository
public class ScheduleTimeDiscountDaoImpl implements ScheduleTimeDiscountDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ScheduleTimeDiscountDto> list() {
		return sqlSession.selectList("scheduleTimeDiscount.list");
	}

	@Override
	public void insert(ScheduleTimeDiscountDto scheduleTimeDiscountDto) {
		sqlSession.insert("scheduleTimeDiscount.insert",scheduleTimeDiscountDto);
	}

	@Override
	public boolean delete(int scheduleTimeDiscountNo) {
		return sqlSession.delete("scheduleTimeDiscount.delete", scheduleTimeDiscountNo) > 0;
	}

	@Override
	public boolean edit(ScheduleTimeDiscountDto scheduleTimeDiscountDto) {
		return sqlSession.update("scheduleTimeDiscount.edit", scheduleTimeDiscountDto) > 0;
	}
	
}
