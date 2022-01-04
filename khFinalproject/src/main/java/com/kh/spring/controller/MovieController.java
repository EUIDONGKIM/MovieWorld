package com.kh.spring.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
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
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	
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
		
		Map<MovieDto,List<Map<TotalInfoViewDto,List<LastInfoViewDto>>>> sendList = new HashMap<>();
		List<MovieDto> movieList = movieDao.list();
		
		for(MovieDto movieDto : movieList) {
			List<Map<TotalInfoViewDto,List<LastInfoViewDto>>> movieValue = new ArrayList<>();
			
			List<TotalInfoViewDto> totalInfoList = totalInfoViewDao.list(movieDto.getMovieNo());
			
				for(TotalInfoViewDto totalInfoViewDto : totalInfoList) {
					Map<TotalInfoViewDto,List<LastInfoViewDto>> tempMap = new HashMap<>();
					List<LastInfoViewDto> list = lastInfoViewDao.listByScheduleNo(totalInfoViewDto.getScheduleNo());
					tempMap.put(totalInfoViewDto,list);
					
					movieValue.add(tempMap);
				}
				
			sendList.put(movieDto,movieValue);
		}
		
		model.addAttribute("sendList", sendList);
		return "movie/list";//잊지마세요 뷰.리.졸.버 - 김동율 뷰! 리졸버~
	}

	@GetMapping("/movieChart")
	public String movieChart() {
		return "movie/movieChart";
	}
	
	@GetMapping("/movieDetail")
		public String movieDetail() {
			return "movie/movieDetail";
		}
	
}
