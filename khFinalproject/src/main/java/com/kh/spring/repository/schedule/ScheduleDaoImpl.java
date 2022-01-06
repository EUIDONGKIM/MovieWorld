package com.kh.spring.repository.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.schedule.ScheduleDto;

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

	@Override
	public int getByMovieTheater(int movieNo, int theaterNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo",movieNo);
		param.put("theaterNo",theaterNo);
		return sqlSession.selectOne("schedule.getByMovieTheater", param);
	}

	@Override
	public List<ScheduleDto> list(int theaterNo) {
		return sqlSession.selectList("schedule.getByTheater",theaterNo);
	}

	@Override
	public boolean delete(int scheduleNo) {
		return sqlSession.delete("schedule.delete", scheduleNo) > 0;
	}

	@Override
	public void edit(ScheduleDto schedulDto) {
		sqlSession.update("schedule.edit", schedulDto);
	}

}
