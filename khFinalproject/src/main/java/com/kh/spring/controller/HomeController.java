package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.ReservationInfoViewDto;
import com.kh.spring.entity.SeatDto;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.SeatDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	@Autowired
	private SeatDao seatDao;

	@RequestMapping("/")
	public String home(Model model) {
		return "home";
	}
	
	//테스트 상영시간 번호를 받았을때 좌석을 넘겨주는 과정,
	@GetMapping("/test")
	public String test(@RequestParam int scheduleTimeNo,Model model) {
		//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
		
		//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
		
		ReservationInfoViewDto reservationInfoViewDto = reservationInfoViewDao.get(scheduleTimeNo);
		int HallNo = reservationInfoViewDto.getHallNo();
		List<SeatDto> seatList = seatDao.list(HallNo);
		model.addAttribute("seatList",seatList);
		model.addAttribute("reservationInfoViewDto",reservationInfoViewDto);
		
		return "test/test";
	}
	
	@PostMapping("/test")
	public String test(@RequestParam List<String> seat) {
		//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
		
		//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
		log.debug("seat=========={}",seat);
		return "redirect:/";
	}
	
}
