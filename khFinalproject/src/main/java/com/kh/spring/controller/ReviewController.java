package com.kh.spring.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/review")
public class ReviewController {
	
	@GetMapping("/write")
	public String write() {
		return "review/write";
	}
}
