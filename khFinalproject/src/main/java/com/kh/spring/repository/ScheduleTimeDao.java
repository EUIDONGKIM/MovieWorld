package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ScheduleTimeDto;

public interface ScheduleTimeDao {

	void insert(ScheduleTimeDto scheduleTimeDto);

	List<String> dateList(int scheduleNo);


	List<ScheduleTimeDto> listByDate(int scheduleNo, String scheduleTimeDate);

	ScheduleTimeDto get(int scheduleTimeNo);

	}
