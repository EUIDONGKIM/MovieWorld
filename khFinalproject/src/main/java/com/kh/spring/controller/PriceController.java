package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/price")
@Slf4j
public class PriceController {

	@GetMapping("/hall_type_price")
	public void hall() {
	}
	
	@GetMapping("/age_discount")
	public void age() {
	}
	
	@GetMapping("/schedule_time_discount")
	public void scheduleTime() {
	}
}
