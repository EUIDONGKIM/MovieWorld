package com.kh.spring.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.member.CertificationDto;
import com.kh.spring.entity.member.HistoryDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.repository.member.HistoryDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.service.EmailService;

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
		String memberEmail = (String)session.getAttribute("ses");		int endRow = page * size;
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
	
	
}
