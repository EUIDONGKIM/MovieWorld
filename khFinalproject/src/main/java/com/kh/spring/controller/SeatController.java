package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.service.SeatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seat")
@Slf4j
public class SeatController {
	
	@Autowired
	private SeatService seatService;
	
	@PostMapping("/insert")
	public String insert(@RequestParam List<String> seat,@RequestParam int hallNo) {
		log.debug("seat List 받은 값{}",seat);
		log.debug("hallNo 받은 값{}",hallNo);
		
		seatService.setSeatandUpdateHall(seat,hallNo);
		
		return "redirect:/";
	}
}
