package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/price")
@Slf4j
public class PriceController {

	@GetMapping("/admin/hall_type_price")
	public String hall() {
		return "/price/hall_type_price";
	}
	
	@GetMapping("/admin/age_discount")
	public String age() {
		return "/price/age_discount";	
	}
	
	@GetMapping("/admin/schedule_time_discount")
	public String scheduleTime() {
		return "/price/schedule_time_discount";	
	}
}
