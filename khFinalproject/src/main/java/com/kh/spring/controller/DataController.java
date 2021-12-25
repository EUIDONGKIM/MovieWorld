package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.ReservationDetailDto;
import com.kh.spring.entity.ReservationInfoViewDto;
import com.kh.spring.entity.ScheduleTimeDto;
import com.kh.spring.entity.SeatDto;
import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.ReservationDetailDao;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.ScheduleDao;
import com.kh.spring.repository.ScheduleTimeDao;
import com.kh.spring.repository.SeatDao;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.vo.ReservationVO;
import com.kh.spring.vo.TheaterNameBySidoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/data")
public class DataController {
	
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private ScheduleDao scheduleDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private SeatDao seatDao;
	@Autowired
	private ReservationDetailDao reservationDetailDao;
	
	
	
	@GetMapping("/getHalls")
	public List<TheaterDto> getHalls(@RequestParam String city) throws UnsupportedEncodingException {
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.
		
		return theaterDao.listByCity(cityName);
	}
	
	@GetMapping("/getTotal")
	public List<TheaterDto> getTotal1(@RequestParam String theaterSido) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(theaterSido, "UTF-8");
		
		return theaterDao.listByCity2(cityName);
	}
	
	@GetMapping("/getTotal1")
	public List<String> getTotal2(@RequestParam int movieNo){
		return reservationInfoViewDao.listSidoByMovie(movieNo);
	}

	@GetMapping("/getTotal2")
	public List<TheaterNameBySidoVO> getTotal2(@RequestParam int movieNo,@RequestParam String theaterSido) throws UnsupportedEncodingException{
		String theaterSidoName = URLDecoder.decode(theaterSido, "UTF-8");
		
		return reservationInfoViewDao.getTheaterNames(movieNo,theaterSidoName);
	}

	@GetMapping("/getTotal3")
	public List<String> getTotal3(@RequestParam int movieNo,@RequestParam int theaterNo){
		int scheduleNo = scheduleDao.getByMovieTheater(movieNo,theaterNo);
		return scheduleTimeDao.dateList(scheduleNo);
	}

	@GetMapping("/getTotal4")
	public List<ScheduleTimeDto> getTotal4(@RequestParam int movieNo,
			@RequestParam int theaterNo,
			@RequestParam String scheduleTimeDate){
		int scheduleNo = scheduleDao.getByMovieTheater(movieNo,theaterNo);

		return scheduleTimeDao.listByDate(scheduleNo,scheduleTimeDate);
	}
	
	@GetMapping("/getTotal5")
	public HallDto getTotal5(@RequestParam int scheduleTimeNo){
		ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);

		return hallDao.get(scheduleTimeDto.getHallNo());
	}
	
	@GetMapping("/seat")
	public List<ReservationVO> getSeat(@RequestParam int scheduleTimeNo) {
		//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
		
		ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);

		List<SeatDto> seatList = seatDao.list(scheduleTimeDto.getHallNo());
		List<ReservationDetailDto> reservationDetailList = reservationDetailDao.list(scheduleTimeNo);

		List<ReservationVO> reservationVOList = new ArrayList<>();
		
		for(SeatDto seatDto : seatList) {
			ReservationVO reservationVO = new ReservationVO();
			
			reservationVO.setSeatNo(seatDto.getSeatNo());
			reservationVO.setSeatRows(seatDto.getSeatRows());
			reservationVO.setSeatCols(seatDto.getSeatCols());
			reservationVO.setSeatStatus(seatDto.getSeatStatus());
			
			if(!reservationDetailList.isEmpty()) {		
				for(ReservationDetailDto reservationDetailDto : reservationDetailList) {
					if(seatDto.getSeatNo() == reservationDetailDto.getSeatNo()) {
						reservationVO.setSeatStatus("disabled");
						break;
					}
				}
			}
			
			
			reservationVOList.add(reservationVO);
		}
		

		log.debug("reservationVOList는!!==========================={}",reservationVOList);
		
		//여기서 VO만드는 작업해서 VO를 넘긴다.
		return reservationVOList;
	}
	
	
	
	
	@GetMapping("/getTheaters")
	public List<TheaterDto> getTheaters(String city) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.

		return theaterDao.listByCity2(cityName);
	}
}
