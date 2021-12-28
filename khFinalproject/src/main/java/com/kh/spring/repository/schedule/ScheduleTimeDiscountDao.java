package com.kh.spring.repository.schedule;

import java.util.List;

import com.kh.spring.entity.schedule.ScheduleTimeDiscountDto;

public interface ScheduleTimeDiscountDao {
	List<ScheduleTimeDiscountDto> list();
}
