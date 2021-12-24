package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.HallDto;
import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.HallDao;
import com.kh.spring.repository.HallTypePriceDao;
import com.kh.spring.repository.TheaterDao;


@Controller
@RequestMapping("/hall")
public class HallController {
	@Autowired
	private HallDao hallDao;
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private HallTypePriceDao hallTypePriceDao;
	
	@RequestMapping("/list")
	public String hallList(Model model) {
		return "hall/list";
	}
	
	@RequestMapping("/create")
	public String hallCreate(Model model) {
		model.addAttribute("hallTypeList", hallDao.getHallTypeList());
		model.addAttribute("theaterList",theaterDao.list());
		return "hall/create";
	}
	
	@GetMapping("/create2")
	public String hallCreate2(@RequestParam int theaterNo, Model model) {
		
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		
		model.addAttribute("theaterDto",theaterDto);
		model.addAttribute("hallTypeList", hallTypePriceDao.list());
		
		return "hall/create2";
	}
	
	
	@GetMapping("/create_seat")
	public String test() {
		return "hall/create_seat";
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
