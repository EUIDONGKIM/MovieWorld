package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.TheaterDto;

public interface TheaterDao {
	List<TheaterDto> listByCity(String city);
	List<TheaterDto> list();
	
	void create(TheaterDto theaterDto);
}
