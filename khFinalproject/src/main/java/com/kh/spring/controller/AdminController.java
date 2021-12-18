package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping("/")
	public String adminHome() {
		return "admin/main";
	}
	
	@RequestMapping("/theater")
	public String adminTheater() {
		return "admin/theater";
	}
	
	@RequestMapping("/hall")
	public String adminHall() {
		return "admin/hall";
	}
	
}
