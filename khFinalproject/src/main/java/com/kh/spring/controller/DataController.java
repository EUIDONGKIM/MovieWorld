package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
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
import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.board.ReviewDto;
import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.movie.VideoDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.actor.RoleDao;
import com.kh.spring.repository.actor.TotalRoleViewDao;
import com.kh.spring.repository.board.ReviewDao;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.movie.VideoDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.reservation.StatisticsInfoViewDao;
import com.kh.spring.repository.schedule.ScheduleDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.EmailService;
import com.kh.spring.service.ReservationService;
import com.kh.spring.service.ScheduleTimeService;
import com.kh.spring.vo.ChartTotalVO;
import com.kh.spring.vo.HallByScheduleTimeVO;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.ReplyVO;
import com.kh.spring.vo.ReservationVO;
import com.kh.spring.vo.ShowRealTimeVO;
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
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private StatisticsInfoViewDao statisticsInfoViewDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private TotalRoleViewDao totalRoleViewDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private ScheduleTimeService scheduleTimeService;
	
	
	
	@GetMapping("/watchedCheck")
	public String watchedCheck(
			@RequestParam int memberNo,
			@RequestParam int movieNo
			) {
		String check;
		MovieDto checkDto = statisticsInfoViewDao.getByNo(memberNo,movieNo);
		ReviewDto reviewDto = reviewDao.getByNo(memberNo,movieNo);

		if(checkDto==null) {
			check="NNNNN";
			return check;
		}
		else if(reviewDto != null) check="NNNNA";
		else check="NNNNO";
		
		return check;
	}

	
	@DeleteMapping("/self/deleteReply")
	public boolean deleteReply(@RequestParam int movieNo,@RequestParam int memberNo) {
		boolean result = reviewDao.delete(movieNo,memberNo);
		movieDao.refreshStar(movieNo);
		return result;
	}
	@PostMapping("/self/replyUpdate")
	public void replyUpdate(
			@RequestParam int memberNo,
			@RequestParam int movieNo,
			@RequestParam int reviewStarpoint,
			@RequestParam String reviewContent
			) {
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setMemberNo(memberNo);
		reviewDto.setMovieNo(movieNo);
		reviewDto.setReviewStarpoint(reviewStarpoint);
		reviewDto.setReviewContent(reviewContent);
		reviewDao.update(reviewDto);
		
		movieDao.refreshStar(movieNo);
		
	}
	
	@GetMapping("/loadPeopleReply")
	public List<ReplyVO> loadReply(
			@RequestParam int movieNo,
			@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "3") int size
			) {
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		return reviewDao.listByPage(movieNo, startRow, endRow);
	}
	
	
	
	//
	@GetMapping("/countByAgeForMoive")
	public ChartTotalVO countByAgeForMoive(@RequestParam int movieNo) {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("특정 영화에 따른 연령별 예매");
		vo.setLabel("연령");
		vo.setDataset(statisticsInfoViewDao.countByAgeForMoive(movieNo));
		return vo;
	}
	
	//
	@GetMapping("/countByGenderForMovie")
	public ChartTotalVO countByGenderForMovie(@RequestParam int movieNo) {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("특정 영화에 따른 성별별 예매");
		vo.setLabel("성별");
		vo.setDataset(statisticsInfoViewDao.countByGenderForMovie(movieNo));
		return vo;
	}
	
	@GetMapping("/actorList")
	public List<ActorDto> actorList() {
		return actorDao.list();
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
	public List<ShowRealTimeVO> getTotal4(@RequestParam int movieNo,
			@RequestParam int theaterNo,
			@RequestParam String scheduleTimeDate){
		List<ShowRealTimeVO> list = scheduleTimeService.getList(movieNo,theaterNo,scheduleTimeDate);		
		return list;
	}
	
	@GetMapping("/getTotal5")
	public HallDto getTotal5(@RequestParam int scheduleTimeNo){
		ScheduleTimeDto scheduleTimeDto = scheduleTimeDao.get(scheduleTimeNo);

		return hallDao.get(scheduleTimeDto.getHallNo());
	}

	
	
	
	@GetMapping("/getTheaters")
	public List<TheaterDto> getTheaters(String city) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.

		return theaterDao.listByCity2(cityName);
	}
	

}