package com.kh.spring.service;

import java.util.List;

import com.kh.spring.entity.SeatDto;

public interface SeatService {

	void setSeatandUpdateHall(List<SeatDto> seatList, int hallNo);

}
