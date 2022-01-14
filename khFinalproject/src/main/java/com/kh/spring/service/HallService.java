package com.kh.spring.service;

import com.kh.spring.entity.theater.HallDto;

public interface HallService {

	void edit(HallDto hallDto);
	
	void delete(int hallNo);
}
