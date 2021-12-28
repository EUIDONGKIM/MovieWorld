package com.kh.spring.controller;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.ReservationDetailDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.SeatDto;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.reservation.AgeDiscountDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.repository.reservation.ReservationDetailDao;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.vo.MovieCountVO;
import com.kh.spring.vo.ReservationVO;
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

	
		@RequestMapping("/")
		public String main(Model model) {
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
			
			model.addAttribute("movieCountVOList",movieList);
			model.addAttribute("theaterCityVOList",theaterList);
			model.addAttribute("dateList",dateList);
			
			return "reservation/main";
		}
}
