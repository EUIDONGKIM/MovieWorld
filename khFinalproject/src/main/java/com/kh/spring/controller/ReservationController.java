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

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.MemberDto;
import com.kh.spring.entity.ReservationDetailDto;
import com.kh.spring.entity.ReservationDto;
import com.kh.spring.entity.ReservationInfoViewDto;
import com.kh.spring.entity.SeatDto;
import com.kh.spring.repository.AgeDiscountDao;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.HallTypePriceDao;
import com.kh.spring.repository.MemberDao;
import com.kh.spring.repository.ReservationDao;
import com.kh.spring.repository.ReservationDetailDao;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.SeatDao;
import com.kh.spring.repository.TheaterDao;
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
	@Autowired
	private HallDao hallDao;
	
	//테스트 상영시간 번호를 받았을때 좌석을 넘겨주는 과정,
		@GetMapping("/insert")
		public String test(@RequestParam int scheduleTimeNo,Model model) {
			//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
			
			ReservationInfoViewDto reservationInfoViewDto = reservationInfoViewDao.get(scheduleTimeNo);
			int hallNo = reservationInfoViewDto.getHallNo();
			HallDto hallDto = hallDao.get(hallNo);
			
			List<SeatDto> seatList = seatDao.list(hallNo);
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
			
			model.addAttribute("scheduleTimeNo",scheduleTimeNo);
			model.addAttribute("hallDto",hallDto);
			model.addAttribute("reservationVOList",reservationVOList);
			log.debug("reservationVOList는!!==========================={}",reservationVOList);
			
			//여기서 VO만드는 작업해서 VO를 넘긴다.
			return "reservation/insert";
		}
		
		@PostMapping("/insert")
		public String test(@RequestParam List<String> seat,@RequestParam int scheduleTimeNo,HttpSession session) {
			//길기때문에 추후 서비스로 넘기거나 레스트 컨트롤러에서 처리하는 부분
			ReservationInfoViewDto reservationInfoViewDto = reservationInfoViewDao.get(scheduleTimeNo);
			
			//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
			int sequence = reservationDao.getSequence();
			//임시 예약 테이블 생성.
			ReservationDto reservationDto = new ReservationDto();
			
			reservationDto.setReservationNo(sequence);
			reservationDto.setMemberNo((int)session.getAttribute("memberNo"));
			reservationDto.setScheduleTimeNo(reservationInfoViewDto.getScheduleNo());
			reservationDto.setScheduleTimeDateTime(reservationInfoViewDto.getScheduleTimeDateTime());
			reservationDto.setReservationStatus("미결제");
			//임시 예약 테이블 등록
			reservationDao.insert(reservationDto);
			
			//결제 전에 사용자간의 중복 예매를 방지하기 위해서 카카오 결제 전에 선 insert 시행
			

			//좌석 번호 받는 방법. => 홀번호와 좌석 행, 열 번호로 좌석번호를 알아 낼 수 있다.(데이터가 몇개 없으니까 이방법으로..)
			//상영관 종류 및 연령 등 DAO로 불러오기. 추가하기
			//초기 상태는 미결제
			
			String hallType = reservationInfoViewDto.getHallType();
			int hallPrice = hallTypePriceDao.getPrice(hallType);
					
			int memberNo = (int)session.getAttribute("memberNo");
			//MemberDto memberDto = memberDao.get(memberNo);		
			MemberDto memberDto = new MemberDto();
			
			LocalDate today = LocalDate.now();
			int memberYear = Integer.parseInt(memberDto.getMemberBirth().substring(0, 4));
			int age = today.getYear() - memberYear + 1;
			String ageName;
			
			if(age<20) ageName = "청소년";
			else if(age >=20 && age < 65) ageName = "일반";
			else ageName ="경로";
			
			int ageDicountPrice = ageDiscountDao.getPrice(ageName);
			
			
			
			for(String s : seat) {
				
				ReservationDetailDto reservationDetailDto = new ReservationDetailDto();
				
				reservationDetailDto.setReservationNo(reservationDto.getReservationNo());
				reservationDetailDto.setScheduleTimeNo(scheduleTimeNo);
				reservationDetailDto.setHallType(hallType);
				reservationDetailDto.setHallPrice(hallPrice);
				reservationDetailDto.setAgeName(ageName);
				reservationDetailDto.setAgeDiscountPrice(ageDicountPrice);
				reservationDetailDto.setScheduleTimeDiscountType(reservationInfoViewDto.getScheduleTimeDiscountType());
				reservationDetailDto.setScheduleTimeDiscountPrice(reservationInfoViewDto.getScheduleTimeDiscountPrice());
				reservationDetailDto.setReservationDetailStatus("미결제");
				
				StringTokenizer st = new StringTokenizer(s,"-");
				
				while(st.hasMoreTokens()) {
					reservationDetailDto.setSeatRows(Integer.parseInt(st.nextToken()));
					reservationDetailDto.setSeatCols(Integer.parseInt(st.nextToken()));
				}
				int seatNo = seatDao.getSeatNo(reservationInfoViewDto.getHallNo(),reservationDetailDto.getSeatRows(),reservationDetailDto.getSeatCols());
				reservationDetailDto.setSeatNo(seatNo);
				
				}
				
			
			
			
			
			
			//예약상세에서 홀번호에 해당하는 예약된 좌석번호도 추후에 넘겨준다.
			log.debug("seat=========={}",seat);
			return "redirect:/";
		}
		
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
