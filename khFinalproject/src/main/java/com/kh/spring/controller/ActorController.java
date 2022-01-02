package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.schedule.ScheduleDto;
import com.kh.spring.repository.actor.ActorDao;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.GetProxy;

@Slf4j
@Controller
@RequestMapping("/actor")
public class ActorController {
	
	@Autowired
	private ActorDao actorDao;
	
	@GetMapping("/insert")
	public String insert() {
		return "actor/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ActorDto actorDto) {
		actorDao.insert(actorDto);
		
		return "actor/insert";
//		return"redirect:/actor/detail?actorNo="+actorDto.getActorNo();
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", actorDao.list());
		return "actor/list";
	}
	
}
