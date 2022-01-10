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
import com.kh.spring.vo.KakaoPayApproveRequestVO;
import com.kh.spring.vo.KakaoPayApproveResponseVO;
import com.kh.spring.vo.KakaoPayCancelResponseVO;
import com.kh.spring.vo.KakaoPayReadyRequestVO;
import com.kh.spring.vo.KakaoPayReadyResponseVO;
import com.kh.spring.vo.KakaoPaySearchResponseVO;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.TheaterCityVO;

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
			
			ReservationDto reservationDto = reservationDao.get(reservationNo);
			List<ReservationDetailDto> rList = reservationDetailDao.get(reservationNo);
			
			String item_name = String.valueOf(rList.get(0).getSeatRows())+"행"+
					String.valueOf(rList.get(0).getSeatCols())+"열";

			if(rList.size()>1)
			item_name += " 외 "+(rList.size()-1)+"건";
			
			long total = (long)(reservationDto.getTotalAmount()-memberPoint);
			
			KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
			requestVO.setPartner_order_id(String.valueOf(reservationDto.getReservationNo()));
			requestVO.setPartner_user_id((String)session.getAttribute("ses"));
			requestVO.setItem_name(item_name);
			requestVO.setQuantity(1);
			requestVO.setTotal_amount(total);
			
			
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
			
			session.removeAttribute("partner_order_id");
			session.removeAttribute("partner_user_id");
			session.removeAttribute("tid");
			session.removeAttribute("memberPoint");
			
			KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
			requestVO.setTid(tid);
			requestVO.setPartner_order_id(partner_order_id);
			requestVO.setPartner_user_id(partner_user_id);
			requestVO.setPg_token(pg_token);
			
			KakaoPayApproveResponseVO responseVO = kakaoPayService.approve(requestVO);
			
			//결제가 완료된 시점에 update시행
			ReservationDto reservationDto = reservationDao.get(Integer.parseInt(partner_order_id));
			reservationDto.setTid(tid);
			reservationDto.setItemName(responseVO.getItem_name());
			reservationDto.setReservationStatus("결제완료");
			reservationDto.setPointUse(memberPoint);
			
			reservationDao.approve(reservationDto);
			reservationDetailDao.approve(reservationDto.getReservationNo());
			
			//모두 완료되면 해당 회차의 총 인원과 총 금액을 업데이트 시켜준다. / 포인트 사용내역
			ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
			scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
			scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
			scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
			scheduleTimeDao.reservationUpdate(scheduleTimeDto);
			
			
			int memberNo = (int)session.getAttribute("memberNo");
			memberDao.usePoint(memberNo,memberPoint);
			MemberDto memberDto = memberDao.get2(memberNo);
			HistoryDto historyDto =new HistoryDto();
			//예매시 포인트 사용 
			historyDto.setMemberEmail(memberDto.getMemberEmail());
			historyDto.setHistoryAmount(memberPoint);
			historyDto.setHistoryMemo("포인트 사용");
			historyDao.insert(historyDto);
			
			int pointPercent = gradeDao.get(memberDto.getMemberGrade());
			
			int pointByPay = ((int)reservationDto.getTotalAmount() - memberPoint) * pointPercent / 100;
			memberDao.returnPoint(memberNo, pointByPay);
			//예매시 포인트 적립
			historyDto.setMemberEmail(memberDto.getMemberEmail());
			historyDto.setHistoryAmount(pointByPay);
			historyDto.setHistoryMemo("포인트 적립");
			historyDao.insert(historyDto);
			return "redirect:success_result?reservationNo="+reservationDto.getReservationNo();
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
		public String cancel(@RequestParam int reservationNo, RedirectAttributes attr,HttpSession session) throws URISyntaxException {
			//(1)
			ReservationDto reservationDto = reservationDao.get(reservationNo);

			//(2) 취소 가능한 금액을 계산해야 한다
			long amount = (reservationDto.getTotalAmount()-reservationDto.getPointUse());

			//(3) 취소 처리를 수행한다
			KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(reservationDto.getTid(), amount);

			//(4) DB를 갱신
			reservationDao.cancel(reservationNo);
			reservationDetailDao.cancel(reservationNo);

			//(5) 상영회차의 금액 변경(통계 차감)
			ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
			scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
			scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
			scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
			scheduleTimeDao.reservationMinusUpdate(scheduleTimeDto);
			
			int memberNo = (int)session.getAttribute("memberNo");
			memberDao.returnPoint(memberNo,reservationDto.getPointUse());
			//예매 취소시 포인트 취소
			HistoryDto historyDto = new HistoryDto();
			MemberDto memberDto = memberDao.get2(memberNo);
			historyDto.setMemberEmail(memberDto.getMemberEmail());
			historyDto.setHistoryAmount(reservationDto.getPointUse());
			historyDto.setHistoryMemo("포인트 사용 취소");
			historyDao.insert(historyDto);
			
			int pointPercent = gradeDao.get(memberDto.getMemberGrade());
			int pointByPay = ((int)reservationDto.getTotalAmount() - reservationDto.getPointUse()) * pointPercent / 100;
			//예매 취소시 포인트 취소
			memberDao.usePoint(memberNo, pointByPay);
			historyDto.setMemberEmail(memberDto.getMemberEmail());
			historyDto.setHistoryAmount(pointByPay);
			historyDto.setHistoryMemo("포인트 적립금 취소");
			historyDao.insert(historyDto);
			
			attr.addAttribute("reservationNo", reservationNo);
//			return "redirect:history_detail";
			return "redirect:success_result?reservationNo="+reservationDto.getReservationNo();
		}
		
}
