package com.kh.spring.repository.schedule;

import java.util.List;

import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.vo.ChartVO;

public interface TotalInfoViewDao {
	List<TotalInfoViewDto> list();
	//추후에 리스트들을 <where>로 통합.
	TotalInfoViewDto get(int scheduleNo);
	List<TotalInfoViewDto> list(int movieNo);
	
	List<TotalInfoViewDto> listByTheater(int theaterNo);
	List<TotalInfoViewDto> nowList(int movieNo);
	List<Integer> nowMoiveList();
	List<Integer> moiveListByPeriod(String scheduleStart, String scheduleEnd);
	List<Integer> nowTMoiveListContainSoon();
	ChartVO checkStatus(int movieNo);
	int nowMoiveListCount();
	List<Integer> nowMoiveListSearch(int begin, int end);
	List<Integer> soonMovieList();
}
