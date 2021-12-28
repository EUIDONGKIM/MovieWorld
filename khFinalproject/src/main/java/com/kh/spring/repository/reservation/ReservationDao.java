package com.kh.spring.repository.reservation;

import com.kh.spring.entity.reservation.ReservationDto;

public interface ReservationDao {
	int getSequence();

	void insert(ReservationDto reservationDto);
}
