package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.HallTypePriceDto;

public interface HallDao {
	List<HallDto> list();
	List<HallTypePriceDto> getHallTypeList();
	List<HallDto> list(int theaterNo);
	
	void insert(HallDto hallDto);

	void update(int hallNo, int count);

	int getSeq();
	HallDto get(int hallNo);
}
