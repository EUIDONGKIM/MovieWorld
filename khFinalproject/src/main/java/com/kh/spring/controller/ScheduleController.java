package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.schedule.ScheduleDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.schedule.ScheduleDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.schedule.ScheduleTimeDiscountDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.TheaterDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private ScheduleDao scheduleDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private ScheduleTimeDiscountDao scheduleTimeDiscountDao;
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private TheaterDao theaterDao;
	
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("TheaterList", theaterDao.list());
		model.addAttribute("movieList", movieDao.list());
		return "schedule/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		
		return "redirect:list";
	}
	
	@GetMapping("/create_total")
	public String createTotal(Model model) {
		model.addAttribute("movieList", movieDao.listByOpening());
		return "schedule/create_total";
	}
	
	@PostMapping("/create_total")
	public String createTotal(@ModelAttribute ScheduleDto scheduleDto) {
		
		List<TheaterDto> theaterList = theaterDao.list();
		for(TheaterDto theaterDto : theaterList) {
			scheduleDto.setTheaterNo(theaterDto.getTheaterNo());
			scheduleDao.insert(scheduleDto);
		}
		
		
		return "redirect:list";
	}
	
	//영화관 상세페이지에서 상영 영화 생성
	@GetMapping("/create2")
	public void create2(@RequestParam int theaterNo, Model model) {
		model.addAttribute("theaterDto",theaterDao.get(theaterNo));
		model.addAttribute("movieList", movieDao.listWithoutDuplicate(theaterNo));
	}
	@PostMapping("/create2")
	public String create2(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		
		return "redirect:/theater/detail?theaterNo="+scheduleDto.getTheaterNo();
	}
	
	
	@RequestMapping("/list")
	public String list(Model model) {
		model.addAttribute("totalInfoViewList", totalInfoViewDao.list());

		return "schedule/list";
	}
	
	@GetMapping("/time/create")
	public String timeCreate(@RequestParam int scheduleNo,Model model) {
		
		TotalInfoViewDto totalInfoViewDto = totalInfoViewDao.get(scheduleNo);
		model.addAttribute("hallList", hallDao.list(totalInfoViewDto.getTheaterNo()));
		model.addAttribute("totalInfoViewDto",totalInfoViewDto);
		model.addAttribute("scheduleTimeDiscountList", scheduleTimeDiscountDao.list());
		
		return "schedule/time/create";
	}
	
	@PostMapping("/time/create")
	public String timeCreate(@ModelAttribute ScheduleTimeDto scheduleTimeDto) {
		log.debug("디티오 ==== {}",scheduleTimeDto);
		scheduleTimeDao.insert(scheduleTimeDto);
		return "redirect:/";
	}
	
	
	@GetMapping("/edit")
	public String edit(@RequestParam int scheduleNo, Model model) {
		TotalInfoViewDto totalInfoViewDto = totalInfoViewDao.get(scheduleNo);
		model.addAttribute("totalInfoViewDto",totalInfoViewDto);
		
		return "schedule/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ScheduleDto scheduleDto) {
		boolean success = scheduleDao.edit(scheduleDto);
		if(success) {
			return "redirect:/schedule/list";
		}
		else {
			return "redirect:???"; //실패
		}
		
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam int scheduleNo) {
		boolean success = scheduleDao.delete(scheduleNo);
		if(success) {
			return "redirect:/schedule/list";
		}
		else {
			return "redirect:???"; //실패
		}
	}
	
}
