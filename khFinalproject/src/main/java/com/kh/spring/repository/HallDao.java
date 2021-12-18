package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.HallTypePriceDto;

public interface HallDao {
	List<HallTypePriceDto> getHallTypeList();

	void insert(HallDto hallDto);

	void update(int hallNo, int hallSeat);

	int getSeq();
}
