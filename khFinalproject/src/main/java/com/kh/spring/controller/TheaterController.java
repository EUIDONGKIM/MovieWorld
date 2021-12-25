package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.vo.TheaterCityVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/theater")
@Slf4j
public class TheaterController {

	@Autowired
	private TheaterDao theaterDao;
	
	@GetMapping("/create")
	public String create() {
		return "theater/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute TheaterDto theaterDto) {
		theaterDao.create(theaterDto);
		
		return "redirect:/theater/detail?theaterNo="+theaterDto.getTheaterNo();
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute TheaterCityVO theaterCityVO, Model model) {
		List<TheaterCityVO> list = theaterDao.cityList();
		model.addAttribute("cityList",list);
		
		return "theater/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int theaterNo, Model model) {
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		model.addAttribute("theaterDto",theaterDto);
		
		return "theater/detail";
	}
}
