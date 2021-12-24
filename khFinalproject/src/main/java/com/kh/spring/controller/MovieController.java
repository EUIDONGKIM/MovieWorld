package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.ScheduleDto;

@Controller
@RequestMapping("/admin")
public class MovieController {
	
	@GetMapping("/movieInfo")
		public String insert() {
		
		return "admin/movieInfo";
	}
	
	
	
}
