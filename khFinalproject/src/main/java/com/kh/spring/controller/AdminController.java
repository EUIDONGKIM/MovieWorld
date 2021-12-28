package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@RequestMapping("/schedule")
	public String main() {
		return "admin/schedule";
	}
	
	@GetMapping("/movieInfo")
	public String adminMovieInfo() {
		return "admin/movieInfo";
	}
	
	@GetMapping("/actorInfo")
	public String adminActorInfo() {
		return "admin/actorInfo";
	}
	
	@GetMapping("/price")
	public String adminPrice() {
		return "admin/price";
	}
}
