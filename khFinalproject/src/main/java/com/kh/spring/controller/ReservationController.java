package com.kh.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.ReservationDetailDto;
import com.kh.spring.entity.ReservationDto;
import com.kh.spring.entity.ReservationInfoViewDto;
import com.kh.spring.entity.SeatDto;
import com.kh.spring.repository.ReservationDao;
import com.kh.spring.repository.ReservationDetailDao;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.SeatDao;
import com.kh.spring.vo.ReservationVO;

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
	//테스트 상영시간 번호를 받았을때 좌석을 넘겨주는 과정,
		@GetMapping("/insert")
		public String test(@RequestParam int scheduleTimeNo,Model model) {
			//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
			
			//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
			//int sequence = reservationDao.getSequence();
			//임시 예약 테이블 생성.
			//ReservationDto reservationDto = new ReservationDto();
			//reservationDto.setReservationNo(sequence);
			//임시 예약 테이블 등록
			//reservationDao.insert(reservationDto);
			
			ReservationInfoViewDto reservationInfoViewDto = reservationInfoViewDao.get(scheduleTimeNo);
			int HallNo = reservationInfoViewDto.getHallNo();
			
			List<SeatDto> seatList = seatDao.list(HallNo);
			List<ReservationDetailDto> reservationDetailList = reservationDetailDao.list(scheduleTimeNo);
			
			List<ReservationVO> reservationVOList = new ArrayList<>();
			
			for(SeatDto seatDto : seatList) {
				ReservationVO reservationVO = new ReservationVO();
				
				reservationVO.setSeatNo(seatDto.getSeatNo());
				reservationVO.setSeatRows(seatDto.getSeatRows());
				reservationVO.setSeatCols(seatDto.getSeatCols());
				
				for(ReservationDetailDto reservationDetailDto : reservationDetailList) {
					if(seatDto.getSeatNo() == reservationDetailDto.getSeatNo()) {
						reservationVO.setSeatStatus("disabled");
						break;
					}else {
						reservationVO.setSeatStatus(seatDto.getSeatStatus());
					}
				}
				
				
				reservationVOList.add(reservationVO);
			}
			
			model.addAttribute("seatList",seatList);
			model.addAttribute("reservationInfoViewDto",reservationInfoViewDto);
			model.addAttribute("reservationVOList",reservationVOList);
			log.debug("reservationVOList는!!==========================={}",reservationVOList);
			
			//여기서 VO만드는 작업해서 VO를 넘긴다.
			return "reservation/insert";
		}
		
		@PostMapping("/insert")
		public String test(@RequestParam List<String> seat,@RequestParam int hallNo) {
			//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
			
			//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
			log.debug("seat=========={}",seat);
			log.debug("hallNo={}",hallNo);
			return "redirect:/";
		}
	
}
