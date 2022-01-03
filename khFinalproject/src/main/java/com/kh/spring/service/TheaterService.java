package com.kh.spring.service;

import com.kh.spring.entity.theater.TheaterDto;

public interface TheaterService {

	
	void editTheater(TheaterDto theaterDto);
	
	boolean deleteTheater(int theaterNo);
}
