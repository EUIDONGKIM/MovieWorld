package com.kh.spring.repository.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.schedule.TotalInfoViewDto;

@Repository
public class TotalInfoViewDaoImpl implements TotalInfoViewDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<TotalInfoViewDto> list() {
		return sqlSession.selectList("totalInfoView.list");
	}
	//추후에 리스트들을 <where>로 통합.
	@Override
	public TotalInfoViewDto get(int scheduleNo) {

		return sqlSession.selectOne("totalInfoView.getByscheduleNo",scheduleNo);
	}
	@Override
	public List<TotalInfoViewDto> list(int movieNo) {
		return sqlSession.selectList("totalInfoView.listByMovie",movieNo);
	}
	@Override
	public List<TotalInfoViewDto> listByTheater(int theaterNo) {
		return sqlSession.selectList("totalInfoView.listByTheater", theaterNo);
	}
	@Override
	public List<TotalInfoViewDto> nowList(int movieNo) {
		return sqlSession.selectList("totalInfoView.nowList", movieNo);
	}
	@Override
	public List<Integer> nowMoiveList() {
		return sqlSession.selectList("totalInfoView.nowMoiveList");
	}
	@Override
	public List<Integer> moiveListByPeriod(String scheduleStart, String scheduleEnd) {
		Map<String,Object> param = new HashMap<>();
		param.put("scheduleStart",scheduleStart);
		param.put("scheduleEnd",scheduleEnd);
		
		return sqlSession.selectList("totalInfoView.moiveListByPeriod",param);
	}
	
	
}
