package com.kh.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;

@Service
public class HallServiceImpl implements HallService{

	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private HallDao hallDao;
	
	@Override
	public void edit(HallDto hallDto) {
		if(scheduleTimeDao.isScheduleTimeExist(hallDto.getHallNo())) {
			hallDao.edit(hallDto);
		}
	}

	@Override
	public void delete(int hallNo) {
		if(scheduleTimeDao.isScheduleTimeExist(hallNo)) {
			hallDao.delete(hallNo);
		}
	}

}
