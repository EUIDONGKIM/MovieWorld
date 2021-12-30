package com.kh.spring.controller;

import java.net.URISyntaxException;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.AgeDiscountDao;
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
	
		@RequestMapping("/")
		public String main(Model model,HttpSession session) {
			//초기화면 10일치 날짜 생성.
			List<String> dateList = new ArrayList<>();
			Format f = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			for(int i = 1 ;  i <= 10 ; i++) {
				Date d = c.getTime();
				dateList.add(f.format(d));
				c.add(Calendar.DATE, 1);
			}
			//초기 화면 보여줄 시에, 예매율이 높은 순으로 보여준다.
			
			List<MovieCountVO> movieList = reservationInfoViewDao.listMoiveByCount();
			List<TheaterCityVO> theaterList = theaterDao.cityList();
			String memberEmail = (String)session.getAttribute("ses");
			
			
			model.addAttribute("memberEmail",memberEmail);
			return "reservation/main";
		}
		
		@PostMapping("/confirm")
		public String confirm(@RequestParam int reservationNo,HttpSession session) throws URISyntaxException {
			ReservationDto reservationDto = reservationDao.get(reservationNo);
			List<ReservationDetailDto> rList = reservationDetailDao.get(reservationNo);
			
			String item_name = String.valueOf(rList.get(0).getSeatRows())+"행"+
					String.valueOf(rList.get(0).getSeatCols())+"열";

			if(rList.size()>1)
			item_name += " 외 "+(rList.size()-1)+"건";
			
			long total = (long)reservationDto.getTotalAmount();
			
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
		
			session.removeAttribute("partner_order_id");
			session.removeAttribute("partner_user_id");
			session.removeAttribute("tid");
			
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
			reservationDao.approve(reservationDto);
			
			reservationDetailDao.approve(reservationDto.getReservationNo());
			//모두 완료되면 해당 회차의 총 인원과 총 금액을 업데이트 시켜준다.
			ScheduleTimeDto scheduleTimeDto = new ScheduleTimeDto();
			scheduleTimeDto.setScheduleTimeNo(reservationDto.getScheduleTimeNo());
			scheduleTimeDto.setScheduleTimeCount(reservationDto.getReservationTotalNumber());
			scheduleTimeDto.setScheduleTimeSum((int)reservationDto.getTotalAmount());
			scheduleTimeDao.reservationUpdate(scheduleTimeDto);
			
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
			
			model.addAttribute("reservationDto",reservationDto);
			model.addAttribute("reservationInfoViewDto",reservationInfoViewDto);
			model.addAttribute("hallDto",hallDto);
			
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
			

			model.addAttribute("reservationDto",reservationDto);
			model.addAttribute("rList",rList);
			model.addAttribute("responseVO",responseVO);
			
			return "reservation/history_detail";
		}
		
		@GetMapping("/cancel")
		public String cancel(@RequestParam int reservationNo, RedirectAttributes attr) throws URISyntaxException {
			//(1) 요청한 결제내역이 전체취소라면 더이상 진행하면 안된다
			ReservationDto reservationDto = reservationDao.get(reservationNo);

			//(2) 취소 가능한 금액을 계산해야 한다
			long amount = reservationDto.getTotalAmount();

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
			
			attr.addAttribute("reservationNo", reservationNo);
			return "redirect:history_detail";
		}
		
}
