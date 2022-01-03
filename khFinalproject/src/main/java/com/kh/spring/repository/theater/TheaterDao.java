package com.kh.spring.repository.theater;

import java.util.List;

import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.vo.PaginationVO;
import com.kh.spring.vo.TheaterCityVO;

public interface TheaterDao {
	List<TheaterDto> listByCity(String city);
	List<TheaterDto> list();
	
	void create(TheaterDto theaterDto);
	
	//지역 나열
	List<TheaterCityVO> cityList();
	
	//지역별 극장 목록
	List<TheaterDto> listByCity2(String city);
	
	//상세 조회
	TheaterDto get(int theaterNo);
	
	//극장 삭제 
	void delete(int theaterNo);
	
	//수정
	void edit(TheaterDto theaterDto);
	void editInfo(TheaterDto theaterDto);
	
	int count(PaginationVO paginationVO);
	List<TheaterDto> search(PaginationVO paginationVO);

}
