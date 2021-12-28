package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.schedule.ScheduleDto;

import oracle.jdbc.proxy.annotation.GetProxy;

@Controller
@RequestMapping("/actor")
public class ActorController {
	
	
	@GetMapping("/list")
	public String list() {//리스트를 찍으려면 뭔가가 필요합니다잉
		return "actor/list";
	}
	
	@GetMapping("/insert")
	public String insert() {
		return "actor/insert";
	}
	
}
