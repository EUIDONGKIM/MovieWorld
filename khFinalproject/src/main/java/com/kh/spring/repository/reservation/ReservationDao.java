package com.kh.spring.repository.reservation;

import com.kh.spring.entity.reservation.ReservationDto;

public interface ReservationDao {
	int getSequence();

	void insert(ReservationDto reservationDto);

	ReservationDto get(int reservationNo);

	void updatePrice(int reservationNo, int totalReservationPice);

	boolean remove(int reservationNo);

	void clean();

	void approve(ReservationDto reservationDto);
}
