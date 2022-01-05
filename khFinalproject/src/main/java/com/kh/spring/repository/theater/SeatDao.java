package com.kh.spring.repository.theater;

import java.util.List;

import com.kh.spring.entity.theater.SeatDto;

public interface SeatDao {

	void insert(SeatDto seatDto);

	List<SeatDto> list(int hallNo);

	int getSeatNo(int hallNo, int seatRows, int seatCols);
	
	void delete(int hallNo);

}
