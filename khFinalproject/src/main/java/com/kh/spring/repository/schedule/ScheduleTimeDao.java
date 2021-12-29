package com.kh.spring.repository.schedule;

import java.util.List;

import com.kh.spring.entity.schedule.ScheduleTimeDto;

public interface ScheduleTimeDao {

	void insert(ScheduleTimeDto scheduleTimeDto);

	List<String> dateList(int scheduleNo);


	List<ScheduleTimeDto> listByDate(int scheduleNo, String scheduleTimeDate);

	ScheduleTimeDto get(int scheduleTimeNo);

	void reservationUpdate(ScheduleTimeDto scheduleTimeDto);

	}
