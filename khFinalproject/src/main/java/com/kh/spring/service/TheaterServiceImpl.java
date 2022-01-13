package com.kh.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.repository.theater.TheaterDao;

@Service
public class TheaterServiceImpl implements TheaterService{
	
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	
	@Autowired
	private TheaterDao theaterDao;

	@Override
	public void editTheater(TheaterDto theaterDto) {
		if(reservationInfoViewDao.getByTheater(theaterDto.getTheaterNo()).isEmpty()) {
			theaterDao.edit(theaterDto);
		}
		else {
			theaterDao.editInfo(theaterDto);
		}
	}

	@Override
	public boolean deleteTheater(int theaterNo) {
		if(reservationInfoViewDao.getByTheater(theaterNo).isEmpty()) {
			theaterDao.delete(theaterNo);
			return true;
		}
		else {
			return false;
		}
	}


}
