package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ScheduleDto;

public interface ScheduleDao {

	void insert(ScheduleDto schedulDto);

	List<ScheduleDto> list();

	int getByMovieTheater(int movieNo, int theaterNo);
	
	List<ScheduleDto> list(int theaterNo);

	boolean delete(int scheduleNo);
	
	//상영 시작일 종료일 수정
	boolean edit(ScheduleDto schedulDto);
}
