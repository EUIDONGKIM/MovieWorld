package com.kh.spring.repository.schedule;

import java.util.List;

import com.kh.spring.entity.schedule.ScheduleDto;

public interface ScheduleDao {

	void insert(ScheduleDto schedulDto);

	List<ScheduleDto> list();

	int getByMovieTheater(int movieNo, int theaterNo);
	
	List<ScheduleDto> list(int theaterNo);

	boolean delete(int scheduleNo);
	
	//상영 시작일 종료일 수정
	void edit(ScheduleDto schedulDto);
	
}
