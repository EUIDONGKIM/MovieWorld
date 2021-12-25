package com.kh.spring.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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


	@Override
	public List<String> dateList(int scheduleNo) {
		return sqlSession.selectList("scheduleTime.dateList", scheduleNo);
	}




	@Override
	public List<ScheduleTimeDto> listByDate(int scheduleNo, String scheduleTimeDate) {
		Map<String,Object> param = new HashMap<>();
		param.put("scheduleNo",scheduleNo);
		param.put("scheduleTimeDate",scheduleTimeDate);
		
		return sqlSession.selectList("scheduleTime.listByDate", param);
	}


	@Override
	public ScheduleTimeDto get(int scheduleTimeNo) {
		return sqlSession.selectOne("scheduleTime.get",scheduleTimeNo);
	}
}
