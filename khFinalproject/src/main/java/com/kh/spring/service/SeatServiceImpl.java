package com.kh.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.SeatDto;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.SeatDao;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SeatServiceImpl implements SeatService{
	
	@Autowired
	private HallDao hallDao;
	@Autowired
	private SeatDao seatDao;
	
	@Override
	public void setSeatandUpdateHall(List<String> seat, int hallNo) {
		int hallSeat = 0;
		
		//해당 hallNo의 seat을 차례대로 등록해준다
		for(String seatName : seat) {
			if(seatName.contains("normal")) {
			SeatDto seatDto = new SeatDto();
			seatDto.setHallNo(hallNo);
			seatDto.setSeatName(seatName);
			seatDao.insert(seatDto);
			hallSeat++;
			}
		}
		
		//hall에 총 좌석수를 업데이트 해준다.
		hallDao.update(hallNo,hallSeat);
	}

}
