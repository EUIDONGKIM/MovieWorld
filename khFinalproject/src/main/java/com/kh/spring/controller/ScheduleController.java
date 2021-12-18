package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.ScheduleDto;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.MovieDao;
import com.kh.spring.repository.ScheduleDao;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private ScheduleDao scheduleDao;
	
	@GetMapping("/list")
	public String create() {
		return "schedule/list";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("hallList", hallDao.list());
		model.addAttribute("movieList", movieDao.list());
		return "schedule/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		return "redirect:list";
	}
}
