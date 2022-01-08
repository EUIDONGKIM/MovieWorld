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
	
	@PostMapping("/addReplylike")
	public void addReplylike(
			@RequestParam int memberNo,
			@RequestParam int movieNo
			) {
		reviewDao.replyLike(memberNo,movieNo);
	}
	
	@DeleteMapping("/deleteReply")
	public boolean deleteReply(@RequestParam int movieNo,@RequestParam int memberNo) {
		return reviewDao.delete(movieNo,memberNo);
	}
	@PostMapping("/replyUpdate")
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
	}
	@GetMapping("/loadReply")
	public List<ReplyVO> loadReply(
			@RequestParam int movieNo
			) {
		return reviewDao.list(movieNo);
	}
	@PostMapping("/replyInsert")
	public void replyInsert(
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
		reviewDao.insert(reviewDto);
	}
	@DeleteMapping("/deleteVideo")
	public boolean deleteVideo(@RequestParam int videoNo) {
		return videoDao.delete(videoNo);
	}
	@DeleteMapping("/deleteStaff")
	public boolean deleteStaff(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@DeleteMapping("/deleteActor")
	public boolean deleteActor(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@DeleteMapping("/deleteDirector")
	public boolean deleteDirector(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@GetMapping("/getVideo")
	public List<VideoDto> getVideo(@RequestParam int movieNo) {
		return videoDao.listByMovie(movieNo);
	}
	@GetMapping("/getStaff")
	public List<TotalRoleViewDto> getStaff(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"staff");
	}
	@GetMapping("/getActor")
	public List<TotalRoleViewDto> getActor(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"actor");
	}
	@GetMapping("/getDirector")
	public List<TotalRoleViewDto> getDirector(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"director");
	}
	
	@GetMapping("/countPeopleBySido")
	public ChartTotalVO countPeopleBySido() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("지역별 관람객 수 현황");
		vo.setLabel("관람객수");
		vo.setDataset(lastInfoViewDao.countPeopleBySido());
		return vo;
	}
	
	@GetMapping("/countReservationBySido")
	public ChartTotalVO countReservationBySido() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("지역별 예매수 현황");
		vo.setLabel("예매수");
		vo.setDataset(statisticsInfoViewDao.countReservationBySido());
		return vo;
	}
	
	@GetMapping("/countMemberjoinByYear")
	public ChartTotalVO countMemberjoinByYear() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("년도별 가입자수 현황");
		vo.setLabel("가입자수");
		vo.setDataset(memberDao.countMemberjoinByYear());
		return vo;
	}
	
	@GetMapping("/countMemberjoinByYearMonth")
	public ChartTotalVO countMemberjoinByYearMonth() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("월별 가입자수 현황");
		vo.setLabel("가입자수");
		vo.setDataset(memberDao.countMemberjoinByYearMonth());
		return vo;
	}

	@GetMapping("/countByGradeTotal")
	public ChartTotalVO countByGradeTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 인원 현황");
		vo.setLabel("등급");
		vo.setDataset(memberDao.countByGradeTotal());
		return vo;
	}
	
	@GetMapping("/countByGradeReservation")
	public ChartTotalVO countByGradeReservation() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 예매율 현황");
		vo.setLabel("등급");
		vo.setDataset(statisticsInfoViewDao.countByGradeReservation());
		return vo;
	}
	
	@GetMapping("/countByGradePoint")
	public ChartTotalVO countByGradePoint() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("등급별 포인트 현황");
		vo.setLabel("등급");
		vo.setDataset(memberDao.countByGradePoint());
		return vo;
	}
	
	@GetMapping("/totalPeopleByTheater")
	public ChartTotalVO totalPeopleByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("인원수에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(lastInfoViewDao.totalPeopleByTheater());
		return vo;
	}
	
	@GetMapping("/totalProfitByTheater")
	public ChartTotalVO totalProfitByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("총 매출에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(lastInfoViewDao.totalProfitByTheater());
		return vo;
	}
	
	@GetMapping("/totalReservationByTheater")
	public ChartTotalVO totalReservationByTheater() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("예매수에 따른 극장별 예매");
		vo.setLabel("극장명");
		vo.setDataset(statisticsInfoViewDao.totalReservationByTheater());
		return vo;
	}
	
	@GetMapping("/countByAgeForMoive")
	public ChartTotalVO countByAgeForMoive(@RequestParam int movieNo) {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("특정 영화에 따른 연령별 예매");
		vo.setLabel("연령");
		vo.setDataset(statisticsInfoViewDao.countByAgeForMoive(movieNo));
		return vo;
	}
	
	@GetMapping("/countByAgeForTotal")
	public ChartTotalVO countByAgeForTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("전체 영화에 따른 연령별 예매");
		vo.setLabel("연령");
		vo.setDataset(statisticsInfoViewDao.countByAgeForTotal());
		return vo;
	}
	
	@GetMapping("/countByGenderForTotal")
	public ChartTotalVO countByGenderForTotal() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("전체 영화에 따른 성별별 예매");
		vo.setLabel("성별");
		vo.setDataset(statisticsInfoViewDao.countByGenderForTotal());
		return vo;
	}
	
	@GetMapping("/countByGenderForMovie")
	public ChartTotalVO countByGenderForMovie(@RequestParam int movieNo) {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("특정 영화에 따른 성별별 예매");
		vo.setLabel("성별");
		vo.setDataset(statisticsInfoViewDao.countByGenderForMovie(movieNo));
		return vo;
	}

	@GetMapping("/totalProfit")
	public ChartTotalVO totalProfit() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 수익");
		vo.setLabel("수익");
		vo.setDataset(lastInfoViewDao.countByProfit());
		return vo;
	}
	
	@GetMapping("/totalReservation")
	public ChartTotalVO totalReservation() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 예매순위");
		vo.setLabel("예매수");
		vo.setDataset(statisticsInfoViewDao.countByReservation());
		return vo;
	}
	
	@GetMapping("/totalPeople")
	public ChartTotalVO totalPeople() {
		ChartTotalVO vo = new ChartTotalVO();
		vo.setTitle("영화별 총 관람객");
		vo.setLabel("관람객 수");
		vo.setDataset(lastInfoViewDao.countByTotal());
		return vo;
	}
	
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
	public List<ShowRealTimeVO> getTotal4(@RequestParam int movieNo,
			@RequestParam int theaterNo,
			@RequestParam String scheduleTimeDate){
		int scheduleNo = scheduleDao.getByMovieTheater(movieNo,theaterNo);

		List<ShowRealTimeVO> list = new ArrayList<>();
		List<HallByScheduleTimeVO> tempList = scheduleTimeDao.listByDate(scheduleNo,scheduleTimeDate);
		

		for(HallByScheduleTimeVO vo : tempList) {
			ShowRealTimeVO showRealTimeVO = new ShowRealTimeVO();
			
			showRealTimeVO.setHallNo(vo.getHallNo());
			showRealTimeVO.setHallType(vo.getHallType());
			showRealTimeVO.setHallName(vo.getHallName());
			showRealTimeVO.setHallSeat(vo.getHallSeat());
			showRealTimeVO.setScheduleTimeNo(vo.getScheduleTimeNo());
			showRealTimeVO.setScheduleNo(vo.getScheduleNo());
			showRealTimeVO.setScheduleTimeDateTime(vo.getScheduleTimeDateTime());
			showRealTimeVO.setScheduleTimeDiscountType(vo.getScheduleTimeDiscountType());
			
			int disabledSeat = reservationService.getSeatRest(vo.getScheduleTimeNo());
			showRealTimeVO.setDisabledSeat(disabledSeat);
			
			list.add(showRealTimeVO);
		}
				
		return list;
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