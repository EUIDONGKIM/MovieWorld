package com.kh.spring.repository.schedule;

import java.util.List;

import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.vo.HallByScheduleTimeVO;

public interface ScheduleTimeDao {

	void insert(ScheduleTimeDto scheduleTimeDto);

	List<String> dateList(int scheduleNo);


	List<HallByScheduleTimeVO> listByDate(int scheduleNo, String scheduleTimeDate);

	ScheduleTimeDto get(int scheduleTimeNo);

	void reservationUpdate(ScheduleTimeDto scheduleTimeDto);

	void reservationMinusUpdate(ScheduleTimeDto scheduleTimeDto);

	boolean delete(int scheduleTimeNo);

	boolean edit(ScheduleTimeDto scheduleTimeDto);

	int getTheaterNo(int scheduleTimeNo);

	boolean isScheduleTimeExist(int hallNo);
}
