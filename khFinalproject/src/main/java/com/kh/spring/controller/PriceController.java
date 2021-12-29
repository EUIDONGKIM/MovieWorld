package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
public class PriceController {

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
	
}
