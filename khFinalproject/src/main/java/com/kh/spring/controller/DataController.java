package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.TheaterDao;

@RestController
@RequestMapping("/data")
public class DataController {
	
	@Autowired
	private TheaterDao theaterDao;
	
	@GetMapping("/getHalls")
	public List<TheaterDto> getHalls(@RequestParam int city) {
		String cityName = "";
		if(city == 1) cityName = "서울";
		if(city == 2) cityName = "대구";
		
		return theaterDao.listByCity(cityName);
	}
}
