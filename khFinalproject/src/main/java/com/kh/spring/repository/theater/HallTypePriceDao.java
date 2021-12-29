package com.kh.spring.repository.theater;

import java.util.List;

import com.kh.spring.entity.theater.HallTypePriceDto;

public interface HallTypePriceDao {

	int getPrice(String hallType);
	
	//상영관 만들 때 종류 목록 조회
	List<HallTypePriceDto> list();
	
	void insert(HallTypePriceDto hallTypePriceDto);
	
	boolean delete(int hallTypeNo);
	
	boolean edit(HallTypePriceDto hallTypePriceDto);

}
