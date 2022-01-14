package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.entity.theater.HallDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.HallTypePriceDao;
import com.kh.spring.repository.theater.SeatDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.HallService;

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
	@Autowired
	private SeatDao seatDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private HallService hallService;
	
	@RequestMapping("/list")
	public String hallList(Model model) {
		return "hall/list";
	}
	
	@RequestMapping("/admin/create")
	public String hallCreate(Model model) {
		model.addAttribute("hallTypeList", hallDao.getHallTypeList());
		model.addAttribute("theaterCityVOList",theaterDao.cityList());
		log.debug("theaterCityVOList 확인!!!{}",theaterDao.cityList());
		return "hall/create";
	}
	
	@GetMapping("/admin/create2")
	public String hallCreate2(@RequestParam int theaterNo, Model model) {
		
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		int hallCount = hallDao.hallCount(theaterNo);
		model.addAttribute("hallCount",hallCount);
		model.addAttribute("theaterDto",theaterDto);
		model.addAttribute("hallTypeList", hallTypePriceDao.list());
		
		return "hall/create2";
	}
	
	
	@GetMapping("/admin/create_seat")
	public String test() {
		return "hall/create_seat";
	}
	
	@PostMapping("/admin/create_seat")
	public String hallCreateSeat(Model model,@ModelAttribute HallDto hallDto) {
		int hallNo = hallDao.getSeq();
		hallDto.setHallNo(hallNo);
		hallDao.insert(hallDto);
		
		model.addAttribute("hallDto", hallDto);		
		return "hall/create_seat";
	}
	
	@RequestMapping("/admin/delete")
	public String hallDelete(@RequestParam int hallNo, RedirectAttributes redirectAttributes) {
		HallDto hallDto = hallDao.get(hallNo);
		int theaterNo = hallDto.getTheaterNo(); //리다이렉트용 
		
		hallService.delete(hallNo);
		redirectAttributes.addAttribute("theaterNo",theaterNo);
		
		return "redirect:/theater/detail";
	}
	
	@GetMapping("/admin/detail")
	public String hallDetail(@RequestParam int hallNo, Model model) {
		HallDto hallDto = hallDao.get(hallNo);
		model.addAttribute("theaterDto",theaterDao.get(hallDto.getTheaterNo()));
		model.addAttribute("hallDto",hallDto);
		model.addAttribute("seatList", seatDao.list(hallNo));
		
		return "/hall/detail";
	}
	
	@GetMapping("/admin/update_seat")
	public String hallupdateSeat(@RequestParam int hallNo, Model model) {
		HallDto hallDto = hallDao.get(hallNo);
		
		model.addAttribute("isScheduleTimeExist",scheduleTimeDao.isScheduleTimeExist(hallNo));
		model.addAttribute("theaterDto",theaterDao.get(hallDto.getTheaterNo()));
		model.addAttribute("hallDto",hallDto);
		model.addAttribute("seatList", seatDao.list(hallNo));
		return "/hall/update_seat";
	}
	
	@GetMapping("/admin/edit")
	public String hallEdit(@RequestParam int hallNo, Model model) {
		HallDto hallDto = hallDao.get(hallNo);
		
		model.addAttribute("isScheduleTimeExist",scheduleTimeDao.isScheduleTimeExist(hallNo));
		model.addAttribute("hallDto",hallDto);
		model.addAttribute("hallTypeList", hallTypePriceDao.list());
		
		return "/hall/edit";
	}
	
	@PostMapping("/admin/edit")
	public String hallEdit(@ModelAttribute HallDto hallDto, RedirectAttributes redirectAttributes) {
		hallService.edit(hallDto);;
		redirectAttributes.addAttribute("hallNo",hallDto.getHallNo());
		return "redirect:/hall/admin/detail";
	}
}
