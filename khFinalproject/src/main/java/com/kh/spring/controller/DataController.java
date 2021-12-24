package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.entity.TotalInfoViewDto;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.repository.TotalInfoViewDao;

@RestController
@RequestMapping("/data")
public class DataController {
	
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	
	@GetMapping("/getHalls")
	public List<TheaterDto> getHalls(@RequestParam String city) throws UnsupportedEncodingException {
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.
		
		return theaterDao.listByCity(cityName);
	}
	
	@GetMapping("/getTotal1")
	public List<TotalInfoViewDto> getTotal1(){
		return totalInfoViewDao.list();
	}
	
	@GetMapping("/getTotal2")
	public List<TotalInfoViewDto> getTotal2(@RequestParam int movieNo){
		return totalInfoViewDao.list(movieNo);
	}
	
	@GetMapping("/getTheaters")
	public List<TheaterDto> getTheaters(String city) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.

		return theaterDao.listByCity2(cityName);
	}
}
