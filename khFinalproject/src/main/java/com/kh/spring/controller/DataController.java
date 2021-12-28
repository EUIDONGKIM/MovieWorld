package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.ActorDto;
import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.ReservationDetailDto;
import com.kh.spring.entity.RoleDto;
import com.kh.spring.entity.ScheduleTimeDto;
import com.kh.spring.entity.SeatDto;
import com.kh.spring.entity.TheaterDto;
import com.kh.spring.entity.VideoDto;
import com.kh.spring.repository.ActorDao;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.ReservationDetailDao;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.RoleDao;
import com.kh.spring.repository.ScheduleDao;
import com.kh.spring.repository.ScheduleTimeDao;
import com.kh.spring.repository.SeatDao;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.repository.VideoDao;
import com.kh.spring.service.ReservationService;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.ReservationVO;
import com.kh.spring.vo.TheaterCityVO;
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
	@Autowired
	private ActorDao actorDao;
	@Autowired
	private VideoDao videoDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private ReservationService reservationService;
	
	@PostMapping("/TempReservation")
	public void TempReservation(
			@RequestParam String seatData,
			@RequestParam int scheduleTimeNo,
			@RequestParam int ageNormal,
			@RequestParam int ageYoung,
			@RequestParam int ageOld,
			HttpSession session
			) {
		int memberNo = (int)session.getAttribute("memberNo");
		reservationService.insert(seatData,scheduleTimeNo,ageNormal,ageYoung,ageOld,memberNo);
	}
	
	@PostMapping("/addVideo")
	public void addVideo(
			@RequestParam int movieNo,
			@RequestParam String videoTitle,
			@RequestParam String videoRoot
			) {
		
		VideoDto videoDto = new VideoDto();
		videoDto.setMovieNo(movieNo);
		videoDto.setVideoTitle(videoTitle);
		videoDto.setVideoRoot(videoRoot);
		
		videoDao.insert(videoDto);
	}
	
	@GetMapping("/actorList")
	public List<ActorDto> actorList() {
		return actorDao.list();
	}
	
	@PostMapping("/addRole")
	public void addRole(
			@RequestParam int movieNo,
			@RequestParam int actorNo,
			@RequestParam String roleType,
			@RequestParam String roleName
			) {
		RoleDto roleDto = new RoleDto();
		roleDto.setActorNo(actorNo);
		roleDto.setMovieNo(movieNo);
		roleDto.setRoleName(roleName);
		roleDto.setRoleType(roleType);
		
		roleDao.insert(roleDto);
	}
	
	@GetMapping("/getHalls")
	public List<TheaterDto> getHalls(@RequestParam String city) throws UnsupportedEncodingException {
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.
		
		return theaterDao.listByCity(cityName);
	}
	
	@GetMapping("/getMovie")
	public List<MovieCountVO> getMovie(){
		return reservationInfoViewDao.listMoiveByCount();
	}
	
	@GetMapping("/getSido")
	public List<TheaterCityVO> getSido(){
		return theaterDao.cityList();
	}
	
	@GetMapping("/getTotal11")
	public List<MovieCountVO> getTotal11(
			@RequestParam String theaterSido,
			@RequestParam int theaterNo) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(theaterSido, "UTF-8");
		return reservationInfoViewDao.listMoiveComplexSearch(cityName,theaterNo);
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
		return reservationService.getSeatVOList(scheduleTimeNo);
	}
	
	
	@GetMapping("/getTheaters")
	public List<TheaterDto> getTheaters(String city) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.

		return theaterDao.listByCity2(cityName);
	}
}