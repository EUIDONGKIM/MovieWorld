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
	public void setSeatandUpdateHall(List<SeatDto> seatList, int hallNo) {

		int count = 0;
		for(SeatDto seatDto : seatList) {
			seatDto.setHallNo(hallNo);
			seatDao.insert(seatDto);
			
			if(seatDto.getSeatStatus().contains("normal")) {
				count++;
			}
		}
		
		//hall에 총 좌석수를 업데이트 해준다.
		hallDao.update(hallNo,count);
	}

}
