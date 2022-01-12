package com.kh.spring.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.board.ReviewDto;
import com.kh.spring.entity.member.CertificationDto;
import com.kh.spring.entity.member.HistoryDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.repository.board.ReviewDao;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.repository.member.HistoryDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.service.EmailService;
import com.kh.spring.service.MovieService;
import com.kh.spring.service.ReservationService;
import com.kh.spring.vo.MyMovieLikeVO;
import com.kh.spring.vo.ReplyVO;
import com.kh.spring.vo.ReservationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/member")
public class MemberDataCotroller {
	
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertificationDao certificationDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private ReservationDao reservationDao;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private ReservationDetailDao reservationDetailDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private MovieDao movieDao;
	@GetMapping("/idcheck")
	public String idCheck(@RequestParam String memberEmail) {
		MemberDto memberDto = memberDao.get(memberEmail);
		if(memberDto == null) {//null이면 이메일 사용 가능
			return "gogo"; //이거 이용해서 맛있게 드세요
		}
		else {// 사용 불가능
			return "nono";
		}
	}
	
	@GetMapping("/nickCheck")
	public String nickCheck(@RequestParam String memberNick) {
		MemberDto memberDto = memberDao.get3(memberNick);
		if(memberDto == null) { //사용가능
			return "gogogo";
		}else { //사용 불가능
			return "nonono";
		}
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
	
	@GetMapping("/pwCheck")
	public String pwCheck(@RequestParam String to,HttpSession session) {
		String memberEmail = (String)session.getAttribute("ses");
		MemberDto findDto = memberDao.get4(memberEmail,to);
		
		if(findDto !=null) {
			return "gogo";
		}else {
			return "nono";
		}
	}
	
	@PostMapping("/emailSend")
	public void emailSend(@RequestParam String to) throws MessagingException {
		emailService.sendCertificationNumber(to);
	}
	@PostMapping("/emailSend2")
	@ResponseBody
	public int emailSend2(@RequestParam String to) throws MessagingException {
		emailService.examPw(to);
		return 0;
	}
	
	
	//더보기(페이지네이션)
	@GetMapping("/historyMore")
	public List<HistoryDto> historyMore(HttpSession session,
			@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "5") int size) {
		String memberEmail = (String)session.getAttribute("ses");		
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		return historyDao.listByPage(memberEmail, startRow, endRow);
	}
	
	@GetMapping("ReservationHistoryListMore")
	public List<ReservationDto> ReservationHistoryListMore(HttpSession session,
		@RequestParam(required = false, defaultValue = "1") int page, 
		@RequestParam(required = false, defaultValue = "5") int size){
		int memberNo = (int)session.getAttribute("memberNo");
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		return reservationDao.listByPage(memberNo, startRow, endRow);
	}
	
	@GetMapping("/movieLikeListMore")
	public List<MyMovieLikeVO> movieLikeList(HttpSession session,
		@RequestParam(required = false, defaultValue = "1") int page, 
		@RequestParam(required = false, defaultValue = "5") int size){
		int memberNo = (int)session.getAttribute("memberNo");
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		return movieService.myMovieLikeList(memberNo, startRow, endRow);
		
	}
	
	@GetMapping("/seat")
	public List<ReservationVO> getSeat(@RequestParam int scheduleTimeNo) {
		return reservationService.getSeatVOList(scheduleTimeNo);
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
		movieDao.refreshStar(movieNo);
	}
	@GetMapping("/loadReply")
	public List<ReplyVO> loadPeopleReply(
			@RequestParam int movieNo
			) {
		return reviewDao.list(movieNo);
	}
	
	@PostMapping("/addReplylike")
	public void addReplylike(
			@RequestParam int memberNo,
			@RequestParam int movieNo
			) {
		reviewDao.replyLike(memberNo,movieNo);
	}
}
