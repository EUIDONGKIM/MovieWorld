package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ReservationDetailDto;

public interface ReservationDetailDao {

	List<ReservationDetailDto> list(int scheduleTimeNo);

}
