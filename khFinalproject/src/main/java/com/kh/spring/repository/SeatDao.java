package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.SeatDto;

public interface SeatDao {

	void insert(SeatDto seatDto);

	List<SeatDto> list(int hallNo);

}
