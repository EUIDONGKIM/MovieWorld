package com.kh.spring.repository;

import com.kh.spring.entity.ReservationDto;

public interface ReservationDao {
	int getSequence();

	void insert(ReservationDto reservationDto);
}
