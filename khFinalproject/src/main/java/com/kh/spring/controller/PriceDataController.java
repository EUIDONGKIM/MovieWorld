package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.reservation.AgeDiscountDto;
import com.kh.spring.entity.schedule.ScheduleTimeDiscountDto;
import com.kh.spring.entity.theater.HallTypePriceDto;
import com.kh.spring.repository.reservation.AgeDiscountDao;
import com.kh.spring.repository.schedule.ScheduleTimeDiscountDao;
import com.kh.spring.repository.theater.HallTypePriceDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController 
@RequestMapping("/price")
public class PriceDataController {

	@Autowired
	private HallTypePriceDao hallTypePriceDao;
	
	@Autowired
	private AgeDiscountDao ageDiscountDao;
	
	@Autowired
	private ScheduleTimeDiscountDao scheduleTimeDiscountDao;
	
	@GetMapping("/getHallTypePriceList")
	public List<HallTypePriceDto> hallTypeList() {
		return hallTypePriceDao.list();
	}
	
	@GetMapping("/getAgeDiscountList")
	public List<AgeDiscountDto> ageDiscountList(){
		return ageDiscountDao.list();
	}
	
	@GetMapping("/getScheduleTimeDiscountList")
	public List<ScheduleTimeDiscountDto> scheduleTimeDiscountList(){
		return scheduleTimeDiscountDao.list();
	}
	
	@DeleteMapping("/deleteAgeDiscount")
	public boolean deleteAgeDiscount(@RequestParam int ageNo) {
		return ageDiscountDao.delete(ageNo);
	}
	@DeleteMapping("/deleteHallTypePrice")
	public boolean deleteHallTypePrice(@RequestParam int hallTypeNo) {
		return hallTypePriceDao.delete(hallTypeNo);
	}
	@DeleteMapping("/deleteScheduleTimeDiscount")
	public boolean deleteSceduleTimeDiscount(@RequestParam int scheduleTimeDiscountNo) {
		return scheduleTimeDiscountDao.delete(scheduleTimeDiscountNo);
	}
	
	@PostMapping("/insertAgeDiscount")
	public void insertAgeDiscount(@ModelAttribute AgeDiscountDto ageDiscountDto) {
		ageDiscountDao.insert(ageDiscountDto);
	}
	@PostMapping("/insertHallTypePrice")
	public void insertHallTypePrice(@ModelAttribute HallTypePriceDto hallTypePriceDto) {
		hallTypePriceDao.insert(hallTypePriceDto);
	}
	@PostMapping("/insertScheduleTimeDiscount")
	public void insertScheduleTimeDiscount(@ModelAttribute ScheduleTimeDiscountDto scheduleTimeDiscountDto) {
		scheduleTimeDiscountDao.insert(scheduleTimeDiscountDto);
	}
	
	@PostMapping("/editAgeDiscount")
	public void editAgeDiscount(@ModelAttribute AgeDiscountDto ageDiscountDto) {
		ageDiscountDao.edit(ageDiscountDto);
	}
	@PostMapping("/editHallTypePrice")
	public void editHallTypePrice(@ModelAttribute HallTypePriceDto hallTypePriceDto) {
		hallTypePriceDao.edit(hallTypePriceDto);
	}
	@PostMapping("/editScheduleTimeDiscount")
	public void editScheduleTimeDiscount(@ModelAttribute ScheduleTimeDiscountDto scheduleTimeDiscountDto) {
		scheduleTimeDiscountDao.edit(scheduleTimeDiscountDto);
	}

	
}
