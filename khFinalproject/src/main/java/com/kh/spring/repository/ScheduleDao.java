package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ScheduleDto;

public interface ScheduleDao {

	void insert(ScheduleDto schedulDto);

	List<ScheduleDto> list();

	int getByMovieTheater(int movieNo, int theaterNo);

}
