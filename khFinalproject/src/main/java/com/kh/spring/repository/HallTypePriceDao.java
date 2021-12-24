package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.HallTypePriceDto;

public interface HallTypePriceDao {

	int getPrice(String hallType);
	
	//상영관 만들 때 종류 목록 조회
	List<HallTypePriceDto> list();

}
