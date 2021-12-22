package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ReservationInfoViewDto;

public interface ReservationInfoViewDao {
	ReservationInfoViewDto get(int scheduleTimeNo);
}
