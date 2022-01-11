package com.kh.spring.controller;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.entity.member.HistoryDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.repository.member.GradeDao;
import com.kh.spring.repository.member.HistoryDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.AgeDiscountDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.KakaoPayService;
import com.kh.spring.service.ReservationService;
import com.kh.spring.vo.KakaoPayApproveRequestVO;
import com.kh.spring.vo.KakaoPayApproveResponseVO;
import com.kh.spring.vo.KakaoPayCancelResponseVO;
import com.kh.spring.vo.KakaoPayReadyRequestVO;
import com.kh.spring.vo.KakaoPayReadyResponseVO;
import com.kh.spring.vo.KakaoPaySearchResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reservation")
public class ReservationController {
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	@Autowired
	private SeatDao seatDao;
	@Autowired
	private ReservationDetailDao reservationDetailDao;
	@Autowired
	private ReservationDao reservationDao;
	@Autowired
	private HallTypePriceDao hallTypePriceDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AgeDiscountDao ageDiscountDao;
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private KakaoPayService kakaoPayService;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private GradeDao gradeDao;
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private ReservationService reservationService;

	
		@RequestMapping("/")
		public String main(Model model,HttpSession session) {

			String memberEmail = (String)session.getAttribute("ses");
			int memberPoint = 0;
			if(memberEmail != null){				
				MemberDto memberDto = memberDao.get(memberEmail);
				memberPoint = memberDto.getMemberPoint();
			}
			
			model.addAttribute("memberEmail",memberEmail);
			model.addAttribute("memberPoint",memberPoint);
			return "reservation/main";
		}

		@RequestMapping("/direct")
		public String direct(Model model,HttpSession session,
				@RequestParam(required = false,defaultValue = "0") int scheduleTimeNo,
				@RequestParam(required = false,defaultValue = "0") int movieNo) {
			String memberEmail = (String)session.getAttribute("ses");
			int memberPoint = 0;
			if(memberEmail != null){				
				MemberDto memberDto = memberDao.get(memberEmail);
				memberPoint = memberDto.getMemberPoint();
			}
			LastInfoViewDto lastInfoViewDto = null;
			if(scheduleTimeNo != 0) {				
				lastInfoViewDao.get(scheduleTimeNo);
				model.addAttribute("lastInfoViewDto",lastInfoViewDto);
			}
			if(movieNo != 0) {				
				model.addAttribute("movieNo",movieNo);
			}
			model.addAttribute("memberEmail",memberEmail);
			model.addAttribute("memberPoint",memberPoint);
			return "reservation/main_direct";
		}
		
		@PostMapping("/confirm")
		public String confirm(@RequestParam int reservationNo,@RequestParam int memberPoint,HttpSession session) throws URISyntaxException {
			session.setAttribute("memberPoint", memberPoint);
			String memberEmail = (String)session.getAttribute("ses");
			KakaoPayReadyRequestVO requestVO = reservationService.getRequestVO(reservationNo,memberPoint,memberEmail);
			KakaoPayReadyResponseVO responseVO = kakaoPayService.ready(requestVO);

			session.setAttribute("partner_order_id", requestVO.getPartner_order_id());
			session.setAttribute("partner_user_id", requestVO.getPartner_user_id());
			session.setAttribute("tid", responseVO.getTid());
			
			return "redirect:"+responseVO.getNext_redirect_pc_url();
		}
		
		@GetMapping("/success")
		public String success(HttpSession session, @RequestParam String pg_token) throws URISyntaxException {
			//결제 승인 요청

			String partner_order_id = (String) session.getAttribute("partner_order_id");
			String partner_user_id = (String) session.getAttribute("partner_user_id");
			String tid = (String) session.getAttribute("tid");
			int memberPoint = (int)session.getAttribute("memberPoint");
			int memberNo = (int)session.getAttribute("memberNo");
			
			session.removeAttribute("partner_order_id");
			session.removeAttribute("partner_user_id");
			session.removeAttribute("tid");
			session.removeAttribute("memberPoint");
			
			int reservationNo = reservationService.getReservationNo(partner_order_id,partner_user_id,tid,pg_token,memberPoint,memberNo);

			return "redirect:success_result?reservationNo="+reservationNo;
		}
		
		@GetMapping("/success_result")
		public String successResult(
				@RequestParam int reservationNo,
				Model model
				) {
			ReservationDto reservationDto = reservationDao.get(reservationNo);
			ReservationInfoViewDto reservationInfoViewDto = reservationInfoViewDao.get(reservationDto.getScheduleTimeNo());
			HallDto hallDto = hallDao.get(reservationInfoViewDto.getHallNo());
			int resultAmount = (int) (reservationDto.getTotalAmount() - reservationDto.getPointUse());
			
			model.addAttribute("reservationDto",reservationDto);
			model.addAttribute("reservationInfoViewDto",reservationInfoViewDto);
			model.addAttribute("hallDto",hallDto);
			model.addAttribute("resultAmount",resultAmount);
			
			return "reservation/success_result";
		}
		
		@GetMapping("/history_detail")
		public String historyDetail(
				@RequestParam int reservationNo,
				Model model
				) throws URISyntaxException {
			ReservationDto reservationDto = reservationDao.get(reservationNo);
			List<ReservationDetailDto> rList = reservationDetailDao.get(reservationNo);
			KakaoPaySearchResponseVO responseVO = kakaoPayService.search(reservationDto.getTid());
			int resultAmount = (int) (reservationDto.getTotalAmount() - reservationDto.getPointUse());
			

			model.addAttribute("reservationDto",reservationDto);
			model.addAttribute("rList",rList);
			model.addAttribute("responseVO",responseVO);
			model.addAttribute("resultAmount",resultAmount);
			
			return "reservation/history_detail";
		}
		
		@GetMapping("/cancel")
		public String cancel(@RequestParam int reservationNo,HttpSession session) throws URISyntaxException {
			int memberNo = (int)session.getAttribute("memberNo");
			reservationService.cancel(reservationNo,memberNo);
			
//			return "redirect:history_detail";
			return "redirect:success_result?reservationNo="+reservationNo;
		}
		
}
