package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.RtestDto;

public interface RtestDao {

	List<RtestDto> list(int scheduleTimeNo);

}
