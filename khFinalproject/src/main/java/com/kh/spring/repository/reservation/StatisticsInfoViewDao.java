package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.vo.ChartVO;

public interface StatisticsInfoViewDao {

	List<ChartVO> countByReservation();

	List<ChartVO> countByGenderForMovie(int movieNo);

	List<ChartVO> countByGenderForTotal();

	List<ChartVO> countByAgeForMoive(int movieNo);

	List<ChartVO> countByAgeForTotal();

	List<ChartVO> totalReservationByTheater();

	List<ChartVO> countByGradeReservation();

	List<ChartVO> countReservationBySido();
	
	List<String> movieTitleBymemberNo(int memberNo);

	List<ChartVO> countForReservationRatio();

	MovieDto getByNo(int memberNo, int movieNo);

}
