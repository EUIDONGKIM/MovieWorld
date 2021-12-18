package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.HallDto;
import com.kh.spring.repository.HallDao;


@Controller
@RequestMapping("/hall")
public class HallController {
	@Autowired
	private HallDao hallDao;
	
	@RequestMapping("/list")
	public String hallList(Model model) {
		return "hall/list";
	}
	
	@RequestMapping("/create")
	public String hallCreate(Model model) {
		model.addAttribute("hallTypeList", hallDao.getHallTypeList());
		
		return "hall/create";
	}
	
	@PostMapping("/create_seat")
	public String hallCreateSeat(Model model,@ModelAttribute HallDto hallDto) {
		int hallNo = hallDao.getSeq();
		hallDto.setHallNo(hallNo);
		hallDao.insert(hallDto);
		
		model.addAttribute("hallDto", hallDto);		
		return "hall/create_seat";
	}
}
