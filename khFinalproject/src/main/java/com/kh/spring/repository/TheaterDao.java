package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.vo.TheaterCityVO;

public interface TheaterDao {
	List<TheaterDto> listByCity(String city);
	List<TheaterDto> list();
	
	void create(TheaterDto theaterDto);
	
	//지역 나열
	List<TheaterCityVO> cityList();
	
	//지역별 극장 목록
	List<TheaterDto> listByCity2(String city);

}
