package com.kh.spring.repository.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.vo.HallByScheduleTimeVO;

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
	public List<HallByScheduleTimeVO> listByDate(int scheduleNo, String scheduleTimeDate) {
		Map<String,Object> param = new HashMap<>();
		param.put("scheduleNo",scheduleNo);
		param.put("scheduleTimeDate",scheduleTimeDate);
		
		return sqlSession.selectList("scheduleTime.listByDate", param);
	}


	@Override
	public ScheduleTimeDto get(int scheduleTimeNo) {
		return sqlSession.selectOne("scheduleTime.get",scheduleTimeNo);
	}


	@Override
	public void reservationUpdate(ScheduleTimeDto scheduleTimeDto) {
		sqlSession.update("scheduleTime.reservationUpdate",scheduleTimeDto);
	}


	@Override
	public void reservationMinusUpdate(ScheduleTimeDto scheduleTimeDto) {
		sqlSession.update("scheduleTime.reservationMinusUpdate",scheduleTimeDto);
	}


	@Override
	public boolean delete(int scheduleTimeNo) {
		return sqlSession.delete("scheduleTime.delete",scheduleTimeNo)>0;
	}


	@Override
	public boolean edit(ScheduleTimeDto scheduleTimeDto) {
		return sqlSession.update("scheduleTime.edit",scheduleTimeDto)>0;
	}

	@Override
	public int getTheaterNo(int scheduleTimeNo) {
		return sqlSession.selectOne("scheduleTime.getTheaterNo", scheduleTimeNo);
	}


	@Override
	public boolean isScheduleTimeExist(int hallNo) {
		return sqlSession.selectList("scheduleTime.exist", hallNo).isEmpty();
	}

}
