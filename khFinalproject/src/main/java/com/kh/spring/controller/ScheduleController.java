package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.ScheduleDto;
import com.kh.spring.entity.ScheduleTimeDto;
import com.kh.spring.entity.TotalInfoViewDto;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.MovieDao;
import com.kh.spring.repository.ScheduleDao;
import com.kh.spring.repository.ScheduleTimeDao;
import com.kh.spring.repository.ScheduleTimeDiscountDao;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.repository.TotalInfoViewDao;

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
	
	//추후에 hall movie schedule 뷰를 만드는게 편할 수 있음(조회시에.!)
	@PostMapping("/create")
	public String create(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		
		return "redirect:list";
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
