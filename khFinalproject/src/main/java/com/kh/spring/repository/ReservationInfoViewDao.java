package com.kh.spring.repository;

import java.util.List;

import com.kh.spring.entity.ReservationInfoViewDto;
import com.kh.spring.vo.MovieCountVO;

public interface ReservationInfoViewDao {
	ReservationInfoViewDto get(int scheduleTimeNo);
	List<MovieCountVO> listMoiveByCount();
}
