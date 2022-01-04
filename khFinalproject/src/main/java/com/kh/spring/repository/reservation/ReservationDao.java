package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.ReservationDto;

public interface ReservationDao {
	int getSequence();

	void insert(ReservationDto reservationDto);

	ReservationDto get(int reservationNo);

	void updatePrice(int reservationNo, int totalReservationPice);

	boolean remove(int reservationNo);

	void clean();

	void approve(ReservationDto reservationDto);

	void cancel(int reservationNo);
	
	List<ReservationDto> list(int memberNo);
	
	List<ReservationDto> listByPage(int startRow, int endRow);
}
