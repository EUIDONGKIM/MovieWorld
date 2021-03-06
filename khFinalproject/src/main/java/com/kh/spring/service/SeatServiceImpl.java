package com.kh.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.theater.SeatDto;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.SeatDao;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SeatServiceImpl implements SeatService{
	
	@Autowired
	private HallDao hallDao;
	@Autowired
	private SeatDao seatDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	
	@Override
	public void setSeatandUpdateHall(List<SeatDto> seatList, int hallNo) {
		
		if(scheduleTimeDao.isScheduleTimeExist(hallNo)) { //해당 상영관에 상영 스케줄이 없어야 좌석을 만듦 
			seatDao.delete(hallNo); //일단 좌석 삭제하고 다시 생성

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
}
