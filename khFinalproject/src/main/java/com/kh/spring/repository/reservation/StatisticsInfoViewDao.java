package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.vo.ChartVO;

public interface StatisticsInfoViewDao {

	List<ChartVO> countByReservation();

	List<ChartVO> countByGenderForMovie();

	List<ChartVO> countByGenderForTotal();

	List<ChartVO> countByAgeForMoive();

	List<ChartVO> countByAgeForTotal();

	List<ChartVO> totalReservationByTheater();

	List<ChartVO> countByGradeReservation();

	List<ChartVO> countReservationBySido();

}
