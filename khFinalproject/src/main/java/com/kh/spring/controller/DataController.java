package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.RoleDto;
import com.kh.spring.entity.member.CertificationDto;
import com.kh.spring.entity.movie.VideoDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.actor.RoleDao;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.repository.movie.VideoDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.schedule.ScheduleDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.EmailService;
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
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertificationDao certificationDao;
	@Autowired
	private ReservationDao reservationDao;
	
	@DeleteMapping("/cancelTempReservation")
	public boolean cancelTempReservation(@RequestParam int reservationNo) {
		return reservationService.remove(reservationNo);
	}
	
	@GetMapping("/getReservation")
	public ReservationDto getReservation(@RequestParam int reservationKey) {
		return reservationDao.get(reservationKey);
	}
	
	@GetMapping("/getReservationDetail")
	public List<ReservationDetailDto> getReservationDetail(@RequestParam int reservationKey) {
		return reservationDetailDao.get(reservationKey);
	}
	
	@GetMapping("/getReservationKey")
	public int getReservationKey() {
		return reservationDao.getSequence();
	}
	
	@GetMapping("/serialCheck")
	public String serialCheck(@RequestParam String to,@RequestParam String check) {
		CertificationDto certificationDto = new CertificationDto();
		certificationDto.setMemberEmail(to);
		certificationDto.setSerial(check);
		String result = "NNNNN";
		if(certificationDao.check(certificationDto)) result = "NNNNO";
		else result = "NNNNN";
		return result;
	}
	
	@PostMapping("/emailSend")
	public void emailSend(@RequestParam String to) {
		emailService.sendCertificationNumber(to);
	}
	
	@PostMapping("/TempReservation")
	public void TempReservation(
			@RequestParam String seatData,
			@RequestParam int reservationKey,
			@RequestParam int scheduleTimeNo,
			@RequestParam(required = false,defaultValue = "0") int ageNormal,
			@RequestParam(required = false,defaultValue = "0") int ageYoung,
			@RequestParam(required = false,defaultValue = "0") int ageOld,
			HttpSession session
			) {
		int memberNo = (int)session.getAttribute("memberNo");
		reservationService.insert(seatData,reservationKey,scheduleTimeNo,ageNormal,ageYoung,ageOld,memberNo);
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
			@RequestParam int actorNo
			) {
		RoleDto roleDto = new RoleDto();
		roleDto.setActorNo(actorNo);
		roleDto.setMovieNo(movieNo);
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