package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@GetMapping("/403")
	public String fourzerothree() {
		return "error/403";
	}
	
	@GetMapping("/404")
	public String fourzerofour() {
		return "error/404";
	}
	
	@GetMapping("/500")
	public String fiveZeroZero() {
		return "error/500";
	}
	

	
}


