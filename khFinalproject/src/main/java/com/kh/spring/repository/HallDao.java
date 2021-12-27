package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.HallTypePriceDto;

public interface HallDao {
	List<HallDto> list();
	List<HallTypePriceDto> getHallTypeList();
	
	//영화관별 극장목록
	List<HallDto> list(int theaterNo);
	
	void insert(HallDto hallDto);

	void update(int hallNo, int count);

	int getSeq();
	HallDto get(int hallNo);
	
	//극장별 상영관 개수
	int hallCount (int theaterNo);
}
