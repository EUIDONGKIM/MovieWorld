package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.TheaterDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/theater")
@Slf4j
public class TheaterController {

	@Autowired
	private TheaterDao theaterDao;
	
	@GetMapping("/create")
	public String create() {
		log.debug("극장 생성 페이지");
		return "theater/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute TheaterDto theaterDto) {
		log.debug("theaterDto = {}",theaterDto);
		log.debug("극장번호 = {}",theaterDto.getTheaterNo());
		theaterDao.create(theaterDto);
		
		return "redirect:/theater/create";
	}
}
