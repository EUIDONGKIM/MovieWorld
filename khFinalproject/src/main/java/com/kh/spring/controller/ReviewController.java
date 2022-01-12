package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@GetMapping("/write")
	public String write() {
		return "review/write";
	}
	
	@GetMapping("/list")
	public String list() {
		return "review/list";
	}

}
