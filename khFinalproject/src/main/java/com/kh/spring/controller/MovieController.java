package com.kh.spring.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.service.MovieService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ActorDao actorDao;
	
	
	@GetMapping("/insert")
	public String insert() {
		return "movie/insert";
	}
		
	@PostMapping("/insert")
	public String insert(
			@ModelAttribute MovieDto movieDto,
			@RequestParam MultipartFile photo,
			@RequestParam List<MultipartFile> attach
			) throws IllegalStateException, IOException {
		
		int sequence = movieService.insert(movieDto,photo,attach);
		
		return "redirect:/movie/insert_actor?movieNo="+sequence;
	}
	
	@GetMapping("/insert_actor")
	public String insertActor(Model model,@RequestParam int movieNo) {
		model.addAttribute("movieNo",movieNo);
		return "movie/insert_actor";
	}
	
	@RequestMapping("/insert_popup")
	public String insertPopup(
			@RequestParam String actorJob,
			Model model) throws UnsupportedEncodingException {

		model.addAttribute("actorList",actorDao.listByJob(actorJob));
		model.addAttribute("actorJob",actorJob);
		
		return "movie/insert_actor_popup";
	}
	
	@GetMapping("/list")
	public String list(Model model) {//리스트를 찍으려면 뭔가가 필요합니다잉
		model.addAttribute("list", movieDao.list());
		return "movie/list";//잊지마세요 뷰.리.졸.버 - 김동율 뷰! 리졸버~
	}
	
	
	
	
}
