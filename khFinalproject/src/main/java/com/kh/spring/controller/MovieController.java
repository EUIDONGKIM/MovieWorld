package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.ScheduleDto;

import oracle.jdbc.proxy.annotation.GetProxy;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	
	@GetMapping("/list")
	public String list() {//리스트를 찍으려면 뭔가가 필요합니다잉
		return "movie/list";//잊지마세요 뷰.리.졸.버 - 김동율 뷰! 리졸버~
	}
	
	@GetMapping("/insert")
	public String insert() {
		return "movie/insert";
	}
	
}
