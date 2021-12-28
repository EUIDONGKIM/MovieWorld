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

import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.vo.TheaterCityVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
		model.addAttribute("theaterCityVOList",theaterDao.cityList());
		log.debug("theaterCityVOList 확인!!!{}",theaterDao.cityList());
		return "hall/create";
	}
	
	@GetMapping("/create2")
	public String hallCreate2(@RequestParam int theaterNo, Model model) {
		
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		int hallCount = hallDao.hallCount(theaterNo);
		model.addAttribute("hallCount",hallCount);
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
	
	@GetMapping("/delete")
	public String hallDelete(@RequestParam int hallNo) {
		HallDto hallDto = hallDao.get(hallNo);
		int theaterNo = hallDto.getTheaterNo(); //리다이렉트용 
		
		boolean success = hallDao.delete(hallNo);
		if(success) {
			return "redirect:/theater/detail?theaterNo="+theaterNo;
		}
		else {
			return "redirect:/???"; //실패
		}
	}
}
