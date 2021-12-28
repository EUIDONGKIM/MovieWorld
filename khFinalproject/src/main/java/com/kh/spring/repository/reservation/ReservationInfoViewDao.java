package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.TheaterNameBySidoVO;

public interface ReservationInfoViewDao {
	ReservationInfoViewDto get(int scheduleTimeNo);
	List<MovieCountVO> listMoiveByCount();
	List<String> listSidoByMovie(int movieNo);
	List<TheaterNameBySidoVO> getTheaterNames(int movieNo, String theaterSido);
	List<MovieCountVO> listMoiveComplexSearch(String theaterSido, int theaterNo);
}
