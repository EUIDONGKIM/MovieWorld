package com.kh.spring.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.service.ActorService;
import com.kh.spring.vo.PaginationActorVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/actor")
public class ActorController {
	
	@Autowired
	private ActorDao actorDao;
	@Autowired
	private ActorService actorService;
	
	@GetMapping("/insert")
	public String insert() {
		return "actor/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ActorDto actorDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int sequence = actorService.insert(actorDto,attach);
		
		return "redirect:/actor/list";
//		return "redirect:/movie/detail?actorNo="+sequence;
//		return"redirect:/actor/detail?actorNo="+actorDto.getActorNo();
	}
	
	//@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", actorDao.list());
		return "actor/list";
	}
	@GetMapping("/list")
	public String list(
			@ModelAttribute PaginationActorVO paginationActorVO,
			Model model) throws Exception {
		model.addAttribute("PaginationActorVO",actorService.serachPage(paginationActorVO));
		return "actor/list";
	}
	@GetMapping("/delete")
	public String delete(@RequestParam int actorNo) throws Exception {
		actorDao.delete(actorNo);
		return "redirect:/actor/list";
	}
	
}
