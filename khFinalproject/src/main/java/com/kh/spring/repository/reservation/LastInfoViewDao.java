package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.vo.ChartVO;

public interface LastInfoViewDao {

	List<LastInfoViewDto> getByTheaterAndDate(int theaterNo, String day);

	List<Integer> getMovieNo(int theaterNo, String day);

	List<LastInfoViewDto> listByMoiveNoForMap(int theaterNo, String day, int movieNo);

	List<Integer> hallNoList(int theaterNo, String day, int movieNo);

	List<LastInfoViewDto> listByhallNoForMap(int theaterNo, String day, int movieNo, int hallNo);

	LastInfoViewDto get(int scheduleTimeNo);

	List<ChartVO> countByTotal();

	List<ChartVO> countByProfit();

	List<ChartVO> totalPeopleByTheater();

	List<ChartVO> totalProfitByTheater();

}
