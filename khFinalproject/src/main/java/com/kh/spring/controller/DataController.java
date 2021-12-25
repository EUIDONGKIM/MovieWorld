package com.kh.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.TheaterDto;
import com.kh.spring.repository.ReservationInfoViewDao;
import com.kh.spring.repository.TheaterDao;
import com.kh.spring.vo.MovieCountVO;


@RestController
@RequestMapping("/data")
public class DataController {
	
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private ReservationInfoViewDao reservationInfoViewDao;
	
	@GetMapping("/getHalls")
	public List<TheaterDto> getHalls(@RequestParam String city) throws UnsupportedEncodingException {
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.
		
		return theaterDao.listByCity(cityName);
	}
	
	@GetMapping("/getTotal1")
	public List<MovieCountVO> getTotal1(){
		return reservationInfoViewDao.listMoiveByCount();
	}
	
	@GetMapping("/getTotal2")
	public List<MovieCountVO> getTotal2(@RequestParam int movieNo){
		return reservationInfoViewDao.listMoiveByCount();
	}
	
	@GetMapping("/getTheaters")
	public List<TheaterDto> getTheaters(String city) throws UnsupportedEncodingException{
		String cityName = URLDecoder.decode(city, "UTF-8"); //디코딩을 해야 값이 들어간다.

		return theaterDao.listByCity2(cityName);
	}
}
