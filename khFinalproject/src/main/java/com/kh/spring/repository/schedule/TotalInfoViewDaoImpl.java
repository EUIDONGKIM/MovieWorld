package com.kh.spring.repository.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.vo.ChartVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
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
	@Override
	public List<Integer> nowTMoiveListContainSoon() {
		return sqlSession.selectList("totalInfoView.nowTMoiveListContainSoon");
	}
	@Override
	public ChartVO checkStatus(int movieNo) {
		return sqlSession.selectOne("totalInfoView.checkStatus",movieNo);
	}
	@Override
	public int nowMoiveListCount() {
		return sqlSession.selectOne("totalInfoView.nowMoiveListCount");
	}
	@Override
	public List<Integer> nowMoiveListSearch(int begin, int end) {
		log.debug("받는값 begin@@@={}",begin);
		log.debug("받는값 end@@@={}",end);
		Map<String,Object> param = new HashMap<>();
		param.put("begin",begin);
		param.put("end",end);
		
		return sqlSession.selectList("totalInfoView.nowMoiveListSearch",param);
	}
	
	
}
