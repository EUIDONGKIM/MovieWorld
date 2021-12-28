package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.ReservationDetailDto;

public interface ReservationDetailDao {

	List<ReservationDetailDto> list(int scheduleTimeNo);

	void insert(ReservationDetailDto reservationDetailDto);

}
