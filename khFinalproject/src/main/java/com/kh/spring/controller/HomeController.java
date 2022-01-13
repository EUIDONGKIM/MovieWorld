package com.kh.spring.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.service.MovieService;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.OrderByRatio;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private MovieService movieService;
	
	@RequestMapping("/")
	public String home(Model model) {
		List<Integer> movieNoList = totalInfoViewDao.nowMoiveList();
		List<MovieChartVO> nowListTemp = movieService.getChartList(movieNoList,1);
		Collections.sort(nowListTemp,new OrderByRatio());
		
		List<Integer> soonMovieList = totalInfoViewDao.soonMovieList();
		List<MovieChartVO> soonList = movieService.getChartList(soonMovieList,1);
		Collections.sort(soonList,new OrderByRatio());
		
		List<MovieChartVO> nowList = new ArrayList<>();
		for(int i = 0 ; i<10 ;i++) {
			nowList.add(nowListTemp.get(i));
		}
		model.addAttribute("nowList",nowList);
		model.addAttribute("soonList",soonList);
		return "home";
	}
	
	
	
}
