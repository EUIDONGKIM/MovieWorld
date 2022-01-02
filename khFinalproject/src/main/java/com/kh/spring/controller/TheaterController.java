package com.kh.spring.controller;


import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.time.LocalDate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.entity.reservation.ReservationInfoViewDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.reservation.ReservationInfoViewDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.vo.TheaterCityVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/theater")
@Slf4j
public class TheaterController {

	@Autowired
	private TheaterDao theaterDao;
	
	@Autowired
	private HallDao hallDao;
	
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	@GetMapping("/create")
	public String create() {
		return "theater/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute TheaterDto theaterDto) {
		theaterDao.create(theaterDto);
		
		return "redirect:/theater/detail?theaterNo="+theaterDto.getTheaterNo();
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute TheaterCityVO theaterCityVO, Model model) {
		List<TheaterCityVO> list = theaterDao.cityList();
		model.addAttribute("cityList",list);
		
		return "theater/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int theaterNo, Model model) {
		LocalDate today = LocalDate.now();
		List<LocalDate> dateList = new ArrayList<>();	
		for(int i = 0 ; i < 7 ; i++) {
			dateList.add(today.plusDays(i));
		}
		model.addAttribute("dateList",dateList);
		model.addAttribute("theaterDto",theaterDao.get(theaterNo));
		model.addAttribute("hallList",hallDao.list(theaterNo));
		model.addAttribute("scheduleList", totalInfoViewDao.listByTheater(theaterNo));
		int count = 100;

		Calendar c = Calendar.getInstance();

		//c.add(Calendar.DATE, 1);

		Date d = c.getTime();

		Format f = new SimpleDateFormat("yyyy-MM-dd");
		
		String today = f.format(d);
		
		List<ReservationInfoViewDto> reservationInfoViewList1 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList2 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList3 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList4 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList5 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList6 = new ArrayList<>();
		List<ReservationInfoViewDto> reservationInfoViewList7 = new ArrayList<>();
		
		List<ReservationInfoViewDto> reservationInfoViewList = reservationInfoViewDao.getByTheater(theaterNo);
		for(ReservationInfoViewDto reservationInfoViewDto : reservationInfoViewList) {
			reservationInfoViewDto.getScheduleTimeDateTime().equals(today);
		}
		
		return "theater/detail";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int theaterNo, Model model) {
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		model.addAttribute("theaterDto",theaterDto);
		
		return "theater/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute TheaterDto theaterDto, RedirectAttributes redirectAttributes) {
		boolean success = theaterDao.edit(theaterDto);
		if(success) {
			redirectAttributes.addAttribute("theaterNo", theaterDto.getTheaterNo());
			redirectAttributes.addFlashAttribute("editResult","editSuccess");
		}
		return "redirect:/theater/detail";
		
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam int theaterNo, RedirectAttributes redirectAttributes) {
		boolean success = theaterDao.delete(theaterNo);
		if(success) {
			redirectAttributes.addFlashAttribute("deleteResult","deleteSuccess");
		}
		return "redirect:/theater/list";//성공하면 목록으로
	}
}
